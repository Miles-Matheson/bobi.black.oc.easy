//
//  WKBaseViewController.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKBaseViewController.h"
#import "UIImage+Custom.h"
#import "HUProgressView.h"
#import "BobiEasyHeader.h"

@interface WKBaseViewController ()
@property (nonatomic, strong) UIBarButtonItem * backBarButtonItem;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation WKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KHexColor(0x221E1E);
    [self setNeedsStatusBarAppearanceUpdate];
   
    // 添加容器试图
    [self createUI];
    [self createLayout];
    
    // 设置导航栏
    [self confitNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)confitNav{

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          KRelativeBoldFont(34),NSFontAttributeName,
                          KHexColor(0xFDCA38),NSForegroundColorAttributeName,nil];
    UIImage *image_background = [UIImage GetImageWithColor:KHexColorAlpha(0x373636, 1) andHeight:44];
    UIImage *image_shadow = [UIImage GetImageWithColor:KHexColorAlpha(0x373636, 1) andHeight:44];
    if (@available(iOS 15.0,*)) {
            
        UINavigationBarAppearance * appearance1 = [[UINavigationBarAppearance alloc] init];
        [appearance1 configureWithDefaultBackground];
        appearance1.backgroundImage = image_background;
        appearance1.shadowColor = nil;//KHexColorAlpha(0xFFFFFF, 1);
        appearance1.shadowImage = [UIImage new];
        appearance1.titleTextAttributes = dict;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance1;
        self.navigationController.navigationBar.standardAppearance = appearance1;
        
        }else{
            UINavigationBar * navigationBar = self.navigationController.navigationBar;
            navigationBar.translucent = NO;
            navigationBar.titleTextAttributes = dict;
            [navigationBar setBackgroundImage:image_background forBarMetrics:UIBarMetricsDefault];
            [navigationBar setShadowImage:image_shadow];
        }
    [self.navigationController setNavigationBarHidden:NO animated:YES];;
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    
}

- (void)configNaviTitleColor:(UIColor *)color {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          KRelativeBoldFont(34),NSFontAttributeName,
                          color,NSForegroundColorAttributeName,nil];
    UINavigationBar * navigationBar = self.navigationController.navigationBar;
    navigationBar.titleTextAttributes = dict;
}

- (void)createUI{
    [self.view addSubview:self.containerView];
}

- (void)createLayout {
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top);
        }
    }];
}

- (void)hideNavigationBarWithAnimated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)showNavigationBar {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setNavigationBarTranslucent {
    
    if (@available(iOS 15.0,*)) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              KRelativeBoldFont(34),NSFontAttributeName,
                              KHexColor(0xFDCA38),NSForegroundColorAttributeName,nil];
        
        UINavigationBarAppearance * appearance1 = [[UINavigationBarAppearance alloc] init];
        [appearance1 configureWithDefaultBackground];
        appearance1.backgroundColor = [UIColor clearColor];
        appearance1.backgroundEffect = nil;
        appearance1.shadowColor = nil;
        appearance1.titleTextAttributes = dict;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.scrollEdgeAppearance = nil;
        self.navigationController.navigationBar.standardAppearance = appearance1;
    }else{
        //设置导航栏透明
        [self.navigationController.navigationBar setTranslucent:NO];
        //把背景设为空
        UIImage *image = [UIImage GetImageWithColor:[UIColor clearColor] andHeight:44];
        
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        //处理导航栏有条线的问题
        [self.navigationController.navigationBar setShadowImage:image];
    }
}

- (void)setNavigationBarNotTranslucent {
    [self confitNav];
}

- (void)popToRootViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToHomeViewController {
    
    if (self.tabBarController.selectedIndex != 0) {
        self.tabBarController.selectedIndex = 0;
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (WKBaseViewController*)topViewController{
    WKBaseViewController * rootViewController = (WKBaseViewController *)UIApplication.sharedApplication.keyWindow.rootViewController;
    return [self topViewControllerWithRootViewController:rootViewController];
}

- (WKBaseViewController *)topViewControllerWithRootViewController:(WKBaseViewController *)rootViewController{
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabbar.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:(WKBaseViewController*)nav.visibleViewController];
    }
    WKBaseViewController * presentedViewController = (WKBaseViewController *)rootViewController.presentedViewController;
    if (presentedViewController != nil) {
        return [self topViewControllerWithRootViewController:presentedViewController];
    }
    return rootViewController;
}

- (void)popToViewControllerIndex:(NSInteger)index animate:(BOOL)animate {
    NSArray<WKBaseViewController*> *vcs = self.navigationController.childViewControllers;
    NSInteger cv_index = vcs.count - index -1;
    WKBaseViewController *vc = vcs[cv_index];
    [self.navigationController popToViewController:vc animated:animate];
}

- (void)popToSomeOneViewControllerWithControllerName:(NSString *)vcName animate:(BOOL)animate {
    
    NSArray<WKBaseViewController*> *all_vc = self.navigationController.childViewControllers;
    Class toVC = NSClassFromString(vcName);
    
    NSInteger index = -1;
    for (NSInteger i = 0; i < all_vc.count; i++) {
        WKBaseViewController *vc = all_vc[i];
        if ([vc isKindOfClass:toVC]) {
            index = i;
        }
    }
    
    if (index != -1) {
        WKBaseViewController *vc = all_vc[index];
        [self.navigationController popToViewController:vc animated:animate];
    }
}

- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)hideLeftItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationItem.leftBarButtonItem = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark --layz
-(UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
//        _containerView.backgroundColor = KHexColor(0x221E1E);
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIBarButtonItem *)backBarButtonItem{
    
    if (!_backBarButtonItem) {
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [[UIImage mm_xcassetImageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backToPrevious)];
    }
    return _backBarButtonItem;
}

- (UIButton *)popButton {
    if (!_popButton) {
        _popButton = [[UIButton alloc] init];
        [_popButton setImage:[UIImage mm_xcassetImageNamed:@"knav_back"] forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(backToPrevious) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popButton;
}

- (void)dealloc {
}

#pragma mark -- 处理统一事件，分发其他事件
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
//    if ([eventName isEqualToString:@"ReloadButtonClickActionEvent"]) { // 统一处理网络异常，点击重新请求
//        WPLog(@"*********************ViewModel再次请求*******************");
//        WPLog(@"************************************ViewModel==%@",userInfo[@"viewModel"]);
//        YPCBaseViewModel *vm = (YPCBaseViewModel*)userInfo[@"viewModel"];
//        [vm reloadData];
//    }else { // 其他的转发对应的子类去处理
        if ([self respondsToSelector:@selector(custom_routerEventWithName:userInfo:)]) {
            [self custom_routerEventWithName:eventName userInfo:userInfo];
        }
//    }
}
- (void)showProgressView:(void(^)(BOOL isDone))blcok {
    //指示器-loading
    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    progress.strokeColor = mainColor;
    [self.containerView addSubview:progress];
    [progress bringSubviewToFront:self.containerView];
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.containerView);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    [progress startProgressAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progress stopProgressAnimating];
        blcok(YES);
    });
    
}
- (void)setViewControllerTitleView:(NSString *)title {
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.font = KRelativeBoldFont(34);
    lblTitle.text = title;
    CGSize size = [title dn_getTextSize:KRelativeBoldFont(34) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
    lblTitle.textColor = [UIColor colorWithPatternImage:bgImg];
    self.navigationItem.titleView = lblTitle;
}

@end
