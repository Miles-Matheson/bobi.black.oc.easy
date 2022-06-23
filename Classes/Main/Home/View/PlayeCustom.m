//
//  PlayeCustom.m
//  VoiceProject
//
//  Created by 王树银 on 2022/4/13.
//
#import <AVFoundation/AVFoundation.h>
#import "WKUserInforManager.h"
#import "PlayeCustom.h"
#import "Masonry.h"
#import "YCXMenu.h"
#import "YCXMenuItem.h"
#import "UIColor+CHRegex.h"

@interface PlayeCustom ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    /** 播放计时器 */
    NSTimer *playTimer;

}
@property(nonatomic,strong)UIButton   *closeBtn;

@property(nonatomic,strong)UIButton  *reportBtn;

@property(nonatomic,strong)UIView  *containBackV;

@property(nonatomic,strong)UIImageView  *imgVBack;

@property(nonatomic,strong)UIImageView  *voicImgV;

@property(nonatomic,strong)UIView   *backV;

@property(nonatomic,strong)UIButton   *playBtn;

@property(nonatomic,strong)UIButton   *videoBtn;

@property(nonatomic,strong)UIButton  *listionBtn;

@property(nonatomic,strong)UILabel  *contenLab;

@property(nonatomic,copy)NSString   *name;

@property(nonatomic,strong)NSArray   *myitems;

@property(nonatomic,strong)NSString *tmpUrl;

@end

@implementation PlayeCustom

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#373636"];
        [self createTheSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#373636"];
        [self createTheSubViews];
    }
    return self;
}

-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]init];
//        _backV.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _backV.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    }
    return _backV;
}

-(NSArray *)myitems{
    if (!_myitems) {
        _myitems = [@[
            [YCXMenuItem menuItem:@"Block"
                            image:nil
                              tag:100
                         userInfo:@{@"title":@"Block"}],
            [YCXMenuItem menuItem:@"Delete"
                            image:nil
                              tag:102
                         userInfo:@{@"title":@"Delete"}],
            [YCXMenuItem menuItem:@"Report"
                            image:nil
                              tag:103
                         userInfo:@{@"title":@"Report"}],
            [YCXMenuItem menuItem:@"Cancel"
                            image:nil
                              tag:104
                         userInfo:@{@"title":@"Cancel"}]
        ] mutableCopy];
    }
    return _myitems;
}

-(UIView *)containBackV{
    if (!_containBackV) {
        _containBackV = [[UIView alloc]init];
        _containBackV.backgroundColor =[UIColor colorWithHexString:@"#747474" Alpha:0.8];
        _containBackV.layer.masksToBounds = true;
        _containBackV.layer.cornerRadius = 91.0f;
        _containBackV.layer.borderWidth = 0.99f;
        _containBackV.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.6].CGColor;
    }
    return _containBackV;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_error"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self selector:@selector(closeBtnAction)];
    }
    return _closeBtn;
}

-(UIButton *)reportBtn{
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_report"] forState:UIControlStateNormal];
        [_reportBtn addTarget:self selector:@selector(reportBtnClick:)];
    }
    return _reportBtn;
}

-(UIImageView *)imgVBack{
    if (!_imgVBack) {
        _imgVBack = [UIImageView new];
        _imgVBack.userInteractionEnabled = true;
        _imgVBack.layer.masksToBounds = true;//180
        _imgVBack.layer.cornerRadius = 80;
        _imgVBack.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgVBack;
}

-(UIImageView *)voicImgV{
    if (!_voicImgV) {
        _voicImgV = [UIImageView new];
        _voicImgV.hidden = true;
        _voicImgV.userInteractionEnabled = true;
        _voicImgV.contentMode = UIViewContentModeScaleAspectFill;
        _voicImgV.animationRepeatCount = MAXFLOAT;
        [_voicImgV setAnimationImages:@[[UIImage mm_xcassetImageNamed:@"voice_000000"],[UIImage mm_xcassetImageNamed:@"voice_000001"],[UIImage mm_xcassetImageNamed:@"voice_000002"],[UIImage mm_xcassetImageNamed:@"voice_000003"],[UIImage mm_xcassetImageNamed:@"voice_000004"],[UIImage mm_xcassetImageNamed:@"voice_000005"],[UIImage mm_xcassetImageNamed:@"voice_000006"],[UIImage mm_xcassetImageNamed:@"voice_000007"],[UIImage mm_xcassetImageNamed:@"voice_000008"],[UIImage mm_xcassetImageNamed:@"voice_000009"],[UIImage mm_xcassetImageNamed:@"voice_000010"],[UIImage mm_xcassetImageNamed:@"voice_000011"],[UIImage mm_xcassetImageNamed:@"voice_000012"],[UIImage mm_xcassetImageNamed:@"voice_000013"],[UIImage mm_xcassetImageNamed:@"voice_000014"]]];
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(voiceImageClick)];
        [_voicImgV addGestureRecognizer:tap];
    }
    return _voicImgV;
}

