//
//  LKCellInfoModel.h
//  cltios
//
//  Created by zjlk32 on 2021/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSInteger {
    CellType_Normal,
    cellType_enter,
    cellType_select,
    CellType_shosePic,//选择图片
    CellType_enterMore,//多行输入
    CellType_status,
    CellType_rightimgV,
}CellType;


@interface LKCellInfoModel : NSObject
@property(nonatomic,assign)int     ID;
@property(nonatomic,copy)NSString  *titleStr;
@property(nonatomic,strong)NSString  *contentStr;
@property(nonatomic,copy)NSString  *placeStr;
@property(nonatomic,assign)CellType cellType;

@property(nonatomic,assign) NSInteger status; //公开 保密
@property(nonatomic,copy)   NSArray * imgArr; //图片集合
@property(nonatomic,assign) BOOL  isEditing; //是否可编辑
-(instancetype)initWithTheTittle:(NSString *)title ContentStr:(NSString *)contentStr AndTheType:(CellType)cellType;

-(instancetype)initWithTheTittle:(NSString *)title ContentStr:(NSString *)contentStr AndThePlaceStr:(NSString *)placeStr AndTheType:(CellType)cellType;
@end

NS_ASSUME_NONNULL_END
