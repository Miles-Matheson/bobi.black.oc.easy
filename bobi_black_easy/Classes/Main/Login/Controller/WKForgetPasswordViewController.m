//
//  WKForgetPasswordViewController.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKForgetPasswordViewController.h"
#import "WKForgetPswView.h"

@interface WKForgetPasswordViewController ()
@property (nonatomic, strong) WKForgetPswView *ForgetPswView;

@end

@implementation WKForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Forgot Password"];
    
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.ForgetPswView];
}

- (void)createLayout {
    [super createLayout];
    [self.ForgetPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"ContinueClickAction"]) {
        @ktweakify(self)
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showSuccessMessageWithTitle:@"send successful" finishBlock:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @ktstrongify(self)
                [self backToPrevious];
            });
        }];
    }
}

#pragma mark - lazy
- (WKForgetPswView *)ForgetPswView {
    if (!_ForgetPswView) {
        _ForgetPswView = [[WKForgetPswView alloc] init];
    }
    return _ForgetPswView;
}


@end
