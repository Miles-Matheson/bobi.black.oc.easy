//
//  UIView+AddAction.m
//  YPCProject
//
//  Created by 汪鹏 on 2021/5/21.
//

#import "UIView+AddAction.h"

@implementation UIView (AddAction)

- (void)addTarget:(id)target selector:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

@end
