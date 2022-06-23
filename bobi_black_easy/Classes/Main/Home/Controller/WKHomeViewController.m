//
//  WKHomeViewController.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKHomeViewController.h"
#import "WKHomeView.h"
#import "LKPickerViewController.h"
#import "RecordCustomView.h"
#import "PlayeCustom.h"
#import "WKBlankPagesViewController.h"
#import "WKMineViewController.h"
#import "WKReportViewController.h"
#import "WKNoMessageController.h"
#import "VideoCustomView.h"
#import "WKVoiceListController.h"
#import "WKMessageViewController.h"
#import "BobiEasyHeader.h"

@interface WKHomeViewController ()<LKWSYPickerDelegate,LKWSYPickerDataSource,RecordCustDelegate,PlayeCustomDelegate>
{
    LKPickerViewController  *picker;
//    WsyHudProgressView   *hud;
}
@property (nonatomic, strong) WKHomeView *homeView;
@property(nonatomic,strong)NSArray   *dataArr;
@property(nonatomic,strong)UIImageView       *backImgV;
@property(nonatomic,strong)RecordCustomView   *recordV;
@property(nonatomic,strong)PlayeCustom     *playeView;
@property(nonatomic,strong)VideoCustomView  *videoView;
@property(nonatomic,strong)NSMutableArray   *dicArr;
@property(nonatomic,strong)NSMutableArray   *numArr;
@property(nonatomic,strong)NSMutableArray   *btnArray;
@property(nonatomic,assign)NSInteger   currentIndex;
@property(nonatomic,assign)NSInteger  isAudio;  // 0    1    2
@end

@implementation WKHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarWithAnimated:NO];
    self.numArr = [self createTheArc4randomfrom:0 ToEndNum:self.dataArr.count - 1 AndTotleNum:6 > self.dataArr.count ? self.dataArr.count - 1 : 6];
    self.dicArr = [NSMutableArray arrayWithCapacity:0];
    for (NSString  *str in self.numArr) {
        NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:[str integerValue]];
        [self.dicArr addObject:dic];
    }
    self.homeView.wsy_dataArr = self.dicArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.homeView];
}

- (void)createLayout {
    [super createLayout];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"BlankXBPages"]) {//BlankPages
        //录音列表
        WKNoMessageController  *vc = [[WKNoMessageController alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }else if ([eventName isEqualToString:@"botomBlankPages"]) {
        if ([userInfo[@"tag"] integerValue] == 0) {
            //刷新随机6条数据
//            NSMutableArray  *userDataArr = [WKUserInforManager sharedInstance]
            NSMutableArray  *dataArray = [self createTheArc4randomfrom:0 ToEndNum:self.dataArr.count - 1  AndTotleNum: self.dataArr.count > 6 ? 6 : self.dataArr.count];
            NSMutableArray  *tempArr = [NSMutableArray arrayWithCapacity:0];
            for (NSString  *str in dataArray) {
                NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:[str integerValue]];
                [tempArr addObject:dic];
            }
            [self.homeView.imageBg freshTheAnmation];
            self.homeView.wsy_dataArr = tempArr;
        }else if ([userInfo[@"tag"] integerValue] == 1){
            [self recordingAction];
        }else{
            //录音列表
            WKVoiceListController  *vc = [[WKVoiceListController alloc]init];
            [self.navigationController pushViewController:vc animated:true];
        }
    } else if ([eventName isEqualToString:@"OnPersonBtnClick"]) {
        WKMineViewController *mineVc = [[WKMineViewController alloc] init];
        [self.navigationController pushViewController:mineVc animated:YES];
    }else if ([eventName isEqualToString:@"contractEachOthers"]){
        //点击某条录音
        self.playeView.dic = [userInfo objectForKey:@"dic"];
        self.videoView.dic = [userInfo objectForKey:@"dic"];
        self.currentIndex = [[userInfo objectForKey:@"index"] integerValue];
        [self playerAudioAction];
    }
}
#pragma mark - lazu
- (WKHomeView *)homeView {
    if (!_homeView) {
        _homeView = [[WKHomeView alloc] init];
    }
    return _homeView;
}

-(NSArray *)dataArr{
    return  [[WKUserInforManager sharedInstance] getUserDataList] ? [[WKUserInforManager sharedInstance] getUserDataList] : [NSMutableArray arrayWithCapacity:0];
}
-(PlayeCustom *)playeView{
    if (!_playeView) {
        _playeView = [[PlayeCustom alloc]initWithFrame:CGRectMake(0, 0, KWidth - 52, 430)];
        _playeView.layer.masksToBounds = true;
        _playeView.layer.cornerRadius = 5.0f;
        _playeView.delegate = self;
    }
    return _playeView;
}

