//
//  UIResponder+KTRouter.h
//  zxkt
//
//  Created by wangpeng on 2020/9/23.
//  Copyright © 2020 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (KTRouter)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
- (void)routerEventWithSel:(SEL)action userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
