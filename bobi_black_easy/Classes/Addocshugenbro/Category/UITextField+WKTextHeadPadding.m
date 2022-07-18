//
//  UITextField+WKTextHeadPadding.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "UITextField+WKTextHeadPadding.h"

@implementation UITextField (WKTextHeadPadding)

- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {

    CGRect frame = textField.frame;

    frame.size.width = leftWidth;

    UIView *leftview = [[UIView alloc] initWithFrame:frame];

    textField.leftViewMode = UITextFieldViewModeAlways;

    textField.leftView = leftview;
}

@end
