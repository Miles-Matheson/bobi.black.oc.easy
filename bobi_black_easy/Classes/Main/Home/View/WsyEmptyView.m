//
//  WsyEmptyView.m
//  Woko
//
//  Created by 王树银 on 2022/5/14.
//

#import "WsyEmptyView.h"

@implementation WsyEmptyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setContentUI];
    }
    return self;
}


-(UIImageView *)emptyView{
    if (!_emptyView) {
        _emptyView = [UIImageView new];
        _emptyView.image = [UIImage mm_xcassetImageNamed:@"lk_empty"];
    }
    return _emptyView;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = [UIColor whiteColor];
        _contentLab.text = @"You haven't met any voice yet.";
        _contentLab.font = [UIFont systemFontOfSize:17];
        _contentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLab;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage  *image = [UIImage gradientColorImageFromColors:@[[UIColor colorWithHexString:@"#FA8448"],[UIColor colorWithHexString:@"#FACC48"]] gradientType:GradientTypeLeftToRight imgSize:CGSizeMake(275, 45)];
        [_btn setBackgroundImage:image forState:UIControlStateNormal];
//        [_btn setImage:image forState:UIControlStateNormal];
        [_btn setTitle:@"Search match" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_btn bringSubviewToFront:_btn.imageView];
        _btn.layer.masksToBounds = true;
        _btn.layer.cornerRadius = 8.0f;
    }
    return _btn;
}

-(void)setContentUI{
    [self addSubview:self.emptyView];
    [self addSubview:self.contentLab];
    [self addSubview:self.btn];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.equalTo(@69);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emptyView.mas_bottom).offset(36);
        make.left.right.mas_equalTo(self);
        make.height.equalTo(@21);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLab.mas_bottom).offset(52);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.equalTo(@275);
        make.height.equalTo(@45);
    }];
    
}

@end
