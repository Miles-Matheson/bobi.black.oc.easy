//
//  LKPickerViewController.m
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import "LKPickerViewController.h"

@interface LKPickerViewController ()<LKWSYPickerDelegate,LKWSYPickerDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView  *backView;

@property(nonatomic,assign)LKWSYPickerType   type;

@property(nonatomic,assign)LKWSYPickerStyleType   styleType;

@property(nonatomic,assign)CGFloat   pickHeight;

@property(nonatomic,strong)UIView    *customView;

@property(nonatomic,assign)CGPoint    startPoint;

@property(nonatomic,assign)CGPoint    endPoint;

@property(nonatomic,assign) BOOL      is_Showkeyboard;
@end

@implementation LKPickerViewController


-(instancetype)initWithContentAnmationType:(LKWSYPickerContentAnmationType)anmationType{
    if (self == [super init]) {
        _pickHeight = 380.0f;
        _ContentAnmationType = anmationType;
        _type = LKWSYPickerType_picker;
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        _pickHeight = 380.0f;
        _ContentAnmationType = LKWSYPickerContentAnmation_none;
        _type = LKWSYPickerType_picker;
        self.is_Showkeyboard = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    self.view.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer  *tapGester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissTheCotnentView)];
//    tapGester.delegate = self;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.backView];
//    [self.backView addGestureRecognizer:tapGester];
    [self.backView addSubview:self.pickerView];
   [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardDidShow{
    self.is_Showkeyboard = YES;
}
-(void)keyboardDidHide{
    self.is_Showkeyboard = NO;
}
#pragma mark--UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIView class]]) {
        UIView * backView =  touch.view;
        if (backView.tag == 998) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

-(void)dissmissTheCotnentView{
    if (self.is_Showkeyboard) {
        self.is_Showkeyboard  =NO;
        [self.view endEditing:YES];
        return;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(lkwsyWillDisApperar)]) {
        [_delegate lkwsyWillDisApperar];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyContentDisAppearAction)]) {
        [_delegate lkwsyContentDisAppearAction];
    }else{
      [self pickerDownAnmation];
    }
}

-(void)setDelegate:(id<LKWSYPickerDelegate>)delegate{
    _delegate = delegate;
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerType)]) {
        _type = [_delegate lkwsyPickerType];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerStyleType)]) {
        _styleType = [_delegate lkwsyPickerStyleType];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerViewCustomBackContentView)]) {
        _customView = [_delegate lkwsyPickerViewCustomBackContentView];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerHeight)]) {
        _pickHeight = [_delegate lkwsyPickerHeight];
    }
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _backView.tag = 998;
    }
    return _backView;
}

-(LKPickerBackView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[LKPickerBackView alloc]initWithFrame:CGRectMake(0, KHeight,KWidth ,_pickHeight)];
    }
    return _pickerView;
}

-(void)pickerDownAnmation{
    [self disApperThePickerAnimation];
}

-(void)setType:(LKWSYPickerType)type{
    _type = type;
}

-(void)setPickHeight:(CGFloat)pickHeight{
    _pickHeight = pickHeight;
}

-(void)setStyleType:(LKWSYPickerStyleType)styleType{
    _styleType = styleType;
}

-(LKWSYPickerType)lkwsyPickerType{
      
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerType)]) {
        _type = [_delegate lkwsyPickerType];
    }
    return _type;
}

-(LKWSYPickerStyleType)lkwsyPickerStyleType{
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerStyleType)]) {
        return  [_delegate lkwsyPickerStyleType];
    }
    return LKWSYPickerStyle_sheet;
}

-(UIView *)lkwsyPickerViewCustomBackContentView{
    _customView = [_delegate lkwsyPickerViewCustomBackContentView];
    float sizeWith = _customView.frame.size.width;
    float sizeHeight = _customView.frame.size.height;
    self.pickerView.bounds = CGRectMake(0, 0, sizeWith, sizeHeight);
    return _customView;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self ApperThePickerAnimation];
}

