//
//  UIImage+GradientColor.h
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {

GradientTypeTopToBottom = 0,//从上到下

GradientTypeLeftToRight = 1,//从左到右

GradientTypeUpleftToLowright = 2,//左上到右下

GradientTypeUprightToLowleft = 3,//右上到左下

};

@interface UIImage (GradientColor)
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;


@end

NS_ASSUME_NONNULL_END
