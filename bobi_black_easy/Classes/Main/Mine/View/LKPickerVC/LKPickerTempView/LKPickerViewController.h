//
//  LKPickerViewController.h
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import <UIKit/UIKit.h>
#import "LKPickerProtocol.h"
#import "LKPickerBackView.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger{
    LKWSYPickerContentAnmation_none,//无动画
    LKWSYPickerContentAnmationType_botomToCenter,//平移，从下往上
    LKWSYPickerContentAnmationType_smallToBig,//从小到大的,
    
}LKWSYPickerContentAnmationType;

@interface LKPickerViewController : UIViewController

@property(nonatomic,weak)id<LKWSYPickerDelegate>delegate;

@property(nonatomic,weak)id<LKWSYPickerDataSource>dataSource;

@property(nonatomic,assign)LKWSYPickerContentAnmationType   ContentAnmationType;

@property(nonatomic,strong)LKPickerBackView  *pickerView;


-(instancetype)initWithContentAnmationType:(LKWSYPickerContentAnmationType)anmationType;

-(void)lkPickerViewWithDataArr:(NSArray *)dataArray SelectWithBlock:(void(^)(NSString  *title, NSInteger index))block;

-(void)dissmissTheCotnentView;
@end

NS_ASSUME_NONNULL_END
