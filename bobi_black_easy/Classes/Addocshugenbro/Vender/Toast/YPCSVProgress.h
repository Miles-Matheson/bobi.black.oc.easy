//
//  YPCSVProgress.h
//  YPCProject
//
//  Created by admin on 2021/5/13.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface YPCSVProgress : SVProgressHUD

+ (void)showSuccessMessageWithTitle:(NSString*)message finishBlock:(void(^)(void)) block;
+ (void)showErrorMessageWithTitle:(NSString*)message finishBlock:(void(^)(void)) block;
+ (void)showStatusMessageWithTitle:(NSString*)message finishBlock:(void(^)(void)) block;

+ (void)showSuccessMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block;
+ (void)showErrorMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block;
+ (void)showStatusMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block;


@end

