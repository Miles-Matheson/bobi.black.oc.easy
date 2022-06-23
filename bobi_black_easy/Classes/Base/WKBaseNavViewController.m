//
//  WKBaseNavViewController.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKBaseNavViewController.h"

@interface WKBaseNavViewController ()

@end

@implementation WKBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          KRelativeBoldFont(34),NSFontAttributeName,
                          KHexColor(0xFFFFFFF),NSForegroundColorAttributeName,nil];
    
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    [UINavigationBar appearance].titleTextAttributes = dict;
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count > 1) {
    self.topViewController.hidesBottomBarWhenPushed = NO;
    }

    NSArray<UIViewController *> *viewControllers = [super popToRootViewControllerAnimated:animated];
    return viewControllers;
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

/// 带导航栏的
- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* topVC = self.topViewController;
return [topVC preferredStatusBarStyle];

}


@end
