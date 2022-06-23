//
//  LKPickerProtocal.h
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LKPicker_Normal,
    LKPicker_tableV,
    LKPicker_PassWord,
} LKPickerType;

//@protocol LKPickerDelegate <NSObject>
//
//-(LKPickerType)lkPickerType;
//
//@optional
//
//-(Class)customCellWithTheTableV:(UITableView *)tableView;
//
//-(NSArray *)lkNumberOfRowsInLKPickerView:(UITableView *)tableView;
//
//-(CGFloat)lkPickerCellHeightWithTableView:(UITableView *)tableView;
//
//-(void)lkPickerSelectItem:(NSInteger)row WithTableView:(UITableView *)tableView;
//
//@end
//
//@protocol LKPickerDataSource <NSObject>
//
//
//
//@end


@interface LKPickerProtocal : NSObject

@end

NS_ASSUME_NONNULL_END
