//
//  WKBaseViewController.h
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WKBaseViewController : UIViewController

@property (nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIButton *popButton;

/// 标记页面来源
@property(nonatomic, strong) NSString *fromFlag;

- (void)createUI;

- (void)createLayout;

// 设置导航栏标题的颜色
- (void)configNaviTitleColor:(UIColor*)color;

/// 返回按钮箭头点击事件
- (void)backToPrevious;

/// 隐藏导航栏
- (void)hideNavigationBarWithAnimated:(BOOL)animated;
- (void)showNavigationBar;
- (void)hideLeftItem;

- (void)popToRootViewController;
- (void)popViewController;
// 返回到Home主页
- (void)popToHomeViewController;
// pop到指定控制器
- (void)popToViewControllerIndex:(NSInteger)index animate:(BOOL)animate;
// pop到指定控制器
- (void)popToSomeOneViewControllerWithControllerName:(NSString*)vcName animate:(BOOL)animate;
// 设置导航透明
- (void)setNavigationBarTranslucent;
// 设置导航不透明
- (void)setNavigationBarNotTranslucent;
// 获取顶部控制器
- (WKBaseViewController*)topViewController;
/// 跳转扫码页面
- (void)common_pushToScanViewController;
/// 处理事件
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
///
- (void)showProgressView:(void(^)(BOOL isDone))blcok;
///
- (void)setViewControllerTitleView:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
