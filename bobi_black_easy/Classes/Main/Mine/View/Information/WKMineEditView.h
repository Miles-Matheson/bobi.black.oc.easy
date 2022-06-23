//
//  WKMineEditView.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBaseView.h"
#import "WKBottomView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WKMineEditView : WKBaseView
@property (nonatomic, strong) WKBottomView *bottomView;
- (void)changeUserAvatar:(UIImage *)image;
- (void)changeUserInforSex:(NSString *)sex;
- (void)changeUserInforAge:(NSString *)age;

@end

NS_ASSUME_NONNULL_END
