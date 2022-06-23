//
//  UIView+AddAction.h
//  YPCProject
//
//  Created by 汪鹏 on 2021/5/21.
//

#import <UIKit/UIKit.h>

@interface UIView (AddAction)


/// t添加事件
/// @param target 消息接收者
/// @param selector 消息名称
- (void)addTarget:(id)target selector:(SEL)selector;
@end

