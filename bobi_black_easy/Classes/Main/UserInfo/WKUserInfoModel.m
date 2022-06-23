//
//  WKUserInfoModel.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKUserInfoModel.h"
#import <objc/runtime.h>

@implementation WKUserInfoModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
        if (self) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList([self class], &count);
            //
            for (int i = 0; i < count ; i ++) {
                Ivar ivar = ivars[i];
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
            }
            free(ivars);
        }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithArray:@[
            @{@"icon":@"http://99yjkj.com/woko1.png",@"name":@"Abbey",@"voice":@"http://99yjkj.com/woko1.mp3"},
            @{@"icon":@"http://99yjkj.com/woko2.png",@"name":@"Baile",@"voice":@"http://99yjkj.com/woko2.mp3"},
            @{@"icon":@"http://99yjkj.com/woko3.png",@"name":@"Calista",@"voice":@"http://99yjkj.com/woko3.mp3"},
            @{@"icon":@"http://99yjkj.com/woko4.png",@"name":@"Dahlia",@"voice":@"http://99yjkj.com/woko4.mp3"},
            @{@"icon":@"http://99yjkj.com/woko5.png",@"name":@"Naida",@"voice":@"http://99yjkj.com/woko5.mp3"},
            @{@"icon":@"http://99yjkj.com/woko6.png",@"name":@"Nalani",@"voice":@"http://99yjkj.com/woko6.mp3"},
            @{@"icon":@"http://99yjkj.com/woko7.png",@"name":@"Padraigin",@"voice":@"http://99yjkj.com/woko7.mp3"},
            @{@"icon":@"http://99yjkj.com/woko8.png",@"name":@"Raeleigh",@"voice":@"http://99yjkj.com/woko8.mp3"},
            @{@"icon":@"http://99yjkj.com/woko9.png",@"name":@"Tabatha",@"voice":@"http://99yjkj.com/woko9.mp3"},
            @{@"icon":@"http://99yjkj.com/woko10.png",@"name":@"Valeria",@"voice":@"http://99yjkj.com/woko10.mp3"},
            @{@"icon":@"http://99yjkj.com/woko11.png",@"name":@"Yvetta",@"voice":@"http://99yjkj.com/woko11.mp3"}
        ]];
    }
    return _dataArr;
}

// 这个需要返回YES
+ (BOOL)supportsSecureCoding{

    return YES;
}

@end
