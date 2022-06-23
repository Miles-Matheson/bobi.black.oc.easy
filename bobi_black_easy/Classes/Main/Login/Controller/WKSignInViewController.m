//
//  WKSignInViewController.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKSignInViewController.h"
#import "WKSignInView.h"
#import "WKForgetPasswordViewController.h"
#import "BobiEasyHeader.h"
@interface WKSignInViewController ()
@property (nonatomic, strong) WKSignInView *signInView;

@end

@implementation WKSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Sign in"];
}

- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.signInView];
}

- (void)createLayout {
    [super createLayout];
    [self.signInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"OnSignInclickAction"]) {//sign in
        [self showProgressView:^(BOOL isDone) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        }];
    } else {
        WKForgetPasswordViewController *forgetVc = [[WKForgetPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetVc animated:YES];
    }
}

#pragma mark - lazy
- (WKSignInView *)signInView {
    if (!_signInView) {
        _signInView = [[WKSignInView alloc] init];
    }
    return _signInView;
}


@end
