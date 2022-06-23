//
//  WKMineViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKMineViewController.h"
#import "WKMineView.h"
#import "WKEditViewController.h"
#import "WKContactViewController.h"
#import "WKAboutUsViewController.h"
#import "WKDeleteAcountViewController.h"
#import "WKLoginOutView.h"
#import "BobiEasyHeader.h"
@interface WKMineViewController ()
@property (nonatomic, strong) WKMineView *mineView;

@end

@implementation WKMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarWithAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadHeadImage) name:@"loadHeadImage" object:nil];
}

- (void)upLoadHeadImage {
    [self.mineView updateHeadImageAction];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"MineBackAction"]) {
        [self.navigationController popViewControllerAnimated:NO];
    } else if ([eventName isEqualToString:@"MineEditAction"]) {
        [self.navigationController pushViewController:WKEditViewController.new animated:YES];
    } else if ([eventName isEqualToString:@"menuBtnClick1"]) {
        [self.navigationController pushViewController:WKContactViewController.new animated:YES];
    } else if ([eventName isEqualToString:@"menuBtnClick2"]) {
        [self.navigationController pushViewController:WKAboutUsViewController.new animated:YES];
    } else if ([eventName isEqualToString:@"menuBtnClick3"]) {
        [self.navigationController pushViewController:WKDeleteAcountViewController.new animated:YES];
    } else if ([eventName isEqualToString:@"menuBtnClick4"]) {
        WKLoginOutView *outView = [[WKLoginOutView alloc] initWithLoginOut:@"Log out of my account" content:@"Are you sure you want to sign\nout？"];
        outView.block = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
            [[WKUserInforManager sharedInstance] changeUserLoginStatus:NO];
        };
        [outView showAnimation];
    }
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.mineView];
}
- (void)createLayout {
    [super createLayout];
    [self.mineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
#pragma mark -lazy
- (WKMineView *)mineView {
    if (!_mineView) {
        _mineView = [[WKMineView alloc] init];
    }
    return _mineView;
}

@end
