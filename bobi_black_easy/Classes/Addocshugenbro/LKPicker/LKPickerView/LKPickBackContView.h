//
//  LKPickBackContView.h
//  cltios
//
//  Created by zjlk32 on 2021/8/2.
//

#import <UIKit/UIKit.h>
#import "LKPickerProtocal.h"
NS_ASSUME_NONNULL_BEGIN

@interface LKPickHeadView : UIView

@property(nonatomic,strong)UIButton   *cancelBtn;

@property(nonatomic,strong)UIButton   *beSureBtn;

@property(nonatomic,strong)UILabel    *titleLab;

@end

typedef void(^pickerSelectBlock)(NSString  *, NSInteger);

@interface LKPickBackContView : UIView

@property(nonatomic,strong)LKPickHeadView  *headV;

@property(nonatomic,strong)UIPickerView   *pickView;

@property(nonatomic,strong)UITableView    *tableV;

@property(nonatomic,assign)LKPickerType   pickerType;

@property(nonatomic,strong)NSMutableArray<NSString *>*dataArray;

@property(nonatomic,copy)pickerSelectBlock   block;

-(void)lkpickerViewWithData:(NSMutableArray *)dataArr AndTheSelectedWithBlock:(void (^)(NSString *, NSInteger))block;
@end

NS_ASSUME_NONNULL_END
