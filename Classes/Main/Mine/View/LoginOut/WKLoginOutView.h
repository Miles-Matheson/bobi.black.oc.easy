//
//  WKLoginOutView.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginOutBlock)(void);
@interface WKLoginOutView : WKBaseView
@property (nonatomic, copy) LoginOutBlock block;
- (instancetype)initWithLoginOut:(NSString *)title content:(NSString *)content;
- (void)showAnimation;

@end

NS_ASSUME_NONNULL_END
