//
//  WKVoiceListController.m
//  Woko
//
//  Created by 王树银 on 2022/4/26.
//

#import "WKVoiceListController.h"
#import "WKVoiceListCollectCell.h"
#import "LKPickerViewController.h"
#import "WKMessageViewController.h"
#import "WKReportViewController.h"
#import "WKUserInforManager.h"
#import "WsyHudProgressView.h"
#import "VideoCustomView.h"
#import "PlayeCustom.h"
#import "WsyStrokeLab.h"
#import "WsyEmptyView.h"

@interface WKVoiceListController ()<UICollectionViewDelegate,UICollectionViewDataSource,LKWSYPickerDelegate,LKWSYPickerDataSource,PlayeCustomDelegate>
{
    LKPickerViewController  *picker;
}
@property(nonatomic,strong)UICollectionView   *colectV;

@property(nonatomic,strong)WsyStrokeLab   *titleLab;
@property(nonatomic,strong)PlayeCustom  *playerView;
@property(nonatomic,strong)VideoCustomView  *videoView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSDictionary  *currentDic;
@property(nonatomic,strong)WsyEmptyView    *emptyView;
@property(nonatomic,assign)NSInteger   currentIndex;
@property(nonatomic,assign)BOOL  isVideo;
@end

@implementation WKVoiceListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showNavigationBar];
    self.navigationItem.titleView = self.titleLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.colectV];
    self.colectV.delegate = self;
    self.colectV.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#221E1E"];
    [self.view addSubview:self.emptyView];
    self.emptyView.frame = CGRectMake(50, 120, KWidth - 100, 264);
    [self.view bringSubviewToFront:self.emptyView];
    [self setDataArr:[[WKUserInforManager sharedInstance] getUserVoiceList]];
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    if ([_dataArr count] > 0) {
        self.emptyView.hidden = true;
        [self.colectV reloadData];
    }
}

-(WsyEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[WsyEmptyView alloc]initWithFrame:CGRectMake(0, 0, KWidth - 100, 264)];
        [_emptyView.btn addTarget:self selector:@selector(popClickAction)];
    }
    return _emptyView;
}

-(void)popClickAction{
    [self.navigationController popViewControllerAnimated:true];
}
//-(NSMutableArray *)dataArr{
//    return [[WKUserInforManager sharedInstance] getUserVoiceList];
//}

