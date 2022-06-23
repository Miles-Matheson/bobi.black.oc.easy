//
//  RecordCustomView.m
//  VoiceProject
//
//  Created by wsy on 2022/4/11.
//
#import <AVFoundation/AVFoundation.h>
#import "RecordCustomView.h"
#import "Masonry.h"
#import "UIColor+CHRegex.h"
#import "WsyStrokeLab.h"
#import "CircleProgessView.h"
#import "BobiEasyHeader.h"

static NSInteger  maxTime =30;
@interface RecordCustomView ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
       /** 录音计时器 */
    NSTimer *recordTimer;
       /** 播放计时器 */
    NSTimer *playTimer;
       /** 录音时间 */
   NSInteger recordSecond;
   /** 录音分钟时间 */
   NSInteger minuteRecord;
   /** 播放时间 */
   NSInteger playSecond;
   /** 播放分钟时间 */
   NSInteger minutePlay;
   /** caf文件路径 */
   NSURL *tmpUrl;
    NSString   *urlStr;

    AVAudioSession *audioSession;
//float    totleTime;
}
//录制状态  录制完成状态 ，播放状态
@property(nonatomic,strong)WsyStrokeLab   *titleLab;

@property(nonatomic,strong)CircleProgessView   *audioBackV;

@property(nonatomic,strong)NSString     *timeStr;

@property(nonatomic,strong)UIButton   *audioBtn;

@property(nonatomic,strong)UIButton  *deleteBtn;

@property(nonatomic,strong)UILabel  *remindLab;

@property(nonatomic,strong)UIButton  *cancelBtn;

@property(nonatomic,strong)UIButton  *sureBtn;

@property(nonatomic,strong)UILabel  *timeLab;

@property(nonatomic,assign)NSInteger   status; // 0  录音状态    1 暂停    2  播放

@end


@implementation RecordCustomView

-(instancetype)init{
    if (self == [super init]) {
        //#3C3C3C
        self.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        self.status = 0;
        recordSecond = 0;
        minuteRecord = 0;
        [self creatTheSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        self.status = 0;
        [self creatTheSubViews];
    }
    return self;
}


-(WsyStrokeLab *)titleLab{
    if (!_titleLab) {
        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 55, 24, 110, 30)];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.outLineWidth = 0.0f;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
        _titleLab.text = @"Send voice";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(UIButton *)audioBtn{
    if (!_audioBtn) {
        _audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_audio"] forState:UIControlStateNormal];
        [_audioBtn addTarget:self action:@selector(audioBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_audioBtn.imageView setAnimationImages:@[[UIImage mm_xcassetImageNamed:@"voice_000000"],[UIImage mm_xcassetImageNamed:@"voice_000001"],[UIImage mm_xcassetImageNamed:@"voice_000002"],[UIImage mm_xcassetImageNamed:@"voice_000003"],[UIImage mm_xcassetImageNamed:@"voice_000004"],[UIImage mm_xcassetImageNamed:@"voice_000005"],[UIImage mm_xcassetImageNamed:@"voice_000006"],[UIImage mm_xcassetImageNamed:@"voice_000007"],[UIImage mm_xcassetImageNamed:@"voice_000008"],[UIImage mm_xcassetImageNamed:@"voice_000009"],[UIImage mm_xcassetImageNamed:@"voice_000010"],[UIImage mm_xcassetImageNamed:@"voice_000011"],[UIImage mm_xcassetImageNamed:@"voice_000012"],[UIImage mm_xcassetImageNamed:@"voice_000013"],[UIImage mm_xcassetImageNamed:@"voice_000014"]]];
    }
    return _audioBtn;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_delete_1"] forState:UIControlStateNormal];
        _deleteBtn.hidden = true;
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"00: 00";
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:14.0f];
    }
    return _timeLab;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDCA38"]];
        _cancelBtn.layer.masksToBounds = true;
        _cancelBtn.layer.cornerRadius = 5.0f;
        [_cancelBtn addTarget:self action:@selector(scancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"Send" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDCA38"]];
        _sureBtn.layer.masksToBounds = true;
        _sureBtn.layer.cornerRadius = 5.0f;
        [_sureBtn addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sureBtn;
}

-(UILabel *)remindLab{
    if (!_remindLab) {
        _remindLab = [[UILabel alloc]init];
        _remindLab.textColor = [UIColor whiteColor];
        _remindLab.font = [UIFont boldSystemFontOfSize:15.0f];
        _remindLab.textAlignment = NSTextAlignmentCenter;
        _remindLab.numberOfLines = 3;
        _remindLab.text = @"  Say something interesting or sing a  song.If someone is interested in your voice, you can video chat.";
    }
    return _remindLab;
}

-(void)creatTheSubViews{
    _audioBackV = [[CircleProgessView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 56.5, 84, 113, 113) withRadius:56.5f withLineWidth:1.99f];
    _audioBackV.layer.borderColor = [UIColor colorWithHexString:@"#46403B"].CGColor;
    [self addSubview:self.titleLab];
    [self addSubview:self.audioBackV];
    [self addSubview:self.audioBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.timeLab];
    [self addSubview:self.remindLab];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.sureBtn];
    [self bringSubviewToFront:self.audioBtn];
    [self bringSubviewToFront:self.deleteBtn];
    self.cancelBtn.frame = CGRectMake(self.frame.size.width/2 - 140, 356, 130, 50);
    self.sureBtn.frame = CGRectMake(self.frame.size.width/2 + 10, 356, 130, 50);
    self.audioBtn.frame = CGRectMake(self.frame.size.width/2 - 40, 100.5, 80, 80);
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.audioBtn.mas_right);
        make.top.mas_equalTo(self.audioBtn.mas_top);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(207);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@18);
    }];
    
    [self.remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(24);
        make.right.mas_equalTo(self.mas_right).offset(-24);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(20);
        make.height.equalTo(@64);
    }];
    [self.cancelBtn.layer addSublayer:[UIColor setGradualChangingColor:self.cancelBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]];
    [self.sureBtn.layer addSublayer:[UIColor setGradualChangingColor:self.sureBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]];
    [self getTheVoiceStatus];
}

