//
//  UIColor+CHRegex.m
//  SYQuMinApp
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 Shuyun. All rights reserved.
//

#import "UIColor+CHRegex.h"
#import "NSArray+SafeIndex.h"

@implementation UIColor (CHRegex)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(CGRect)viewBounds fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr BeginWithTheStartPoint:(CGPoint)startPoint AndEndTheEndPoint:( CGPoint)endPoint {
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = viewBounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHex:fromHexColorStr hexAlpha:@"1"].CGColor,(__bridge id)[UIColor colorWithHex:toHexColorStr hexAlpha:@"1"].CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint  = CGRectContainsPoint(CGRectMake(0, 0, 1, 1), startPoint) ? startPoint : CGPointMake(0, 0);
    gradientLayer.endPoint = CGRectContainsPoint(CGRectMake(0, 0, 1, 1), endPoint) ? endPoint : CGPointMake(1, 1);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    
    return gradientLayer;
}

//获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor  hexAlpha:(NSString *)hexAlpha{
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {
        return nil;
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexColor substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexColor length] == 8) {
        range.location = 4;
        NSString *as = [hexColor substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255 * [hexAlpha floatValue];
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}
+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color Alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    //判断前缀
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    //从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R G B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+(instancetype)colorWithTheRGBAStr:(NSString *)rgbaStr{
    //rgb(120,122,255,1);
    CGFloat r, g, b, a;
    BOOL     isRgb = [rgbaStr containsString:@"rgb"];
    if (isRgb) {
        NSString   *tempStr = rgbaStr;
        NSArray  *tempArr_1 = [tempStr componentsSeparatedByString:@"("];
        //去掉"("之前的数值
        NSString  *tempStr_1 = [tempArr_1 objcetSafeGetIndex:1];
        NSArray  *tempArr_2 = tempStr_1.length > 0 ? [tempStr_1 componentsSeparatedByString:@")"] : [NSArray array];
        NSString   *tempStr_2 = [tempArr_2 objcetSafeGetIndex:0];//120,122,255,1
        NSArray  *tempArr_3 = tempStr_2.length > 0 ? [tempStr_2 componentsSeparatedByString:@","] : [NSArray array];
        if (tempArr_3.count == 4) {
            r = [[tempArr_3 objcetSafeGetIndex:0] floatValue];
            g = [[tempArr_3 objcetSafeGetIndex:1] floatValue];
            b = [[tempArr_3 objcetSafeGetIndex:2] floatValue];
            a = [[tempArr_3 objcetSafeGetIndex:3] floatValue];
            if ([self chargeTheFloatBeAviableWithfloat:r AndThelowNum:0.0 AndTheMaxNum:255.0f] && [self chargeTheFloatBeAviableWithfloat:g AndThelowNum:0.0 AndTheMaxNum:255.0f] && [self chargeTheFloatBeAviableWithfloat:b AndThelowNum:0.0 AndTheMaxNum:255.0f] && [self chargeTheFloatBeAviableWithfloat:a AndThelowNum:0.0 AndTheMaxNum:1.0]) {
                r = r > 1 ? r/255.0f : r;
                g = g > 1 ? g/255.0f : g;
                b = b > 1 ? b/255.0f : b;
            }else{
                return nil;
            }
            return [UIColor colorWithRed:r green:g blue:b alpha:a];
        }else{
            return nil;
        }
    }else{
        return  [self colorWithHexString:rgbaStr];
    }
}

+(BOOL)chargeTheFloatBeAviableWithfloat:(CGFloat)num AndThelowNum:(CGFloat)minNum AndTheMaxNum:(CGFloat)maxNum{
    BOOL beaViable = false;
    if (num >= minNum && num <= maxNum) {
        beaViable = true;
    }
    return beaViable;
}


@end