-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_play_white"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UIButton *)videoBtn{
    if (!_videoBtn) {
        _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_video"] forState:UIControlStateNormal];
        [_videoBtn setTitle:@"video" forState:UIControlStateNormal];
        [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _videoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _videoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [_videoBtn addTarget:self action:@selector(videoBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _videoBtn.layer.masksToBounds = true;
        _videoBtn.layer.cornerRadius = 5.0f;
    }
    return _videoBtn;
}

-(UIButton *)listionBtn{
    if (!_listionBtn) {
        _listionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listionBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_message"] forState:UIControlStateNormal];
        [_listionBtn setTitle:@"message" forState:UIControlStateNormal];
        _listionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _listionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [_listionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_listionBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _listionBtn.layer.masksToBounds = true;
        _listionBtn.layer.cornerRadius = 5.0f;
    }
    return _listionBtn;
}

-(UILabel *)contenLab{
    if (!_contenLab) {
        _contenLab = [[UILabel alloc]init];
        _contenLab.textColor = [UIColor whiteColor];
        _contenLab.font = [UIFont boldSystemFontOfSize:18];
        _contenLab.layer.masksToBounds = true;
        _contenLab.numberOfLines = 0;
        _contenLab.textAlignment = NSTextAlignmentCenter;
        _contenLab.text = [NSString stringWithFormat:@"Click listen %@‘s voice",_name];
    }
    return _contenLab;
}

-(void)createTheSubViews{
    [self addSubview:self.closeBtn];
    [self addSubview:self.reportBtn];
    self.reportBtn.frame = CGRectMake(self.frame.size.width - 46, 15, 24, 21);
    [self addSubview:self.containBackV];
    [self.containBackV addSubview:self.imgVBack];
    [self.imgVBack addSubview:self.backV];
    [self.backV addSubview:self.voicImgV];
    [self.backV addSubview:self.playBtn];
    [self.backV bringSubviewToFront:self.voicImgV];
    [self addSubview:self.contenLab];
    [self addSubview:self.videoBtn];
    [self addSubview:self.listionBtn];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@23);
        make.top.mas_equalTo(@15);
        make.height.equalTo(@24);
        make.width.equalTo(@24);
    }];
    
    [self.containBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(67);
        make.width.height.equalTo(@182);
    }];

    [self.imgVBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containBackV.mas_centerX);
        make.centerY.mas_equalTo(self.containBackV.mas_centerY);
//        make.top.mas_equalTo(self.mas_top).offset(63);
        make.width.height.equalTo(@160);

    }];
    
    [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.imgVBack);
    }];
    
    [self.voicImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backV.mas_centerX);
        make.centerY.mas_equalTo(self.backV.mas_centerY);
        make.width.equalTo(@154);
        make.height.equalTo(@52);
    }];

    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backV.mas_centerX);
        make.centerY.mas_equalTo(self.backV.mas_centerY);
        make.width.equalTo(@18);
        make.height.equalTo(@23);
    }];
    
    [self.contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.imgVBack.mas_bottom).offset(30);
        make.height.equalTo(@40);
    }];
    
    self.videoBtn.frame = CGRectMake(self.frame.size.width/2 - 140, 356, 130, 50);
    self.listionBtn.frame = CGRectMake(self.frame.size.width/2 + 10, 356, 130, 50);
    [self.listionBtn.layer insertSublayer:[UIColor setGradualChangingColor:self.listionBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]atIndex:0];
    [self.listionBtn bringSubviewToFront:self.listionBtn.imageView];
    [self.videoBtn.layer insertSublayer:[UIColor setGradualChangingColor:self.videoBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]atIndex:0];
    [self.videoBtn bringSubviewToFront:self.videoBtn.imageView];
    [self.listionBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_message"] forState:UIControlStateNormal];
    [self.listionBtn setTitle:@"message" forState:UIControlStateNormal];
    [self.videoBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_video"] forState:UIControlStateNormal];
    [self.videoBtn setTitle:@"video" forState:UIControlStateNormal];
    self.playBtn.hidden = false;
//    [self prepTheVideoPlayer];
    
    [YCXMenu setTintColor:[UIColor colorWithHexString:@"#373636" Alpha:0.1]];
    [YCXMenu setSelectedColor:[UIColor clearColor]];
    [YCXMenu setBackgrounColorEffect:YCXMenuBackgrounColorEffectSolid];
    [YCXMenu setSeparatorColor:[UIColor clearColor]];    
}

-(void)prepTheVideoPlayer{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *playError;
    if (_tmpUrl) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_tmpUrl]];
        if(data == nil){
            [YPCSVProgress showStatusMessageWithTitle:@"Creat player failed" finishBlock:^{
            }];
        }else{
       player = [[AVAudioPlayer alloc] initWithData:data error:&playError];
       player.delegate = self;
        if (player == nil) {
            NSLog(@"Error crenting player: %@", [playError description]);
        }else{
            player.delegate = self;
        }
      }
    }
}



