//
//  WsyHudProgressView.m
//  Woko
//
//  Created by 王树银 on 2022/5/25.
//

#import "WsyHudProgressView.h"

@implementation WsyHudProgressView

+(void)showToast:(NSString *)title withView:(UIView *)view animated:(BOOL)animated{
    WsyHudProgressView  *hud = [WsyHudProgressView showHUDAddedTo:view animated:animated];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud hideAnimated:true afterDelay:1];
//    return hud;
}
@end
