//
//  WKBottomView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBottomView.h"
#import <AVFoundation/AVFoundation.h>
#import "CircleProgessView.h"
static NSInteger  maxTimes =30;
@interface WKBottomView ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
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

@property(nonatomic,strong)CircleProgessView   *audioBackV;
@property(nonatomic,strong)NSString     *timeStr;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnVolice;
@property (nonatomic, strong) UIButton  *deleteBtn;
@property (nonatomic, strong) UIButton *btnUpload;
@property (nonatomic, assign) NSInteger status;

@end

@implementation WKBottomView

- (void)createUI {
    [super createUI];
   
    [self.containerView addSubview:self.lblTitle];
    _audioBackV = [[CircleProgessView alloc] initWithFrame:CGRectMake(KWidth/2 - KRelative(32) - KRelative(95), KRelative(130), KRelative(190), KRelative(190)) withRadius: KRelative(95) withLineWidth:1.99f];
    _audioBackV.layer.borderColor = [UIColor colorWithHexString:@"#46403B"].CGColor;
    self.containerView.backgroundColor = KHexColor(0x373636);
    [self.containerView addSubview:_audioBackV];
    [self.containerView addSubview:self.btnVolice];
    [self.containerView addSubview:self.deleteBtn];
    [self.containerView addSubview:self.btnUpload];
    _deleteBtn.hidden = true;
}

- (void)createLayout {
    [super createLayout];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.offset(KRelative(60));
        make.height.equalTo(@(KRelative(40)));
    }];
    [self.btnVolice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(KRelative(50));
        make.width.height.equalTo(@(KRelative(150)));
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.btnVolice.mas_right);
        make.centerY.mas_equalTo(self.btnVolice.mas_top);
        make.width.height.equalTo(@40);
    }];
    [self.btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.btnVolice.mas_bottom).offset(KRelative(74));
        make.bottom.offset(-KRelative(60));
        make.size.sizeOffset(CGSizeMake(KRelative(516), KRelative(100)));
    }];
    [self bringSubviewToFront:self.deleteBtn];
}

#pragma mark - lazy
- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = KRelativeBoldFont(34);
        _lblTitle.text = @"Headline by Voice";
    }
    return _lblTitle;
}
- (UIButton *)btnVolice {
    if (!_btnVolice) {
        _btnVolice = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnVolice setImage:ImageName(@"mine_volice") forState:UIControlStateNormal];
        [_btnVolice addTarget:self selector:@selector(audioBtnAction)];
    }
    return _btnVolice;
}
- (UIButton *)btnUpload {
    if (!_btnUpload) {
        _btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUpload.layer.cornerRadius = KRelative(14);
        CGSize size = CGSizeMake(KRelative(516), KRelative(100));
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        [_btnUpload setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_btnUpload setTitle:@"Upload" forState:UIControlStateNormal];
        [_btnUpload setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btnUpload.titleLabel.font = KRelativeBoldFont(36);
        [_btnUpload addTarget:self selector:@selector(uploadBtnAction)];
    }
    return _btnUpload;
}


-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_delete_1"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteBtn;
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
    [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"wsy_audio"] forState:UIControlStateNormal];
    self.deleteBtn.hidden = true;
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
    
//    [_audioBackV.layer removeFromSuperlayer];
//    _audioBackV = nil;
    //重新添加环形进度条
//    self.audioBackV = [[CircleProgessView alloc]initWithFrame:CGRectMake(KWidth/2 - KRelative(32) - KRelative(95), KRelative(130), KRelative(190), KRelative(190)) withRadius: KRelative(95) withLineWidth:1.99f];
//    self.audioBackV.layer.borderColor = [UIColor colorWithHexString:@"#46403B"].CGColor;
//    [self.layer insertSubview:self.audioBackV atIndex:0];
//    [self.layer insertSublayer:self.audioBackV.layer atIndex:0];
//    [self bringSubviewToFront:self.deleteBtn];
    [self.audioBackV prepareTheProgressLayerWithShapeLayer];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}

#pragma mark --开始录制--
-(void)beginRecordingAction{
    self.status = 1;
    [self.deleteBtn setHidden:true];
    NSLog(@"开始录音");
    if (recorder) {
        [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"mine_stop"] forState:UIControlStateNormal];
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
    [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    //停止录音
    [recorder stop];
    [self.audioBackV pauseTheAnmaition];
    [recordTimer invalidate];
    recordTimer = nil;
//    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

#pragma  mark --总时间设置--
-(void)totalRecordTime{
    self.status = 3;
    playSecond = 0;
    [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    [self.deleteBtn setHidden:false];
    NSLog(@"停止录音");
    //停止录音
    [recorder stop];
    [self.audioBackV stopTheAnmation];
    [recordTimer invalidate];
    recordTimer = nil;
//    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

#pragma mark --继续录制--
-(void)goOnRecord{
if (recorder) {
    self.status = 1;
    [self.deleteBtn setHidden:true];
    //启动或者恢复记录的录音文件
    if ([recorder prepareToRecord] == YES) {
        [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"wsy_stop"] forState:UIControlStateNormal];
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
    if (recordSecond + minuteRecord*60 == maxTimes) {
        [self totalRecordTime];
    }
    if (recordSecond > 59) {
        minuteRecord += 1;
        recordSecond = 0;
    }
//    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minuteRecord,(long)recordSecond];
}

-(void)prepareTheRecording{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
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
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlStr])
      {
          self.status = 3;
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
          [self.btnVolice setImage:ImageName(@"mine_volice") forState:UIControlStateNormal];
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
//    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minutePlay,(long)playSecond];
}

-(void)stopPlay{
    [player stop];
    [self.btnVolice setImage:[UIImage mm_xcassetImageNamed:@"wsy_play"] forState:UIControlStateNormal];
    playSecond = 0;
    minutePlay = 0;
    [playTimer invalidate];
    playTimer = nil;
    self.status = 2;
//    self.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minutePlay,(long)playSecond];
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

-(void)uploadBtnAction{
    if (tmpUrl && self.timeStr.length) {
        [self routerEventWithName:@"uploadRecordings" userInfo:@{}];
    }else{
        [YPCSVProgress showStatusMessageWithTitle:@"please record the sound." finishBlock:nil];
//        []
    }
    
}



@end
