/******************************************************************************
 *
 *  腾讯云通讯服务界面组件 TUIKIT - 黑名单界面组件
 *  本文件声明用于实现黑名单页面的组件。
 *  黑名单页面用于统一显示用户黑名单中的组件。
 *
 ******************************************************************************/
#import <UIKit/UIKit.h>
#import "TUIBlackListViewModel.h"
#import "TTextEditController.h"
#import "TUIAvatarViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 【模块名称】黑名单界面（TUIBlackListController）
 * 【功能说明】负责拉取用户的黑名单信息，并在页面中显示。
 *  界面（Controller）提供了黑名单的展示功能，同时也实现了对用户交互动作的响应。
 *  用户也可点击黑名单中的某位用户，将其移出黑名单或对其发送消息。
 */
@interface TUIBlackListController : UITableViewController

/**
 *  黑名单界面的视图模型。
 *  负责黑名单数据的拉取、加载等操作。
 */
@property TUIBlackListViewModel *viewModel;

@end

@interface EditAboutCell : UITableViewCell
@property (nonatomic,strong) UIView *spView;
@property (nonatomic,strong) UIImageView *statusImg;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@interface EditPhotosCCell : UICollectionViewCell{
    NSString *_pre;
}
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *shadeView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIImageView *statusImg;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) NSDictionary *dic;
@end


@interface EditPhotoShowCell :UICollectionViewCell

@property (nonatomic,strong) id valueObj;

@end


@interface EditMyPickerView :UIView

+ (void)showWithData:(NSArray *)arr flag:(NSInteger)flag tipText:(NSString *)tip block:(void(^)(NSArray *arr))block;

@end

@interface EditMyPickerSingleCell : UITableViewCell

@property (nonatomic,strong) NSString *text;

@property (nonatomic,assign) BOOL selectTag;

@end


@interface EditAboutView :UIView

@property (nonatomic,strong) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,copy) void (^sectionClickedBlock) (NSInteger index,NSString *text,BOOL isPlace);

//更新红色数字
@property (nonatomic,copy) void (^updateRedNumber)(NSInteger count);
- (void)getRedNumber;

- (void)refreshData;

@end

@interface EditPhotosView : UIView

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *photoList;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,copy) void (^addPhotoClickedBlock) (void);
@property (nonatomic,copy) void (^previewPhotoClickedBlock) (NSInteger index,NSArray *list);

//更新红色数字
@property (nonatomic,copy) void (^updateRedNumber)(NSInteger count);
- (void)update;

@end

@interface EditDetailsView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,copy) void (^itemSelectClickedBlock) (NSInteger index);

//更新红色数字
@property (nonatomic,copy) void (^updateRedNumber)(NSInteger count);

- (void)getRedNum;

@end


@interface NeighborsSimpleCuteBase2Controller : UIViewController

-(float)NeighborsSimpleCuteProjectGetLabelHeightWithText:(NSString *)text width:(float)width font: (float)font;

- (void)NeighborsSimpleCuteSetLeftButton:(UIImage *)leftImg;

- (void)NeighborsSimpleCuteSetRightButton:(UIImage *)rightImg;

- (void)onNeighborsSimpleCuteLeftBackBtn:(UIButton *)btn;

- (void)onNeighborsSimpleCuteRightBackBtn:(UIButton *)btn;

-(NSMutableString *)getRandWithLetters;

@end

@interface EditInputController :NeighborsSimpleCuteBase2Controller

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) BOOL isPalceholder;
@property (nonatomic,copy) void (^saveBlock) (void);

@end

@interface EditPhotoShowController:NeighborsSimpleCuteBase2Controller
@property (nonatomic,strong) NSString *titleStr;//传入标题

@property (nonatomic,assign) NSInteger index;//传入图片下标

@property (nonatomic,strong) NSMutableArray *photos;

@property (nonatomic,copy) void (^photoDeleteBlock) (NSInteger index);

@end

@interface DeleteView : UIView

+ (void)showWithBlock:(void (^) (void))block;

@end

typedef NS_ENUM(NSInteger, UIMyDefindButtonImageType) {
    
    UIMyDefindButtonImageTypeNormal,//左图片 右文字 内容居中
    
    UIMyDefindButtonImageTypeNormalLeft,//左图片 右文字  内容靠左
    
    UIMyDefindButtonImageTypeNormalRight,//左图片 右文字  内容靠右
    
    UIMyDefindButtonImageTypeRight,//右图片 左文字 内容居中
    
    UIMyDefindButtonImageTypeRightLeft,//右图片  左文字  内容靠左
    
    UIMyDefindButtonImageTypeRightRight,//右图片 左文字 内容靠右
    
    UIMyDefindButtonImageTypeRightCenter,//右图片  左文字  只文字居中
    
    UIMyDefindButtonImageTypeTop,//上图片 下文字
    
    UIMyDefindButtonImageTypeBottom,//下图片 上文字
    
    
};
@interface MyDefindButton : UIButton

@property (nonatomic,assign) CGFloat insertPadding;

@property (nonatomic,assign) UIMyDefindButtonImageType myDefindType;

@end

@interface UITextField (ToolKit)

//左间距
@property (nonatomic,assign) CGFloat leftPadding;

//右间距
@property (nonatomic,assign) CGFloat rightPadding;

- (void)setTextFieldPlaceHolder:(NSString *)placeholder holderColor:(UIColor *)color;

@end



@interface NeighborsSimpleCuteSettingBaseProfileController:NeighborsSimpleCuteBase2Controller

@end

@interface NeighborsSimpleCuteSettingMineController : NeighborsSimpleCuteBase2Controller

@end



NS_ASSUME_NONNULL_END