-(void)scancelBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelAction)]) {
        [self deleteBtnAction];
        [_delegate cancelAction];
    }
}

-(void)senderAction{
    if (tmpUrl && self.timeStr.length) {
        if (_delegate && [_delegate respondsToSelector:@selector(senderAudioAction)]) {
            [self deleteBtnAction];
            [_delegate senderAudioAction];
        }
    }else{
        [YPCSVProgress showStatusMessageWithTitle:@"please record the sound." finishBlock:nil];
    }
    
}

-(NSURL *)getSavePath{
     //获取文件路径
     NSString *urlStrs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSLog(@"%@",urlStr);
     NSDate *date=[NSDate date];
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd-HH_mm_ss"];
     //NSDate转NSString
     self.timeStr = [dateFormatter stringFromDate:date];
     NSString *ccc=[self.timeStr stringByAppendingString:@".caf"];
     urlStrs=[urlStrs stringByAppendingPathComponent:ccc];
     urlStr = urlStrs;
     tmpUrl =[NSURL fileURLWithPath:urlStr];
    // NSLog(@"第一个页面的路径",url);
     return tmpUrl;
}

-(void)audioBtnAction{
    if (self.status == 0) {//录制
        self.status = 1;
        [self prepareTheRecording];
        [self beginRecordingAction];
    }else if (self.status == 1){//完成
        [recordTimer invalidate];
        recordTimer = nil;
        [self.deleteBtn setHidden:false];
        [self pauseRecordingAction];
    }else if (self.status == 2){//播放
        [self playTheAudioWithFilePath];
    }else if (self.status == 3){//停止播放
        [self stopPlay];
    }{}
}

#pragma mark --删除录音--
-(void)deleteBtnAction{
    [self stopPlay];
    self.status = 0;
    self.deleteBtn.hidden = true;
    [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_audio"] forState:UIControlStateNormal];
    recordSecond = 0;
    minuteRecord = 0;
    playSecond = 0;
    minutePlay = 0;
    //删除录音文件
    NSFileManager  *fileManager = [NSFileManager defaultManager];
//    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // caf文件路径
//    tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.caf"]];
    if (self.timeStr.length > 0 && tmpUrl) {
        [fileManager removeItemAtURL:tmpUrl error:NULL];
        tmpUrl = nil;
        self.timeStr = @"";
        urlStr = @"";
    }
    
//    [self.audioBackV removeFromSuperview];
    [self.audioBackV prepareTheProgressLayerWithShapeLayer];
    //重新添加环形进度条
//    self.audioBackV = [[CircleProgessView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 56.5, 84, 113, 113) withRadius:56.5f withLineWidth:1.99f];
//    self.audioBackV.layer.borderColor = [UIColor colorWithHexString:@"#46403B"].CGColor;
//    [self insertSubview:self.audioBackV atIndex:0];
//    [self bringSubviewToFront:self.deleteBtn];
//    self.audioBackV.frame = CGRectMake(self.frame.size.width/2 - 56.5, 84, 113, 113);
    self.timeLab.text = @"00: 00";
}

#pragma mark --开始录制--
-(void)beginRecordingAction{
    self.status = 1;
    [self.deleteBtn setHidden:true];
    NSLog(@"开始录音");
    if (recorder) {
        [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"mine_stop"] forState:UIControlStateNormal];
        //启动或者恢复记录的录音文件
        if ([recorder prepareToRecord] == YES) {
            [recorder record];
            recordSecond = 0;
            minuteRecord = 0;
            [self.audioBackV updateProgress:0];
            [self.audioBackV beginRecordingAnmation];
            recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordSecondChange) userInfo:nil repeats:YES];
            [recordTimer fire];
        }else{
            
        }
    }else {
        NSLog(@"录音创建失败");
    }
}

