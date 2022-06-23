//
//  NSArray+SafeIndex.h
//  cltios
//
//  Created by zjlk32 on 2021/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray(SafeIndex)
/**
 *  保证数组取值不会越界!
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
-(id)objcetSafeGetIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
