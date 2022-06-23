//
//  YPCSVProgress.m
//  YPCProject
//
//  Created by admin on 2021/5/13.
//

#import "YPCSVProgress.h"
#import "SVProgressAnimatedView.h"
#import "LZToastView.h"

@interface YPCSVProgress ()

@property (nonatomic,strong) UILabel *progressLabel;
@end

@implementation YPCSVProgress

- (UILabel*)statusLabel {
    if(!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _progressLabel.backgroundColor = [UIColor clearColor];
        _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _progressLabel.numberOfLines = 0;
    }
    if(!_progressLabel.superview) {
        UIView *hudView = [self valueForKeyPath:@"hudView.contentView"];
      [hudView addSubview:_progressLabel];
    }
    
    // Update styling
    _progressLabel.textColor = [UIColor whiteColor];
    _progressLabel.font = self.font;

    return _progressLabel;
}

+ (void)showSuccessMessageWithTitle:(NSString *)message finishBlock:(void (^)(void))block{
    if (message.length > 0 && message) {
        [self showInfoWithMessage:message];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
//        });
//        [self showSuccessWithStatus:message];
//        [self dismissWithDelay:3.0 completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}

+ (void)showErrorMessageWithTitle:(NSString *)message finishBlock:(void (^)(void))block {
    if (message.length > 0 && message) {
        [self showInfoWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
//        [self showErrorWithStatus:message];
//        [self dismissWithDelay:3.0 completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}

+ (void)showStatusMessageWithTitle:(NSString *)message finishBlock:(void (^)(void))block {
    if (message.length>0 && message) {
        [self showInfoWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
//        [SVProgressHUD showInfoWithStatus:message];
//        [self dismissWithDelay:3.0 completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}

+ (void)showSuccessMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block {
    if (message.length>0 && message) {
        [self showInfoWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
//        [SVProgressHUD showSuccessWithStatus:message];
//        [self dismissWithDelay:duration completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}
+ (void)showErrorMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block {
    if (message.length>0 && message) {
        [self showInfoWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
//        [self showErrorWithStatus:message];
//        [self dismissWithDelay:duration completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}
+ (void)showStatusMessageWithTitle:(NSString*)message withDuration:(CGFloat)duration finishBlock:(void(^)(void)) block {
    if (message.length>0 && message) {
        [self showInfoWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
//        [SVProgressHUD showInfoWithStatus:message];
//        [self dismissWithDelay:duration completion:^{
//            if (block) {
//                block();
//            }
//        }];
    }
}

+ (void)showInfoWithMessage:(NSString *)message {
    [LZToastView showWithView:[[[UIApplication sharedApplication] delegate] window] withText:message];
//    [self showImage:[UIImage mm_xcassetImageNamed:@""] status:message];
//    [self setDefaultStyle:SVProgressHUDStyleDark];
//    //设置HUD和文本的颜色
//    [self setForegroundColor:KHexColor(0xffffff)];
//    //设置HUD背景颜色
//    [self setBackgroundColor:KHexColorAlpha(0x000000, 0.7)];
//    //设置提示框的边角弯曲半径
//    [self setCornerRadius:3];
}


@end
