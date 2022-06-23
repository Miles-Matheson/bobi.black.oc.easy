//
//  UIButton+WKImageTitleSpace.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, WPButtonEdgeInsetsStyle) {
    WPButtonEdgeInsetsStyleTop, // image在上，label在下
    WPButtonEdgeInsetsStyleLeft, // image在左，label在右
    WPButtonEdgeInsetsStyleBottom, // image在下，label在上
    WPButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (WKImageTitleSpace)

/**
 * 设置button的titleLabel和imageView的布局样式，及间距
 *
 * @param style titleLabel和imageView的布局样式
 * @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(WPButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
