//
//  WKBaseView.h
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKBaseView : UIView

@property (nonatomic, strong) UIView * containerView;

- (void)createUI;
- (void)createLayout;

@end

NS_ASSUME_NONNULL_END