-(RecordCustomView *)getNewRecordVEveryOne{
    _recordV = nil;
    _recordV = [[RecordCustomView alloc]initWithFrame:CGRectMake(0, 0,KWidth - 52, 430)];
    _recordV.layer.masksToBounds = true;
    _recordV.layer.cornerRadius = 5.0f;
    _recordV.delegate = self;
    return _recordV;
}

-(VideoCustomView *)videoView{
    if (!_videoView ) {
        _videoView = [[VideoCustomView alloc]initWithFrame:CGRectMake(0, 0, KWidth - 52, 300)];
        _videoView.layer.masksToBounds = true;
        _videoView.layer.cornerRadius = 5.0f;
        __weak typeof (self)weakSelf = self;
        _videoView.block = ^{
            [weakSelf cancelAction];
        };
    }
    return _videoView;
}
//录音
-(void)recordingAction{
    _isAudio = 1;
    picker = [[LKPickerViewController alloc]init];
    picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
    picker.delegate = self;
    picker.dataSource = self;
    [self presentViewController:picker animated:false completion:nil];
}

- (LKWSYPickerStyleType)lkwsyPickerStyleType{
    return LKWSYPickerStyle_center;
}

-(LKWSYPickerType)lkwsyPickerType{
    return LKWSYPickerType_custom;
}

-(NSInteger)lkwsyPickerHeight{
    return 430;
}

-(UIView *)lkwsyPickerViewCustomBackContentView{
    return  _isAudio == 1 ? [self getNewRecordVEveryOne] : (_isAudio == 0 ?  self.playeView : self.videoView);
}

-(void)cancelAction{
    [picker dismissViewControllerAnimated:false completion:nil];
}

//播放
-(void)playerAudioAction{
    _isAudio = 0;
//    self.playeView
    picker = [[LKPickerViewController alloc]init];
    picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
    picker.delegate = self;
    picker.dataSource = self;
    [self presentViewController:picker animated:false completion:nil];
}


-(void)dissThePlayerView{
    [picker dismissViewControllerAnimated:false completion:nil];
}

-(void)senderAudioAction{
    [picker dismissViewControllerAnimated:false completion:^{
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:nil];
        }];
