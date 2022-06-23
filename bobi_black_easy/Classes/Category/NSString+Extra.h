//
//  NSString+Extra.h
//  CashierChoke
//
//  Created by zjs on 2019/9/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extra)

/**
 *  @brief  获取文本的大小
 *
 *  @param  font           文本字体
 *  @param  maxSize        文本区域的最大范围大小
 *  @param  linewdeakMode  字符截断类型
 *
 *  @return 文本大小
 */
- (CGSize)dn_getTextSize:(UIFont *)font
                 maxSize:(CGSize)maxSize
                    mode:(NSLineBreakMode)linewdeakMode;

/** 判断是否是有效的邮箱 */
- (BOOL)dn_isValidEmail;

@end

NS_ASSUME_NONNULL_END
