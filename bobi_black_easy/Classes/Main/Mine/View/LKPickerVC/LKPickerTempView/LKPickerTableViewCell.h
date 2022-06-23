//
//  LKPickerTableViewCell.h
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import <UIKit/UIKit.h>
#import "LKBaseTableViewCell.h"
//#import "LKChangeAcountModel.h"
NS_ASSUME_NONNULL_BEGIN
//@class LKNormalAcountModel;
@interface LKPickerTableViewCell : LKBaseTableViewCell

@property(nonatomic,strong)UIImageView   *iconImgV;
@property(nonatomic,strong)UILabel      *titleLab;
@property(nonatomic,strong)UILabel      *accessLab;
@property(nonatomic,strong)UIButton     *selectBtn;
@property(nonatomic,strong)NSArray      *nameArr;
@property(nonatomic,strong)NSArray      *picNameArr;
//@property(nonatomic,strong)LKChangeAcountModel  *acountModel;
//@property(nonatomic,strong)NSMutableArray  <LKNormalAcountModel*>*normalDataArr;

@end

NS_ASSUME_NONNULL_END