-(void)playerAction{
  NSLog(@"开始播放");
        //开始播放
    if ([player prepareToPlay] == YES) {
        [player play];
        self.playBtn.hidden = true;
        self.voicImgV.hidden = false;
        [self.voicImgV startAnimating];
        [self recordTheVoiceMessage];
      }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [player stop];
    [self.voicImgV stopAnimating];
    self.playBtn.hidden = false;
    self.voicImgV.hidden = true;
    [self.imgVBack bringSubviewToFront:self.playBtn];
}

-(void)closeBtnAction{
    if ([YCXMenu isShow]) {
        [YCXMenu dismissMenu];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(dissThePlayerView)]) {
        [YCXMenu dismissMenu];
        [self playStopAction];
        [_delegate dissThePlayerView];
    }
}

-(void)playStopAction{
    [player stop];
    [self.voicImgV stopAnimating];
    player = nil;
}

-(void)voiceImageClick{
    [player pause];
    [self.voicImgV stopAnimating];
    self.voicImgV.hidden = true;
    self.playBtn.hidden = false;
}
//记录录音
-(void)recordTheVoiceMessage{
    NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
    bool   isHave = false;
    for (NSDictionary  *tempDic  in arr) {
        if (![tempDic isKindOfClass:[NSNull class]]) {
            NSString  *name = [tempDic objectForKey:@"name"];
            NSString  *icon = [tempDic objectForKey:@"icon"];
            NSString  *voice = [tempDic objectForKey:@"voice"];
            if ([name isEqualToString:[_dic objectForKey:@"name"]] && [icon isEqualToString:[_dic objectForKey:@"icon"]] && [voice isEqualToString:[_dic objectForKey:@"voice"]]) {
                isHave = true;
            }
        }
    }
    if (isHave == false) {
        [arr addObject:_dic];
    }
    [[WKUserInforManager sharedInstance] changeTheVoiceListAction:arr];
}

-(void)videoBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(videoWithOthersAction)]) {
        [self playStopAction];
        [_delegate videoWithOthersAction];
    }
}

-(void)messageBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(messageWithOthersAction)]) {
        [self playStopAction];
        [_delegate messageWithOthersAction];
    }
    
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    if (![dic isKindOfClass:[NSNull class]]) {
        _tmpUrl = dic[@"voice"];
        _name = dic[@"name"];
        [self.imgVBack yy_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholder:[UIImage mm_xcassetImageNamed:@""]];
        _contenLab.text = [NSString stringWithFormat:@"Click listen %@'s voice",_name];
        self.playBtn.hidden = false;
        self.voicImgV.hidden = true;
        [self prepTheVideoPlayer];
    }
}

-(void)reportBtnClick:(UIButton *)sender{
    [player stop];
    [self.voicImgV stopAnimating];
//    NSArray *myitems = [@[
//        [YCXMenuItem menuItem:@"Block"
//                        image:nil
//                          tag:100
//                     userInfo:@{@"title":@"Block"}],
//        [YCXMenuItem menuItem:@"Delete"
//                        image:nil
//                          tag:102
//                     userInfo:@{@"title":@"Delete"}],
//        [YCXMenuItem menuItem:@"Report"
//                        image:nil
//                          tag:103
//                     userInfo:@{@"title":@"Report"}],
//        [YCXMenuItem menuItem:@"Cancel"
//                        image:nil
//                          tag:104
//                     userInfo:@{@"title":@"Cancel"}]
//    ] mutableCopy];
    
    [YCXMenu showMenuInView:self fromRect:CGRectMake(self.reportBtn.frame.origin.x, self.reportBtn.frame.origin.y+10, self.reportBtn.frame.size.width, self.reportBtn.frame.size.height) menuItems:self.myitems selected:^(NSInteger index, YCXMenuItem *item) {
        if ([item.title containsString:@"Block"]) {
           //
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(rightItemAction:AndTheDic:)]) {
                [self playStopAction];
                [self->_delegate rightItemAction:0 AndTheDic:self->_dic];
            }
        }else if ([item.title containsString:@"Delete"]){
           //删除
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(rightItemAction:AndTheDic:)]) {
                [self playStopAction];
                [self->_delegate rightItemAction:1 AndTheDic:self->_dic];
            }
        }else if ([item.title containsString:@"Report"]){
           //举报
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(rightItemAction:AndTheDic:)]) {
                [self playStopAction];
                [self->_delegate rightItemAction:2 AndTheDic:self->_dic];
            }
        }else if ([item.title containsString:@"Cancel"]){
           //取消
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(rightItemAction:AndTheDic:)]) {
                [self->_delegate rightItemAction:3 AndTheDic:self->_dic];
            }
        }
    }];
}

@end
