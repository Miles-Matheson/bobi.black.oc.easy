//
//  WKAboutUsViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKAboutUsViewController.h"
#import "WKAboutUsView.h"
#import "WKWebViewController.h"
#import "BobiEasyHeader.h"
@interface WKAboutUsViewController ()
@property (nonatomic, strong) WKAboutUsView *aboutView;

@end

@implementation WKAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"About us"];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.aboutView];
}

- (void)createLayout {
    [super createLayout];
    [self.aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"serviceView"]) {
        WKWebViewController *webVc = [[WKWebViewController alloc] init];
        webVc.titleStr = @"Service Agreement";
        webVc.webUrl = Baidu_Url;
        [self.navigationController pushViewController:webVc animated:YES];
    } else {
        WKWebViewController *webVc = [[WKWebViewController alloc] init];
        webVc.titleStr = @"Privacy Policy";
        webVc.webUrl = Else_Url;
        [self.navigationController pushViewController:webVc animated:YES];
    }
}
- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - lazy
- (WKAboutUsView *)aboutView {
    if (!_aboutView) {
        _aboutView = [[WKAboutUsView alloc] init];
    }
    return _aboutView;
}

@end
