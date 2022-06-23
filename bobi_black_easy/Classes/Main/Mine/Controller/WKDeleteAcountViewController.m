//
//  WKDeleteAcountViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKDeleteAcountViewController.h"
#import "WKDeleteView.h"
#import "WKLoginOutView.h"

@interface WKDeleteAcountViewController ()
@property (nonatomic, strong) WKDeleteView *deleteView;

@end

@implementation WKDeleteAcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Delete my account"];
}

- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.deleteView];
}

- (void)createLayout {
    [super createLayout];
    [self.deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"deleteAcountClickAction"]) {
        WKLoginOutView *outView = [[WKLoginOutView alloc] initWithLoginOut:@"Delete my account" content:@"If you delete your account, you\nwill permanently lose your profile,\nmessages, photo."];
        outView.block = ^{
            [[DBManager sharedInstance] createDB];
            [[DBManager sharedInstance] removePerson:[[WKUserInforManager sharedInstance] getUserInforUserAcount] completion:^(BOOL success) {
                NSLog(@"%d",success);
            }];
            [[WKUserInforManager sharedInstance] clearCachedUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
        };
        [outView showAnimation];
        
    }
}
#pragma mark - lazy
- (WKDeleteView *)deleteView {
    if (!_deleteView) {
        _deleteView = [[WKDeleteView alloc] init];
    }
    return _deleteView;
}


@end
