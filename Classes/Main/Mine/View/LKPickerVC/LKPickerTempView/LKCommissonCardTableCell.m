//
//  LKCommissonCardTableCell.m
//  cltios
//
//  Created by zjlk32 on 2021/8/26.
//

#import "LKCommissonCardTableCell.h"
#import "Masonry.h"
@interface LKCommissonCardTableCell ()<UITextFieldDelegate>

@end

@implementation LKCommissonCardTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setContentUI{
    [self.contentView addSubview:self.contentV];
    [self.contentV addSubview:self.titleLab];
    [self.contentV addSubview:self.contenTextFiled];
    [self.contentV addSubview:self.LineV];
    
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentV.mas_left).offset(20);
        make.centerY.mas_equalTo(self.contentV.mas_centerY);
        make.width.equalTo(@90);
        make.height.equalTo(@25);
    }];
    
    [self.contenTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentV.mas_centerY);
        make.height.equalTo(@25);
        make.width.mas_equalTo(260);
    }];
    
    [self.LineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentV.mas_left).offset(10);
        make.right.mas_equalTo(self.contentV.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentV.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
}


-(UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]init];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

-(UITextField *)contenTextFiled{
    if (!_contenTextFiled) {
        _contenTextFiled = [[UITextField alloc]init];
        _contenTextFiled.textColor = [UIColor blackColor];
        _contenTextFiled.font = [UIFont systemFontOfSize:14];
        [_contenTextFiled addTarget:self action:@selector(contenTextFiledDidValueChange:) forControlEvents:UIControlEventEditingChanged];
        self.contenTextFiled.delegate = self;
    }
    return _contenTextFiled;
}

-(UIView *)LineV{
    if (!_LineV) {
        _LineV = [[UIView alloc]init];
        _LineV.backgroundColor = [UIColor grayColor];
    }
    return _LineV;
}

-(void)setCellInfoModel:(LKCellInfoModel *)cellInfoModel{
    _cellInfoModel = cellInfoModel;
    if(_cellInfoModel.cellType == cellType_select){
        self.contenTextFiled.enabled = NO;
    }else{
        self.contenTextFiled.enabled = YES;
    }
    self.titleLab.text = _cellInfoModel.titleStr;
    self.contenTextFiled.text = _cellInfoModel.contentStr;
    self.contenTextFiled.placeholder = _cellInfoModel.placeStr;
}


-(void)contenTextFiledDidValueChange:(UITextField *)textField{
    _cellInfoModel.contentStr = textField.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}

@end
