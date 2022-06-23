//
//  WKInforView.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKInforView : WKBaseView
- (void)configHeadTile:(NSString *)title andValue:(NSString *)value;
- (void)changeUserInforSex:(NSString *)sex;
- (void)changeUserInforAge:(NSString *)age;

@end

NS_ASSUME_NONNULL_END
