//
//  LKCellInfoModel.m
//  cltios
//
//  Created by zjlk32 on 2021/4/15.
//

#import "LKCellInfoModel.h"

@implementation LKCellInfoModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return  self;
}

-(instancetype)initWithTheTittle:(NSString *)title ContentStr:(NSString *)contentStr AndTheType:(CellType)cellType{
    self = [super init];
    if (self) {
        _titleStr = title;
        _contentStr = contentStr;
        _cellType = cellType;
    }
    return  self;
}

-(instancetype)initWithTheTittle:(NSString *)title ContentStr:(NSString *)contentStr AndThePlaceStr:(NSString *)placeStr AndTheType:(CellType)cellType{
    self = [super init];
    if (self) {
        _titleStr = title;
        _contentStr = contentStr;
        _placeStr = placeStr;
        _cellType = cellType;
    }
    return self;
}




@end
