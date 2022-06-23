//
//  LKCommissonCardTableCell.h
//  cltios
//
//  Created by zjlk32 on 2021/8/26.
//

#import <UIKit/UIKit.h>
#import "LKCellInfoModel.h"
#import "LKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKCommissonCardTableCell : LKBaseTableViewCell

@property(nonatomic,strong)LKCellInfoModel  *cellInfoModel;

@property(nonatomic,strong)UIView    *contentV;

@property(nonatomic,strong)UILabel   *titleLab;

@property(nonatomic,strong)UITextField  *contenTextFiled;

@property(nonatomic,strong)UIView    *LineV;

@end

NS_ASSUME_NONNULL_END
