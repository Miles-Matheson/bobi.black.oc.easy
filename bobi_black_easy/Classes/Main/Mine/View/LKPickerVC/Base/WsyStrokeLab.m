//
//  wsyStrokeLab.m
//  VoiceProject
//
//  Created by 王树银 on 2022/4/12.
//

#import "WsyStrokeLab.h"
#import "UIColor+CHRegex.h"

@implementation WsyStrokeLab

- (void)drawRect:(CGRect)rect {
    CGSize textSize = [self.text boundingRectWithSize:rect.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    CGFloat text_width = textSize.width;
    CGFloat text_height = textSize.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 获取文字mask
    [self.text drawInRect:self.bounds withAttributes:@{NSFontAttributeName : self.font}];
    CGImageRef textMask = CGBitmapContextCreateImage(context);
    // 清空画布
    CGContextClearRect(context, rect);
    // 添加描边
    CGSize shadowOffset = self.shadowOffset;
    CGContextSetLineWidth(context, self.outLineWidth);//字体边缘的宽度
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    self.textColor = [UIColor blackColor];//字体边缘加的颜色
    [super drawTextInRect:rect];
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = self.outLinetextColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    self.shadowOffset = shadowOffset;
    // 设置蒙层
    CGContextTranslateCTM(context, (rect.size.width-text_width)/2.0, self.bounds.size.height + self.bounds.size.height/2 - text_height/2);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, textMask);
    // 绘制渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0,0.9,0.9,1};
    CGFloat colors[] = {
        1.0,125/255.0,58/255.0,1.0,
        253/255.0,202/255.0,56/255.0,1.0
    };
//    CGFloat colors[] = {[UIColor colorWithHexString:@"#FDCA38"],[UIColor colorWithHexString:@"#FF7D3A"]};
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, colors, locations, 4);
    CGPoint start = CGPointMake(0, self.bounds.size.height - text_height);
    CGPoint end = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    // 释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end
