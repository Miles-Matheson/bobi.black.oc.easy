//
//  UIColor+CHRegex.h
//  codehzx@163.com
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CHRegex)
+ (CAGradientLayer *)setGradualChangingColor:(CGRect)viewBounds fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr BeginWithTheStartPoint:(CGPoint)startPoint AndEndTheEndPoint:( CGPoint)endPoint;
+ (UIColor *)colorWithHex:(NSString *)hexColor  hexAlpha:(NSString *)hexAlpha;
//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;
//非法rgba颜色字符串解析 rgba(120，130，158，1)
+(instancetype)colorWithTheRGBAStr:(NSString *)rgbaStr;
@end