//        [WsyHudProgressView showToast:@"" withView:self.view animated:true];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:nil];
//            [YPCSVProgress showSuccessWithStatus:@"success"];
//        });
    }];
}
//视频聊天
-(void)videoWithOthersAction{
    [picker dismissViewControllerAnimated:false completion:^{
//    [WsyHudProgressView showToast:@"" withView:self.view animated:true];
    [self showProgressView:^(BOOL isDone) {
        self->_isAudio = 2;
        self->picker = [[LKPickerViewController alloc]init];
        self->picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
        self->picker.delegate = self;
        self->picker.dataSource = self;
        [self presentViewController:self->picker animated:false completion:nil];

    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self->_isAudio = 2;
//            self->picker = [[LKPickerViewController alloc]init];
//            self->picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
//            self->picker.delegate = self;
//            self->picker.dataSource = self;
//            [self presentViewController:self->picker animated:false completion:nil];
//        });
    }];
}

-(void)rightItemAction:(NSInteger)index AndTheDic:(NSDictionary *)dic{
    NSDictionary  *tempDic = [NSDictionary dictionaryWithDictionary:dic];
    if (index == 0 || index == 1) {
        //block
        //delete
        [self->picker dismissViewControllerAnimated:false completion:^{
            [self showProgressView:^(BOOL isDone) {
                [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:^{
                        NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
                        NSInteger  num  = [self creatThesingleNumWithMaxNum:arr.count -1 ridOfArr:self.numArr];
                        if (num >= 0) {
                            [self.numArr replaceObjectAtIndex:self.currentIndex withObject:[NSString stringWithFormat:@"%ld", num]];
                            NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:num];
                            [self.dicArr replaceObjectAtIndex:self.currentIndex withObject:dic];
                        }else{
                            [self.dicArr removeObjectAtIndex:self.currentIndex];
                        }
                        self.homeView.wsy_dataArr = self.dicArr;
                        [self DeleteTheVoiceMessage];
                        
                        NSLog(@"numArr：%@ ----dicArr:%@",self.numArr,self.dicArr);
                }];
            }];
        }];
        
//        [self showProgressView:^(BOOL isDone) {
//            [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:^{
////                [self->picker dismissViewControllerAnimated:false completion:^{
//                    NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
//                    NSInteger  num  = [self creatThesingleNumWithMaxNum:arr.count -1 ridOfArr:self.numArr];
//                    if (num >= 0) {
//                        [self.numArr replaceObjectAtIndex:self.currentIndex withObject:[NSString stringWithFormat:@"%ld", num]];
//                        NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:num];
//                        [self.dicArr replaceObjectAtIndex:self.currentIndex withObject:dic];
//                    }else{
//                        [self.dicArr removeObjectAtIndex:self.currentIndex];
//                    }
//                    self.homeView.wsy_dataArr = self.dicArr;
//                    [self DeleteTheVoiceMessage];
//
//                    NSLog(@"numArr：%@ ----dicArr:%@",self.numArr,self.dicArr);
////                }];
//            }];
//        }];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self->picker dismissViewControllerAnimated:false completion:^{
//                NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
//                NSInteger  num  = [self creatThesingleNumWithMaxNum:arr.count -1 ridOfArr:self.numArr];
//                if (num >= 0) {
//                    [self.numArr replaceObjectAtIndex:self.currentIndex withObject:[NSString stringWithFormat:@"%ld", num]];
//                    NSDictionary  *dic = [self.dataArr objcetSafeGetIndex:num];
//                    [self.dicArr replaceObjectAtIndex:self.currentIndex withObject:dic];
//                }else{
//                    [self.dicArr removeObjectAtIndex:self.currentIndex];
//                }
//                self.homeView.wsy_dataArr = self.dicArr;
//                [self DeleteTheVoiceMessage];
//                [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:nil];
//                NSLog(@"numArr：%@ ----dicArr:%@",self.numArr,self.dicArr);
//            }];
//        });
    }else if (index == 2){
        //report
        [picker dismissViewControllerAnimated:false completion:^{
            WKReportViewController  *reportVc = [[WKReportViewController alloc]init];
            reportVc.dic = tempDic;
            [self.navigationController pushViewController:reportVc animated:true];
        }];
    }else if (index == 3){
      //cancel
        [picker dismissViewControllerAnimated:false completion:nil];
    }
}

-(void)messageWithOthersAction{
    [picker dismissViewControllerAnimated:false completion:^{
        WKMessageViewController  *mesgVc = [[WKMessageViewController alloc]init];
        mesgVc.dic = [self.dataArr objcetSafeGetIndex:self.currentIndex];
        [self.navigationController pushViewController:mesgVc animated:false];
    }];
}

#pragma mark --生成多个不同的随机数--
//生成多个不同的随机数
//                                                0                             10         6
-(NSMutableArray  *)createTheArc4randomfrom:(NSInteger)startNum ToEndNum:(NSInteger)endNum AndTotleNum:(NSInteger)totleNum{
    NSMutableArray  *tempArr = [NSMutableArray array];
    do {
        NSInteger  vaNum = arc4random() % (endNum+1);
        BOOL  haveDone = false;
        for (int i = 0;i < tempArr.count;i++) {
            NSInteger index = [tempArr[i] integerValue];
            if (vaNum == index) {
                haveDone = true;
            }
        }
        if (haveDone == false) {
            [tempArr addObject:[NSString stringWithFormat:@"%ld",vaNum]];
        }
    } while (tempArr.count < totleNum);
    return tempArr;
}

#pragma mark --在剩余的n个数中随机生成一个--
//在剩余的n个数中随机生成一个
-(NSInteger)creatThesingleNumWithMaxNum:(NSInteger)maxNum ridOfArr:(NSMutableArray *)numArr{
    NSMutableArray  *tempArr = [NSMutableArray arrayWithCapacity:0];
    NSInteger  vaNum;
    for (int i = 0; i < maxNum; i++) {
        BOOL add = true;
        for (NSString *num in numArr) {
            if (i == [num integerValue]) {
                add = false;
            }
        }
        if (add == true) {
            [tempArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    if (tempArr.count > 0){
        vaNum  = arc4random() % (tempArr.count);
        return [[tempArr objcetSafeGetIndex:vaNum] integerValue];
    }else{
        return -1;
    }
}
#pragma  mark --删除操作--
-(void)DeleteTheVoiceMessage{
    NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
    bool   isHave = false;
    NSDictionary  *currentDic = [self.dataArr objcetSafeGetIndex:[[self.numArr objcetSafeGetIndex:self.currentIndex]integerValue]];
    NSDictionary  *deleteDic;
    for (NSDictionary  *tempDic  in arr) {
        if (![tempDic isKindOfClass:[NSNull class]]) {
            NSString  *name = [tempDic objectForKey:@"name"];
            NSString  *icon = [tempDic objectForKey:@"icon"];
            NSString  *voice = [tempDic objectForKey:@"voice"];
            if ([name isEqualToString:[currentDic objectForKey:@"name"]] && [icon isEqualToString:[currentDic objectForKey:@"icon"]] && [voice isEqualToString:[currentDic objectForKey:@"voice"]]) {
                isHave = true;
                [arr removeObject:tempDic];
                deleteDic = tempDic;
            }
        }
    }
    if (isHave == true) {
        [arr removeObject:deleteDic];
    }
    [[WKUserInforManager sharedInstance] deletTheUserDicFromeDataList:currentDic];
    [[WKUserInforManager sharedInstance] changeTheVoiceListAction:arr];

}

-(void)lkwsyWillDisApperar{
    if (_isAudio == 1) {
        [_recordV removeTheVoiceFile];
    }
}

@end