-(void)lkPickerViewWithDataArr:(NSArray *)dataArray SelectWithBlock:(void (^)(NSString * _Nonnull, NSInteger))block{
    [self.pickerView lkpickerViewWithData:[NSMutableArray arrayWithArray:dataArray] AndTheSelectedWithBlock:block];
}

//出现的动画
-(void)ApperThePickerAnimation{
    LKWSYPickerStyleType   styleType = LKWSYPickerStyle_sheet;
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerStyleType)]) {
        styleType = [_delegate lkwsyPickerStyleType];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyWillAppear)]) {
        [_delegate lkwsyWillAppear];
    }
    switch (styleType) {
        case LKWSYPickerStyle_sheet:
        {
            _endPoint = CGPointMake(KWidth/2, KHeight - self->_pickHeight/2);
        }
            break;
        case LKWSYPickerStyle_center:
        {
            _endPoint = CGPointMake(KWidth/2, KHeight/2);
        }
            break;
      
        default:
            break;
    }
    
    switch (_ContentAnmationType) {
        case LKWSYPickerContentAnmation_none:
        {
            _startPoint = _endPoint;
            self.pickerView.center = _startPoint;
            [UIView animateWithDuration:0.25 animations:^{
                self->_pickerView.center = self->_endPoint;
            } completion:^(BOOL finished) {
                [self.pickerView.tableV reloadData];
                if (self->_delegate && [self->_delegate respondsToSelector:@selector(lkwsyDidAppear)]) {
                    [self->_delegate lkwsyDidAppear];
                }
            }];
        }
            break;
        case LKWSYPickerContentAnmationType_botomToCenter:
        {
            _startPoint = CGPointMake(KWidth/2, KHeight+_pickHeight/2);
            self.pickerView.center = _startPoint;
            [UIView animateWithDuration:0.25 animations:^{
                self.pickerView.center = self->_endPoint;
            } completion:^(BOOL finished) {
                if (self->_delegate && [self->_delegate respondsToSelector:@selector(lkwsyDidAppear)]) {
                    [self->_delegate lkwsyDidAppear];
                }
            }];
        }
            break;
        case LKWSYPickerContentAnmationType_smallToBig:
        {
            _startPoint = _endPoint;
            self.pickerView.center = _endPoint;
            self.pickerView.transform = CGAffineTransformMakeScale(0.05, 0.05);
            [UIView animateWithDuration:0.25 animations:^{
                self.pickerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}

//消失动画
-(void)disApperThePickerAnimation{
    _styleType = LKWSYPickerStyle_sheet;
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerStyleType)]) {
        _styleType = [_delegate lkwsyPickerStyleType];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyWillDisApperar)]) {
        [_delegate lkwsyWillDisApperar];
    }
    switch (_ContentAnmationType) {
        case LKWSYPickerContentAnmation_none:
        {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(lkwsyDidDisAppear)]) {
                [self->_delegate lkwsyDidDisAppear];
             }
            [self dismissViewControllerAnimated:false completion:nil];
        }
            break;
        case LKWSYPickerContentAnmationType_botomToCenter:
        {
            self.pickerView.center = _endPoint;
            [UIView animateWithDuration:0.25 animations:^{
                self.pickerView.center = self->_startPoint;
            } completion:^(BOOL finished) {
                if (self->_delegate && [self->_delegate respondsToSelector:@selector(lkwsyDidDisAppear)]) {
                    [self->_delegate lkwsyDidDisAppear];
                 }
                  [self dismissViewControllerAnimated:false completion:nil];
                }];
        }
            break;
        case LKWSYPickerContentAnmationType_smallToBig:
        {
            self.pickerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [UIView animateWithDuration:0.25 animations:^{
                self.pickerView.transform = CGAffineTransformMakeScale(0.05, 0.05);
            } completion:^(BOOL finished) {
                if (self->_delegate && [self->_delegate respondsToSelector:@selector(lkwsyDidDisAppear)]) {
                    [self->_delegate lkwsyDidDisAppear];
                 }
                  [self dismissViewControllerAnimated:false completion:nil];
            }];
        }
            break;
        default:
            break;
    }
}

@end

