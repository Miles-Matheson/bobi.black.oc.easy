//
//  WKSignUpViewController.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKSignUpViewController.h"
#import "WKSignUpView.h"
#import "WKWebViewController.h"
#import "WKUploadImageViewController.h"
#import "BobiEasyHeader.h"
@interface WKSignUpViewController ()
@property (nonatomic, strong) WKSignUpView *signUpView;

@end

@implementation WKSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Sign Up"];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.signUpView];
}

- (void)createLayout {
    [super createLayout];
    [self.signUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName containsString:@"Service"]) {//
        WKWebViewController *webVc = [[WKWebViewController alloc] init];
        webVc.titleStr = @"Service Agreement";
        webVc.webUrl = Baidu_Url;
        [self.navigationController pushViewController:webVc animated:YES];
    } else if ([eventName containsString:@"Privacy"]) {
        WKWebViewController *webVc = [[WKWebViewController alloc] init];
        webVc.titleStr = @"Privacy Policy";
        webVc.webUrl = Else_Url;
        [self.navigationController pushViewController:webVc animated:YES];
    } else {
        WKUploadImageViewController *upLoadVc = [[WKUploadImageViewController alloc] init];
        upLoadVc.email = userInfo[@"email"];
        upLoadVc.passWord = userInfo[@"passWord"];
        upLoadVc.userName = userInfo[@"userName"];
        [self.navigationController pushViewController:upLoadVc animated:YES];
    }
}

- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - lazy
- (WKSignUpView *)signUpView {
    if (!_signUpView) {
        _signUpView = [[WKSignUpView alloc] init];
    }
    return _signUpView;
}


@end
