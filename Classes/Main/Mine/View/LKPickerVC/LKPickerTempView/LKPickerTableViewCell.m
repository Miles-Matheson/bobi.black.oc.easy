//
//  LKPickerTableViewCell.m
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import "LKPickerTableViewCell.h"
#import "Masonry.h"
//#import "LKNormalAcountModel.h"

@implementation LKPickerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setContentUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImgV];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.accessLab];
    [self.contentView addSubview:self.selectBtn];
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgV.mas_right).offset(5);
        make.bottom.mas_equalTo(self.iconImgV.mas_centerY).offset(-2);
        make.height.equalTo(@20);
    }];
    
    [self.accessLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.top.mas_equalTo(self.iconImgV.mas_centerY).offset(2);
        make.height.equalTo(@20);
    }];
    
    
}

-(UIImageView *)iconImgV{
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc]init];
    }
    return _iconImgV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

-(UILabel *)accessLab{
    if (!_accessLab) {
        _accessLab = [[UILabel alloc]init];
        _accessLab.textColor = [UIColor blackColor];
        _accessLab.font = [UIFont systemFontOfSize:14];
    }
    return _accessLab;
}



//-(NSMutableArray<LKNormalAcountModel *> *)normalDataArr{
//    if (!_normalDataArr) {
//        _normalDataArr = [NSMutableArray array];
//        NSArray  *iconArr = @[@"lkPay_0",@"lkPay_1",@"lkPay_2",@"lkPay_3",@"lkPay_4",@"lkPay_5",@"lkPay_6",@"lkPay_7",@"lkPay_8",@"lkPay_9",@"lkPay_10",@"lkPay_11",@"",@"lkPay_13",@"lkPay_14",@"lkPay_15",@"lkPay_16",@"lkPay_17",@"lkPay_18",@"lkPay_19"];
//        NSArray  *nameArr = @[@"支付宝",@"微信",@"工商银行",@"农业银行",@"中国银行",@"建设银行",@"交通银行",@"招商银行",@"邮政储蓄银行",@"中信银行",@"平安银行",@"浦发银行",@"民生银行",@"广发银行",@"兴业银行",@"光大银行",@"华夏银行",@"上海银行",@"江苏银行",@"杭州银行"];
//
//    for (int i = 0; i < 20; i++) {
//        LKNormalAcountModel  *normalModel = [[LKNormalAcountModel alloc]init];
//        normalModel.name = [nameArr objcetSafeGetIndex:i];
//        normalModel.iconStr = [iconArr objcetSafeGetIndex:i];
//        normalModel.types = i + 1;
//        [_normalDataArr addObject:normalModel];
//    }
//    }
//    return _normalDataArr;
//}
//
//-(void)setAcountModel:(LKChangeAcountModel *)acountModel{
//    _acountModel = acountModel;
//    if (_acountModel) {
//        for (LKNormalAcountModel *model in self.normalDataArr) {
//            if (model.types == _acountModel.types) {
//                self.titleLab.text =  model.name;
//                self.iconImgV.image = [UIImage mm_xcassetImageNamed:model.iconStr];
//                self.accessLab.text = _acountModel.access;
//            }
//        }
//    }else{
//        self.iconImgV.image = nil;
//        self.titleLab.text = @"";
//        self.accessLab.text = @"";
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
