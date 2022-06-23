//
//  WKVoiceListCollectCell.m
//  Woko
//
//  Created by 王树银 on 2022/4/26.
//

#import "WKVoiceListCollectCell.h"
#import "BobiEasyHeader.h"
@implementation WKVoiceListCollectCell
//@property(nonatomic,strong)UIImageView   *iconImgV;

//@property(nonatomic,strong)UIImageView  *voiceImgV;

//@property(nonatomic,strong)UIButton  *videoBtn;


-(UIImageView *)iconImgV{
    if (!_iconImgV) {
        _iconImgV = [UIImageView new];
        _iconImgV.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgV.userInteractionEnabled = true;
    }
    return _iconImgV;
}

- (UIImageView *)voiceImgV{
    if (!_voiceImgV) {
        _voiceImgV = [UIImageView new];
        _voiceImgV.contentMode = UIViewContentModeScaleAspectFill;
        _voiceImgV.userInteractionEnabled = true;
        _voiceImgV.userInteractionEnabled = true;
        _voiceImgV.animationRepeatCount = MAXFLOAT;
        _voiceImgV.image = [UIImage mm_xcassetImageNamed:@"voice_000000"];
        [_voiceImgV setAnimationImages:@[[UIImage mm_xcassetImageNamed:@"voice_000000"],[UIImage mm_xcassetImageNamed:@"voice_000001"],[UIImage mm_xcassetImageNamed:@"voice_000002"],[UIImage mm_xcassetImageNamed:@"voice_000003"],[UIImage mm_xcassetImageNamed:@"voice_000004"],[UIImage mm_xcassetImageNamed:@"voice_000005"],[UIImage mm_xcassetImageNamed:@"voice_000006"],[UIImage mm_xcassetImageNamed:@"voice_000007"],[UIImage mm_xcassetImageNamed:@"voice_000008"],[UIImage mm_xcassetImageNamed:@"voice_000009"],[UIImage mm_xcassetImageNamed:@"voice_000010"],[UIImage mm_xcassetImageNamed:@"voice_000011"],[UIImage mm_xcassetImageNamed:@"voice_000012"],[UIImage mm_xcassetImageNamed:@"voice_000013"],[UIImage mm_xcassetImageNamed:@"voice_000014"]]];
    }
    return _voiceImgV;
}

-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]init];
        _backV.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    }
    return _backV;
}

-(UIButton *)videoBtn{
    if (!_videoBtn) {
        _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_video_small"] forState:UIControlStateNormal];
        [_videoBtn setTitle:@"Call" forState:UIControlStateNormal];
        _videoBtn.layer.masksToBounds = true;
        _videoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        _videoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        _videoBtn.layer.cornerRadius =16.0f;
        [_videoBtn addTarget:self selector:@selector(vidoBtnClickAction)];
    }
    return _videoBtn;
}

-(void)setContentUI{
    [self.contentView addSubview:self.iconImgV];
    [self.iconImgV addSubview:self.backV];
    [self.backV addSubview:self.voiceImgV];
    [self.backV addSubview:self.videoBtn];
    [self.backV bringSubviewToFront:self.voiceImgV];
    self.contentView.layer.masksToBounds = true;
    self.contentView.layer.cornerRadius = 10.0;
    self.contentView.layer.borderWidth = 2.0;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#FEA139"].CGColor;
    
    
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(2);
        make.right.bottom.mas_equalTo(self.contentView).offset(-2);
    }];
    [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.iconImgV);
    }];
    [self.voiceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backV.mas_centerY);
        make.left.mas_equalTo(self.backV.mas_left).offset(34);
        make.right.mas_equalTo(self.backV.mas_right).offset(-33);
        make.height.equalTo(@50);
    }];
    
    self.videoBtn.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame)/2 - 50, CGRectGetMaxY(self.contentView.frame) - 47, 100, 32);
    [self.videoBtn.layer insertSublayer:[UIColor setGradualChangingColor:self.videoBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]atIndex:0];
    [self.videoBtn bringSubviewToFront:self.videoBtn.imageView];
}

-(void)vidoBtnClickAction{
    if (_block) {
        _block(_dic);
    }
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    if (![_dic isKindOfClass:[NSNull class]]) {
        [self.iconImgV yy_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon"]] placeholder:[UIImage mm_xcassetImageNamed:@""]];
    }
}

@end
