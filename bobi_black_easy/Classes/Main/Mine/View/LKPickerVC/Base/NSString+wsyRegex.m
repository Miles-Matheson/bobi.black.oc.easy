//
//  NSString+wsyRegex.m
//  VoiceProject
//
//  Created by 王树银 on 2022/4/14.
//

#import "NSString+wsyRegex.h"

@implementation NSString (wsyRegex)

/** 判断是否是空字符串 */
+ (BOOL) isBlankString:(NSString *)str
{
    if ([str isEqual:@"NULL"] || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqual:NULL] || [[str class] isSubclassOfClass:[NSNull class]] || str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"nil"]  || [str isEqualToString:@""] || str.length == 0 || !str) {
        return YES;
    }else{
        return NO;
    }
}

@end
