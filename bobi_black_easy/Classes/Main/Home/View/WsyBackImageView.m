//
//  WsyBackImageView.m
//  VoiceProject
//
//  Created by 王树银 on 2022/4/14.
//

#import "WsyBackImageView.h"
#import "BobiEasyHeader.h"

@implementation wsySbuImgView

-(instancetype)init{
    if (self == [super init]) {
        self.image = [UIImage mm_xcassetImageNamed:@"wsy_chatback"];
        [self createTheSubViews];
    }
    return self;
}

-(UIImageView *)iconImgV{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.userInteractionEnabled = true;
        _iconImgV.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgV.layer.masksToBounds = true;
        _iconImgV.layer.cornerRadius = 16.0f;
        _iconImgV.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImgV.layer.borderWidth = 1.0f;
    }
    return _iconImgV;
}

-(UIImageView *)voiceImgV{
    if (!_voiceImgV) {
        _voiceImgV = [UIImageView new];
        _voiceImgV.image = [UIImage mm_xcassetImageNamed:@"wsy_voic"];
        _voiceImgV.userInteractionEnabled = true;
    }
    return _voiceImgV;
}

-(void)createTheSubViews{
    [self addSubview:self.iconImgV];
    [self addSubview:self.voiceImgV];
    self.userInteractionEnabled = true;
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(3);
        make.centerY.mas_offset(-5);
        make.width.height.equalTo(@32);
    }];
   
    [self.voiceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgV.mas_right).offset(10);
        make.centerY.mas_equalTo(self.iconImgV);
        make.right.mas_offset(-5);
//        make.top.mas_equalTo(self.mas_top).offset()
        make.height.equalTo(@32);
    }];
}

@end


@implementation WsyBackImageView

- (void)createUI {
    [super createUI];
    [self addSubview:self.backImageV];
    [self addSubview:self.subImgV_1];
    [self addSubview:self.subImgV_2];
    [self addSubview:self.subImgV_3];
    [self addSubview:self.subImgV_4];
    [self addSubview:self.subImgV_5];
    [self addSubview:self.subImgV_6];
    self.subViewsArr = @[self.subImgV_1,self.subImgV_2,self.subImgV_3,self.subImgV_4,self.subImgV_5,self.subImgV_6];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(65);
        make.height.equalTo(@403);
    }];
    [self.subImgV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(63);
        make.top.mas_equalTo(self.mas_top).offset(50);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_right).offset(-63);
        make.top.mas_equalTo(self.mas_top).offset(75);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(205);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(63);
        make.top.mas_equalTo(self.mas_top).offset(293);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_right).offset(-63);
        make.top.mas_equalTo(self.mas_top).offset(304);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    self.backImageV.image = [UIImage mm_xcassetImageNamed:@"wsy_city"];
    UITapGestureRecognizer  *tap_1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_1];
    UITapGestureRecognizer  *tap_2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_2 addGestureRecognizer:tap_2];
    UITapGestureRecognizer  *tap_3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_3 addGestureRecognizer:tap_3];
    UITapGestureRecognizer  *tap_4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_4 addGestureRecognizer:tap_4];
    UITapGestureRecognizer  *tap_5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_5 addGestureRecognizer:tap_5];
    UITapGestureRecognizer  *tap_6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_6 addGestureRecognizer:tap_6];
}

