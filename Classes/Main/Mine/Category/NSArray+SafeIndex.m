//
//  NSArray+SafeIndex.m
//  cltios
//
//  Created by zjlk32 on 2021/4/1.
//

#import "NSArray+SafeIndex.h"

@implementation NSArray(SafeIndex)

-(id)objcetSafeGetIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    } else {
        return  nil;
    }
}
@end
