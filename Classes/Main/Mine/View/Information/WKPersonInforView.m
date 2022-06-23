//
//  WKPersonInforView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKPersonInforView.h"
#import "WKInforView.h"

@interface WKPersonInforView ()
@property (nonatomic, strong) WKInforView *userNameView;
@property (nonatomic, strong) WKInforView *sexView;
@property (nonatomic, strong) WKInforView *ageView;

@end

@implementation WKPersonInforView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.userNameView];
    [self.containerView addSubview:self.sexView];
    [self.containerView addSubview:self.ageView];
}

- (void)createLayout {
    [super createLayout];
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(KRelative(100));
    }];
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameView.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(KRelative(100));
    }];
    [self.ageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexView.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(KRelative(100));
        make.bottom.offset(0);
    }];
}

- (void)changeUserInforSex:(NSString *)sex {
    [self.sexView changeUserInforSex:sex];
}
- (void)changeUserInforAge:(NSString *)age {
    [self.ageView changeUserInforAge:age];
}

#pragma mark - lazy
- (WKInforView *)userNameView {
    if (!_userNameView) {
        _userNameView = [[WKInforView alloc] init];
        [_userNameView configHeadTile:@"Username" andValue:[[WKUserInforManager sharedInstance] getUserInforUserName] ? [[WKUserInforManager sharedInstance] getUserInforUserName]:@"UserName"];
    }
    return _userNameView;
}
- (WKInforView *)sexView {
    if (!_sexView) {
        _sexView = [[WKInforView alloc] init];
        [_sexView addTarget:self selector:@selector(onChangeSex)];
        [_sexView configHeadTile:@"Gender" andValue:[[WKUserInforManager sharedInstance] getUserInforSex] ? [[WKUserInforManager sharedInstance] getUserInforSex]:@"add"];
    }
    return _sexView;
}
- (WKInforView *)ageView {
    if (!_ageView) {
        _ageView = [[WKInforView alloc] init];
        [_ageView addTarget:self selector:@selector(onChangeAge)];
        [_ageView configHeadTile:@"Age" andValue:[[WKUserInforManager sharedInstance] getUserInforAge] ? [[WKUserInforManager sharedInstance] getUserInforAge]:@"add"];
    }
    return _ageView;
}
- (void)onChangeSex {
    [self routerEventWithName:@"changeSexAction" userInfo:@{}];
}
- (void)onChangeAge {
    [self routerEventWithName:@"changeAgeAction" userInfo:@{}];
}
@end
