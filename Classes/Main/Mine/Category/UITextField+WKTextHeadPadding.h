//
//  UITextField+WKTextHeadPadding.h
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (WKTextHeadPadding)
- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;

@end

NS_ASSUME_NONNULL_END
