//
//  WKAboutUsView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKAboutUsView.h"
#import "WKDelegateView.h"

@interface WKAboutUsView ()
@property (nonatomic, strong) WKDelegateView *serviceView;
@property (nonatomic, strong) WKDelegateView *privacyView;

@end

@implementation WKAboutUsView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.serviceView];
    [self.containerView addSubview:self.privacyView];
}

- (void)createLayout {
    [super createLayout];
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(KRelative(40));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(100));
    }];
    [self.privacyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(100));
        make.top.equalTo(self.serviceView.mas_bottom).offset(KRelative(36));
    }];
}
#pragma mark - lazy
- (WKDelegateView *)serviceView {
    if (!_serviceView) {
        _serviceView = [[WKDelegateView alloc] init];
        _serviceView.layer.cornerRadius = KRelative(10);
        _serviceView.clipsToBounds = YES;
        [_serviceView configTitleAction:@"Service Agreement"];
        [_serviceView addTarget:self selector:@selector(onServerClick)];
    }
    return _serviceView;
}
- (WKDelegateView *)privacyView {
    if (!_privacyView) {
        _privacyView = [[WKDelegateView alloc] init];
        _privacyView.layer.cornerRadius = KRelative(10);
        _privacyView.clipsToBounds = YES;
        [_privacyView configTitleAction:@"Privacy Policy"];
        [_privacyView addTarget:self selector:@selector(onPrivacyClick)];
    }
    return _privacyView;
}
- (void)onServerClick {
    
    [self routerEventWithName:@"serviceView" userInfo:@{}];
}
- (void)onPrivacyClick {
    [self routerEventWithName:@"privacyView" userInfo:@{}];
}

@end
