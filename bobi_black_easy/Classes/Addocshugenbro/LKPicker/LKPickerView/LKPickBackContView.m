//
//  LKPickBackContView.m
//  cltios
//
//  Created by zjlk32 on 2021/8/2.
//

#import "LKPickBackContView.h"
#import "Masonry.h"
#import "NSArray+SafeIndex.h"
@implementation LKPickHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initTheSubViews];
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        [self initTheSubViews];
    }
    return self;
}

-(void)initTheSubViews{
    
    [self addSubview:self.cancelBtn];
    
    [self addSubview:self.beSureBtn];
    
    [self addSubview:self.titleLab];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.equalTo(@40);
        make.height.equalTo(@25);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.equalTo(@25);
    }];
    
    [self.beSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.equalTo(@40);
        make.height.equalTo(@25);
    }];
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
    }
    return _cancelBtn;
}

-(UIButton *)beSureBtn{
    if (!_beSureBtn) {
        _beSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_beSureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _beSureBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont boldSystemFontOfSize:15];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"选择收款方式";
    }
    return _titleLab;
}

@end

@interface LKPickBackContView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,copy)NSString  *selctTitle;
@property(nonatomic,assign)NSInteger  index;
@end

@implementation LKPickBackContView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initTheSubViews];
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initTheSubViews];
    }
    return self;
}

-(void)initTheSubViews{
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _selctTitle = @"";
    _index = 0;
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self.headV.beSureBtn addTarget:self action:@selector(beSureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.headV];
    [self addSubview:self.pickView];
}

-(void)beSureBtnAction{
    
    if (_block) {
        _block(_selctTitle ,_index);
    }
}

-(void)cancelBtnAction{
    
}

-(void)setPickerType:(LKPickerType)pickerType{
    _pickerType = pickerType;
    switch (_pickerType) {
        case LKPicker_Normal:
            
            break;
        case LKPicker_tableV:
            
            break;
        case LKPicker_PassWord:
            
            break;
            
        default:
            break;
    }
}

-(void)setDataArray:(NSMutableArray<NSString *> *)dataArray{
    _dataArray = dataArray;
}

-(LKPickHeadView *)headV{
    if (!_headV) {
        _headV = [[LKPickHeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    }
    return _headV;
}

-(UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40)];
    }
    return _pickView;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  
    return _dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString  *title = [_dataArray objcetSafeGetIndex:row];
    return title.length > 0 ? title : @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setTextColor:[UIColor blackColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _index = row;
    _selctTitle = [_dataArray objcetSafeGetIndex:row];
}

-(void)lkpickerViewWithData:(NSArray *)dataArr AndTheSelectedWithBlock:(void (^)(NSString * _Nonnull, NSInteger))block{
    [self setDataArray:[NSMutableArray arrayWithArray:dataArr]];
    _selctTitle = [_dataArray firstObject];
    _index = 0;
    [_pickView reloadAllComponents];
    self.block = block;
  
}

@end
