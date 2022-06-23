//
//  LKPickViewController.m
//  cltios
//
//  Created by zjlk32 on 2021/8/2.
//

#import "LKPickViewController.h"
#import "BobiEasyHeader.h"

@interface LKPickViewController ()

@property(nonatomic,strong)UIView  *backView;



@end

@implementation LKPickViewController


-(instancetype)init{
    if (self == [super init]) {
        _pickHeight = 230.0f;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer  *tapGester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissTheCotnentView)];
    [self.view addGestureRecognizer:tapGester];
}

-(void)dissmissTheCotnentView{
    [self pickerDownAnmation];
}

-(void)pickerDownAnmation{
    
    if (_pickerView.frame.origin.y <= KHeight) {
        [UIView animateWithDuration:0.7 animations:^{
            self->_pickerView.frame = CGRectMake(0, KHeight,KWidth ,self->_pickHeight);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:true completion:nil];
        }];
    }
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    }
    return _backView;
}
-(LKPickBackContView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[LKPickBackContView alloc]initWithFrame:CGRectMake(0, KHeight,KWidth ,_pickHeight)];
        [_pickerView.headV.cancelBtn addTarget:self action:@selector(pickerDownAnmation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickerView;
}
-(void)lkPickerViewWithDataArr:(NSArray *)dataArray SelectWithBlock:(void (^)(NSString * _Nonnull, NSInteger))block{
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.pickerView];
    [UIView animateWithDuration:0.7 animations:^{
        self->_pickerView.frame = CGRectMake(0, KHeight - self->_pickHeight, KWidth, self->_pickHeight);
    } completion:^(BOOL finished) {
        [self->_pickerView lkpickerViewWithData:[NSMutableArray arrayWithArray:dataArray] AndTheSelectedWithBlock:block];
    }];
}


//-(LKPickerType)lkPickerType{
//    if ([_delegate respondsToSelector:@selector(lkPickerType)]) {
//        return [_delegate lkPickerType];
//    }
//    return LKPicker_Normal;
//}
//-(LKPickerType)lkPickerType{
//
//}
//
//
//
//-(Class)customCellWithTheTableV:(UITableView *)tableView{
//    if ([_delegate respondsToSelector:@selector(customCellWithTheTableV:)]) {
//        return [_delegate customCellWithTheTableV:tableView];
//    }
//    return [UITableViewCell class];
//}
//- (NSArray *)lkNumberOfRowsInLKPickerView:(UITableView *)tableView{
//    if ([_delegate respondsToSelector:@selector(lkNumberOfRowsInLKPickerView:)]) {
//        return  [_delegate lkNumberOfRowsInLKPickerView:tableView];
//    }
//    return [NSArray array];
//}


//-(Class)customCellWithTheTableV:(UITableView *)tableView;
//
//-(NSArray *)lkNumberOfRowsInLKPickerView:(UITableView *)tableView;
//
//-(CGFloat)lkPickerCellHeightWithTableView:(UITableView *)tableView;
//
//-(void)lkPickerSelectItem:(NSInteger)row WithTableView:(UITableView *)tableView;



@end