#pragma mark --暂停操作--
- (void)pauseRecordingAction {
    self.status = 2;
    [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    //停止录音
    [recorder stop];
    [self.audioBackV pauseTheAnmaition];
    [recordTimer invalidate];
    recordTimer = nil;
    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

#pragma  mark --总时间设置--
-(void)totalRecordTime{
    self.status = 3;
    playSecond = 0;
    [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    [self.deleteBtn setHidden:false];
    NSLog(@"停止录音");
    //停止录音
    [recorder stop];
    [self.audioBackV stopTheAnmation];
    [recordTimer invalidate];
    recordTimer = nil;
    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

#pragma mark --继续录制--
-(void)goOnRecord{
if (recorder) {
    self.status = 1;
    [self.deleteBtn setHidden:true];
    //启动或者恢复记录的录音文件
    if ([recorder prepareToRecord] == YES) {
        [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_stop"] forState:UIControlStateNormal];
        [self.audioBackV goOnRecording];
        [recordTimer fire];
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordSecondChange) userInfo:nil repeats:YES];
        [recordTimer fire];
    }
  }
}
/**
 录音计时
 */
- (void)recordSecondChange {
    recordSecond ++;
    if (recordSecond + minuteRecord*60 == maxTime) {
        [self totalRecordTime];
    }
    if (recordSecond > 59) {
        minuteRecord += 1;
        recordSecond = 0;
    }
    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

-(void)prepareTheRecording{
    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    [recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    NSError *error = nil;
    NSFileManager  *fileManager = [NSFileManager defaultManager];
//    NSString *recordUrls = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // caf文件路径
    if (tmpUrl) {
        [fileManager removeItemAtURL:tmpUrl error:NULL];
        self.timeStr = @"";
    }
    recorder = [[AVAudioRecorder alloc]initWithURL:[self getSavePath] settings:recordSettings error:&error];
}
#pragma mark --play--
-(void)playTheAudioWithFilePath{
    self.status = 3;
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlStr])
      {
//          NSURL   *musicUrl = [NSURL fileURLWithPath:urlStr];
          NSError *myError = nil;
          //创建播放器
         player = [[AVAudioPlayer alloc] initWithContentsOfURL:tmpUrl error:&myError];
//          AVAudioPlayer  *player  = [AVAudioPlayer alloc]ini
//          AVAudioPlayer  *player = [[AVAudioPlayer alloc]initWithData:data error:&myError];
//          player.delegate = self;
          if (player == nil)
          {
              NSLog(@"error === %@",[myError description]);
          }
          [player setVolume:1];   //设置音量大小
          player.numberOfLoops = 0;//设置音乐播放次数  -1为一直循环
          //设置为播放状态
          [audioSession setActive:YES error:nil];
          [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
          [player play];
          playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playSecondChange) userInfo:nil repeats:YES];
          [playTimer fire];
          [self.audioBackV prepareTheProgressLayerWithShapeLayer];
          [self.audioBackV updateProgressWithTime:recordSecond + minuteRecord*60];
//          [self.audioBtn.imageView startAnimating];
      }else{
          self.status = 0;
          [self.audioBtn setImage:ImageName(@"mine_volice") forState:UIControlStateNormal];
          [YPCSVProgress showStatusMessageWithTitle:@"please record the sound." finishBlock:nil];
      }
}

-(void)playSecondChange{
    playSecond ++;
    if (minutePlay*60 + playSecond == recordSecond + minuteRecord*60) {
        [self stopPlay];
        [self.audioBackV stopTheAnmation];
    }
    if (playSecond > 59) {
        minutePlay += 1;
        playSecond = 0;
    }
    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minutePlay,(long)playSecond];
}

-(void)stopPlay{
    [self.audioBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    [player stop];
    playSecond = 0;
    minutePlay = 0;
    [playTimer invalidate];
    playTimer = nil;
    self.status = 2;
    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minutePlay,(long)playSecond];
}

-(void)removeTheVoiceFile{
    NSFileManager  *fileManager = [NSFileManager defaultManager];
//    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // caf文件路径
//    tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.caf"]];
    if (self.timeStr.length > 0 && tmpUrl) {
        [fileManager removeItemAtURL:tmpUrl error:NULL];
        tmpUrl = nil;
        self.timeStr = @"";
    }
}


-(void)getTheVoiceStatus{
    AVAuthorizationStatus  authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    
                }else{
                    [YPCSVProgress showSuccessWithStatus:@"You haven't turned on the microphone permission, please turn on the microphone"];
                }
            });
        }];
    }
}
@end
