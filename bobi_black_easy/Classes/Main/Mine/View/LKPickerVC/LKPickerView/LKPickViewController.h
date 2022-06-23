//
//  LKPickViewController.h
//  cltios
//
//  Created by zjlk32 on 2021/8/2.
//

#import <UIKit/UIKit.h>
#import "LKPickerProtocal.h"
#import "LKPickBackContView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LKPickViewController : UIViewController

@property(nonatomic,assign)CGFloat   pickHeight;

//@property(nonatomic,assign)id<LKPickerDelegate>delegate;

//@property(nonatomic,assign)id<LKPickerDataSource>dataSource;

@property(nonatomic,strong)LKPickBackContView  *pickerView;

-(void)lkPickerViewWithDataArr:(NSArray *)dataArray SelectWithBlock:(void(^)(NSString  *title, NSInteger index))block;


-(void)dissmissTheCotnentView;
@end

NS_ASSUME_NONNULL_END
