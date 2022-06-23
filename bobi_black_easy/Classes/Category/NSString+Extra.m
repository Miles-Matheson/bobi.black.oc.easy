//
//  NSString+Extra.m
//  CashierChoke
//
//  Created by zjs on 2019/9/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)


#pragma mark -- 获取文本字体大小
- (CGSize)dn_getTextSize:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)linewdeakMode {
    NSMutableDictionary * attributeDict = [[NSMutableDictionary alloc]init];
    
    attributeDict[NSFontAttributeName] = font;
    if (linewdeakMode != NSLineBreakByWordWrapping) {
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = linewdeakMode;
        attributeDict[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    // 计算文本的 rect
    CGRect rect = [self boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributeDict
                                     context:nil];
    
    return rect.size;
}

/** 判断是否是有效的邮箱 */
- (BOOL)dn_isValidEmail {//
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    return [self dn_isValidateByRegex:regex];
}

#pragma mark - 匹配正则表达式的一些简单封装
- (BOOL)dn_isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

@end