-(UIImageView *)backImageV{
    if (!_backImageV) {
        _backImageV = [UIImageView new];
        _backImageV.userInteractionEnabled = true;
        _backImageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backImageV;
}

-(wsySbuImgView *)subImgV_1{
    if (!_subImgV_1) {
        _subImgV_1 = [[wsySbuImgView alloc]init];
        _subImgV_1.userInteractionEnabled = true;
        _subImgV_1.hidden = true;
        _subImgV_1.tag = 100;
    }
    return _subImgV_1;
}

-(wsySbuImgView *)subImgV_2{
    if (!_subImgV_2) {
        _subImgV_2 = [[wsySbuImgView alloc]init];
        _subImgV_2.userInteractionEnabled = true;
        _subImgV_2.hidden = true;
        _subImgV_2.tag = 101;
    }
    return _subImgV_2;
}

-(wsySbuImgView *)subImgV_3{
    if (!_subImgV_3) {
        _subImgV_3 = [[wsySbuImgView alloc]init];
        _subImgV_3.userInteractionEnabled = true;
        _subImgV_3.hidden = true;
        _subImgV_3.tag = 102;
    }
    return _subImgV_3;
}

-(wsySbuImgView *)subImgV_4{
    if (!_subImgV_4) {
        _subImgV_4 = [[wsySbuImgView alloc]init];
        _subImgV_4.userInteractionEnabled = true;
        _subImgV_4.hidden = true;
        _subImgV_4.tag = 103;
    }
    return _subImgV_4;
}

-(wsySbuImgView *)subImgV_5{
    if (!_subImgV_5) {
        _subImgV_5 = [[wsySbuImgView alloc]init];
        _subImgV_5.userInteractionEnabled = true;
        _subImgV_5.hidden = true;
        _subImgV_5.tag = 104;
    }
    return _subImgV_5;
}

-(wsySbuImgView *)subImgV_6{
    if (!_subImgV_6) {
        _subImgV_6 = [[wsySbuImgView alloc]init];
        _subImgV_6.userInteractionEnabled = true;
        _subImgV_6.hidden = true;
        _subImgV_6.tag = 105;
    }
    return _subImgV_6;
}

-(void)createTheSubViews{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    self.userInteractionEnabled = true;
    [self addSubview:self.backImageV];
    [self addSubview:self.subImgV_1];
    [self addSubview:self.subImgV_2];
    [self addSubview:self.subImgV_3];
    [self addSubview:self.subImgV_4];
    [self addSubview:self.subImgV_5];
    [self addSubview:self.subImgV_6];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(65);
        make.height.equalTo(@403);
    }];
    [self.subImgV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(65);
        make.top.mas_equalTo(self.mas_top).offset(50);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_right).offset(-65);
        make.top.mas_equalTo(self.mas_top).offset(75);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(205);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(65);
        make.top.mas_equalTo(self.mas_top).offset(293);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    [self.subImgV_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_right).offset(-65);
        make.top.mas_equalTo(self.mas_top).offset(304);
        make.width.equalTo(@126);
        make.height.equalTo(@49);
    }];
    self.backImageV.image = [UIImage mm_xcassetImageNamed:@"wsy_city"];
    UITapGestureRecognizer  *tap_1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_1];
    UITapGestureRecognizer  *tap_2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_2];
    UITapGestureRecognizer  *tap_3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_3];
    UITapGestureRecognizer  *tap_4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_4];
    UITapGestureRecognizer  *tap_5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_5];
    UITapGestureRecognizer  *tap_6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnAction:)];
    [self.subImgV_1 addGestureRecognizer:tap_6];
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    if (_dataArr.count > 0) {
        for (int i = 0; i < _dataArr.count; i++) {
            NSDictionary *dic = [_dataArr objcetSafeGetIndex:i];
            wsySbuImgView  *img = [self.subViewsArr objectAtIndex:i];
            img.hidden = false;
            [img.iconImgV yy_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholder:[UIImage mm_xcassetImageNamed:@""]];
        }
        if (_dataArr.count < 6) {
            for (int j = (int)_dataArr.count; j < 6; j++) {
                wsySbuImgView  *img = [self.subViewsArr objectAtIndex:j];
                img.hidden = true;
            }
        }
    }
}

-(void)btnAction:(UIGestureRecognizer *)sender{
    wsySbuImgView  *imageV = (wsySbuImgView*)sender.view;
    NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:imageV.tag - 100];
    if (_block) {
        _block(dic,imageV.tag - 100);
    }
}

-(void)freshTheAnmation{
    [UIView animateWithDuration:0.4 animations:^{
        if (self.subImgV_1.hidden == false) {
            self.subImgV_1.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        if (self.subImgV_2.hidden == false) {
            self.subImgV_2.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        if (self.subImgV_3.hidden == false) {
            self.subImgV_3.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        if (self.subImgV_4.hidden == false) {
            self.subImgV_4.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        if (self.subImgV_5.hidden == false) {
            self.subImgV_5.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
        if (self.subImgV_6.hidden == false) {
            self.subImgV_6.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            if (self.subImgV_1.hidden == false) {
                self.subImgV_1.transform = CGAffineTransformIdentity;
            }
            if (self.subImgV_2.hidden == false) {
                self.subImgV_2.transform = CGAffineTransformIdentity;
            }
            if (self.subImgV_3.hidden == false) {
                self.subImgV_3.transform = CGAffineTransformIdentity;
            }
            if (self.subImgV_4.hidden == false) {
                self.subImgV_4.transform = CGAffineTransformIdentity;
            }
            if (self.subImgV_5.hidden == false) {
                self.subImgV_5.transform = CGAffineTransformIdentity;
            }
            if (self.subImgV_6.hidden == false) {
                self.subImgV_6.transform = CGAffineTransformIdentity;
            }
        }];
        
    }];
}


@end
