//
//  LKPickerBackView.h
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import <UIKit/UIKit.h>
//#import "LKPickBackContView.h"
#import "LKPickerProtocol.h"


NS_ASSUME_NONNULL_BEGIN
typedef void(^pickerSelectBlock)(NSString  *, NSInteger);

@interface LKPickerBackView : UIView

@property(nonatomic,strong)UIView  *headV;

@property(nonatomic,assign)LKWSYPickerType  type;

@property(nonatomic,assign)LKWSYPickerStyleType  style;


@property(nonatomic,weak)id<LKWSYPickerDelegate>delegate;

@property(nonatomic,weak)id<LKWSYPickerDataSource>dataSource;

@property(nonatomic,strong)UITableView    *tableV;

@property(nonatomic,strong)UIPickerView   *pickerV;

@property(nonatomic,strong)NSMutableArray<NSString *>*dataArray;

@property(nonatomic,copy)pickerSelectBlock   block;

-(void)lkpickerViewWithData:(NSMutableArray *)dataArr AndTheSelectedWithBlock:(void (^)(NSString *, NSInteger))block;


@end

NS_ASSUME_NONNULL_END