-(WsyStrokeLab *)titleLab{
    if (!_titleLab) {
        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.outLineWidth = 0.0f;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
        _titleLab.text = @"Meet Suprise";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(PlayeCustom *)playerView{
    if (!_playerView) {
        _playerView = [[PlayeCustom alloc]initWithFrame:CGRectMake(0, 0, KWidth - 52, 430)];
        _playerView.layer.masksToBounds = true;
        _playerView.layer.cornerRadius = 5.0f;
        _playerView.delegate = self;
    }
    return _playerView;
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

-(UICollectionView *)colectV{
    if (!_colectV) {
        UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 18;
        layout.minimumLineSpacing = 18;
        layout.itemSize = CGSizeMake(KWidth/2 - 27,(KWidth/2 - 27)*5/4);
//        _colectV.contentInset = UIEdgeInsetsMake(20, -18, 0, -18);
        _colectV = [[UICollectionView alloc]initWithFrame:CGRectMake(18, 20, KWidth - 36, KHeight - 20) collectionViewLayout:layout];
        _colectV.backgroundColor = [UIColor clearColor];
    }
    return _colectV;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentDic = [self.dataArr objcetSafeGetIndex:indexPath.item];
    self.currentIndex = indexPath.item;
    picker = [[LKPickerViewController alloc]init];
    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
    picker.delegate = self;
    picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
    picker.dataSource = self;
    self.isVideo = false;
    self.playerView.dic = self.currentDic;
    self.videoView.dic = self.currentDic;
    [self presentViewController:picker animated:false completion:nil];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVoiceListCollectCell *cell = [WKVoiceListCollectCell creatTheCollectView:collectionView AndTheIndexPath:indexPath];
    cell.dic = [self.dataArr objcetSafeGetIndex:indexPath.item];
    cell.block = ^(NSDictionary * _Nonnull dic) {
        self->picker = [[LKPickerViewController alloc]init];
        self->picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
        self->picker.delegate = self;
        self->picker.dataSource = self;
        self.isVideo = true;
        self.videoView.dic = dic;
        [self presentViewController:self->picker animated:false completion:nil];
    };
    return cell;
}

-(void)recordingAction{
    picker = [[LKPickerViewController alloc]init];
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
    return  _isVideo == false ? self.playerView : self.videoView;
}

-(void)dissThePlayerView{
    [picker dismissViewControllerAnimated:false completion:^{
        
    }];
}

-(void)cancelAction{
    [picker dismissViewControllerAnimated:false completion:nil];
}

-(void)rightItemAction:(NSInteger)index AndTheDic:(NSDictionary *)dic{
    NSDictionary  *tempDic = [NSDictionary dictionaryWithDictionary:dic];
    if (index == 0 || index == 1) {
        //delete
        [picker dismissViewControllerAnimated:false completion:^{
//            dispatch_sync(dispatch_get_main_queue(), ^{
                [self showProgressView:^(BOOL isDone) {
                    [YPCSVProgress showStatusMessageWithTitle:@"success." finishBlock:^{
                        [self DeleteTheVoiceMessage:self.currentDic];
                    }];
                }];
//            });
        }];
//        [self showProgressView:^(BOOL isDone) {
//            [YPCSVProgress showStatusMessageWithTitle:@"success." finishBlock:^{
//                [picker dismissViewControllerAnimated:false completion:^{
//
//                }];
//            }];
//        }];
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
        [self.navigationController pushViewController:mesgVc animated:true];
    }];
}
//视频聊天
-(void)videoWithOthersAction{
    
//    [picker dismissViewControllerAnimated:false completion:^{
//        self->_isVideo = true;
//       self->picker = [[LKPickerViewController alloc]init];
//        self->picker.modalPresentationStyle = UIModalPresentationFullScreen;
//        self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
//        self->picker.delegate = self;
//       self->picker.dataSource = self;
//        [self presentViewController:self->picker animated:false completion:nil];
//    }];
    
    [picker dismissViewControllerAnimated:false completion:^{
//    [WsyHudProgressView showToast:@"" withView:self.view animated:true];
        [self showProgressView:^(BOOL isDone) {
            self->_isVideo = true;
            self->picker = [[LKPickerViewController alloc]init];
            self->picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
            self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
            self->picker.delegate = self;
            self->picker.dataSource = self;
            [self presentViewController:self->picker animated:false completion:nil];

        }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self->_isVideo = true;
//            self->picker = [[LKPickerViewController alloc]init];
//            self->picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            self->picker.ContentAnmationType = LKWSYPickerContentAnmationType_smallToBig;
//            self->picker.delegate = self;
//            self->picker.dataSource = self;
//            [self presentViewController:self->picker animated:false completion:nil];
//        });
    }];

    
    
}

#pragma  mark --删除操作--
-(void)DeleteTheVoiceMessage:(NSDictionary *)dic{
    NSMutableArray *arr = [[WKUserInforManager sharedInstance] getUserVoiceList];
    [arr removeObject:dic];
    [[WKUserInforManager sharedInstance] deletTheUserDicFromeDataList:self.currentDic];
    [[WKUserInforManager sharedInstance] changeTheVoiceListAction:arr];
    [self.colectV reloadData];
    if (self.dataArr.count == 0) {
        self.emptyView.hidden = false;
    }

}

-(void)backToPrevious{
    [self.navigationController popViewControllerAnimated:false];
}

@end
