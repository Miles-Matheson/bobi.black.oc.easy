//
//  WKHomeView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKHomeView.h"
#import "WKHomeTopView.h"
#import "WKHomeBottomView.h"
#import "BobiEasyHeader.h"
@interface WKHomeView ()
@property (nonatomic, strong) WKHomeTopView *topView;
@property (nonatomic, strong) WKHomeBottomView *bttomView;

@end

@implementation WKHomeView

- (void)createUI {
    [super createUI];
    _wsy_dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:self.imageBg];
    [self.containerView addSubview:self.bttomView];
    __weak __typeof(self) weakSelf = self;
    self.imageBg.block = ^(NSDictionary * _Nonnull dic, NSInteger index) {
        NSMutableDictionary  *params = [NSMutableDictionary dictionary];
        [params setObject:dic forKey:@"dic"];
        [params setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"index"];
        [weakSelf routerEventWithName:@"contractEachOthers" userInfo:params];
    };
}

- (void)createLayout {
    [super createLayout];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    [self.imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.center.equalTo(self.containerView);
        make.height.equalTo(@465);
    }];
    [self.bttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(60));
        make.right.offset(-KRelative(60));
        make.bottom.offset(-KRelative(54));
        make.height.offset(KRelative(124));
    }];
}

#pragma mark - lazy
- (WKHomeTopView *)topView {
    if (!_topView) {
        _topView = [[WKHomeTopView alloc] init];
    }
    return _topView;
}

- (WsyBackImageView *)imageBg {
    if (!_imageBg) {
        _imageBg = [[WsyBackImageView alloc] init];
        _imageBg.userInteractionEnabled = true;
    }
    return _imageBg;
}

- (WKHomeBottomView *)bttomView {
    if (!_bttomView) {
        _bttomView = [[WKHomeBottomView alloc] init];
        _bttomView.layer.cornerRadius = KRelative(10);
        _bttomView.clipsToBounds = YES;
    }
    return _bttomView;
}


-(void)setWsy_dataArr:(NSMutableArray *)wsy_dataArr{
    _wsy_dataArr = wsy_dataArr;
    if (_wsy_dataArr.count > 0) {
        self.imageBg.dataArr = _wsy_dataArr;
    }
}
@end
