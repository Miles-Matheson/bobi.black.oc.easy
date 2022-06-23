//
//  WsyHudProgressView.h
//  Woko
//
//  Created by 王树银 on 2022/5/25.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface WsyHudProgressView : MBProgressHUD
+(void)showToast:(NSString *)title withView:(UIView *)view animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
