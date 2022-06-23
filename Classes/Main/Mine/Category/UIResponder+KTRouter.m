//
//  UIResponder+KTRouter.m
//  zxkt
//
//  Created by wangpeng on 2020/9/23.
//  Copyright © 2020 iflytek. All rights reserved.
//

#import "UIResponder+KTRouter.h"

@implementation UIResponder (KTRouter)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
     [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

- (void)routerEventWithSel:(SEL)action userInfo:(NSDictionary *)userInfo {
     [[self nextResponder] routerEventWithSel:action userInfo:userInfo];
}
@end
