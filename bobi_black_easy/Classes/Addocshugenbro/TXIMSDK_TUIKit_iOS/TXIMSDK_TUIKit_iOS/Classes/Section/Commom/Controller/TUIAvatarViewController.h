#import <UIKit/UIKit.h>
#import "TCommonAvatarCell.h"
#import "TUIProfileCardCell.h"
#import "TTextEditController.h"
#import <AVFoundation/AVFoundation.h>
#import "ImSDK_Plus/ImSDK_Plus.h"
#import <TXIMSDK_TUIKit_iOS-umbrella.h>

/**
 *  头像大图的显示界面
 *  本类的整体逻辑与图片消息的大图显示界面类似。
 */
@interface TUIAvatarViewController : UIViewController

@property (nonatomic, strong) TUIProfileCardCellData *avatarData;

@end

@interface NeighborsSimpleCuteBaseController: UIViewController

@property (nonatomic, strong) UILabel *msgLab;

@property (nonatomic, assign) BOOL showMsgLab;

- (void)setNumberNum:(long)msgNum;

-(float)NeighborsSimpleCuteProjectGetLabelHeightWithText:(NSString *)text width:(float)width font: (float)font;

- (void)NeighborsSimpleCuteSetLeftButton:(UIImage *)leftImg;

- (void)NeighborsSimpleCuteSetRightButton:(UIImage *)rightImg;

- (void)onNeighborsSimpleCuteLeftBackBtn:(UIButton *)btn;

- (void)onNeighborsSimpleCuteRightBackBtn:(UIButton *)btn;

-(NSMutableString *)getRandWithLetters;

@end
typedef enum{
    WKWebLoadTypeNotSpecifiy = 0,
    WKWebLoadTypeWebURLString,
    WKWebLoadTypeAuthorizationWebURLString,
    WKWebLoadTypeWebHTMLString,
    WKWebLoadTypeHTMLString,
    WKWebLoadTypePOSTWebURLString,
}WKWebLoadType;
@interface NeighborsSimpleCuteBaseWebController :NeighborsSimpleCuteBaseController
@property (nonatomic,assign)BOOL isShowHidden;
@property (nonatomic,copy)NSString *webTitle;
@property (nonatomic,assign)WKWebLoadType loadType;
@property (nonatomic,copy)NSString *URLString;
@property (copy, nonatomic) void(^webViewCalculateHeightBlock)(CGFloat height);
@property (copy, nonatomic) void(^webViewContentSizeDidChangeBlock)(CGSize size);
@end

@interface NeighborsSimpleCuteLaunchMainController : UIViewController

@end


@interface NeighborsSimpleCuteRootMainController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteUserLoginController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteUserRegsterController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteUserForgePwdController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteUserWelcomeController : NeighborsSimpleCuteBaseController
@property (nonatomic,copy)NSString *updateToken;
@property (nonatomic,copy)NSString *emailStr;
@property (nonatomic,copy)NSString *pwdStr;
@end

@interface NeighborsSimpleCuteWelcomeUseInfoController: NeighborsSimpleCuteBaseController
@property (nonatomic,copy)NSString *emailStr;
@property (nonatomic,copy)NSString *pwdStr;
@end

@interface NeighborsSimpleCuteHomeRootController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteHomeVoiceController : NeighborsSimpleCuteBaseController

@end


@interface NeighborsSimpleCuteHomeMainController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteVoiceListController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteReportController : NeighborsSimpleCuteBaseController
@property (nonatomic,copy)void(^NeighborsSimpleCuteReportControllerReportBlock)(void);

@end

@interface NeighborsSimpleCuteSendMessageController : NeighborsSimpleCuteBaseController
@property (nonatomic,copy)void(^NeighborsSimpleCuteReportControllerMessageBlock)(void);

@end

@interface NeighborsSimpleCuteVoiceContentViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIImageView *bgImg;

@property (nonatomic,strong)UIView *showView;

@property (nonatomic,strong)UIImageView *showImg;

@end


@interface NeighborsSimpleCuteExploreContentViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIButton *callBtn;

@property (nonatomic,strong)UIImageView *bgImg;

@property (nonatomic,strong)UIView *showView;

@property (nonatomic,strong)UIImageView *showImg;

@property (nonatomic,copy)void(^NeighborsSimpleCuteExploreContentViewCellCallBlock)(void);

@end

@interface NeighborsSimpleCuteVoiceShowView : UIView

@end


@interface NeighborsSimpleCuteHomeVoiceUserInfoModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr14th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@end

@interface NeighborsSimpleCuteExploreListBottleModel :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * videoUrl;
@property (nonatomic , copy) NSString              * audioUrl;
@property (nonatomic , assign) NSInteger              racyStatus;
@property (nonatomic , assign) NSInteger              decentStatus;
@property (nonatomic , assign) NSInteger              recommendStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , assign) NSInteger              reviewStatus;
@property (nonatomic , assign) NSInteger              upvoteNum;
@property (nonatomic , assign) NSInteger              commentNum;
@property (nonatomic , assign) NSInteger              upvoteNewNum;
@property (nonatomic , assign) NSInteger              commentNewNum;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * content;
@end

@interface NeighborsSimpleCuteExploreListUserModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr14th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@end


@interface NeighborsSimpleCuteExploreListModel : NSObject

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              bottleId;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , assign) NSInteger              upvoteStatus;
@property (nonatomic , assign) NSInteger              newFlag;
@property (nonatomic , assign) NSInteger              openTime;
@property (nonatomic , strong) NeighborsSimpleCuteExploreListBottleModel            * bottle;
@property (nonatomic , strong) NeighborsSimpleCuteExploreListUserModel              * userInfo;

@end



@interface NeighborsSimpleCuteHomeVoiceModel : NSObject

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , copy) NSString              * videoUrl;
@property (nonatomic , copy) NSString              * audioUrl;
@property (nonatomic , assign) NSInteger              racyStatus;
@property (nonatomic , assign) NSInteger              decentStatus;
@property (nonatomic , assign) NSInteger              recommendStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , assign) NSInteger              reviewStatus;
@property (nonatomic , assign) NSInteger              upvoteNum;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , assign) NSInteger              delFlag;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , strong) NeighborsSimpleCuteHomeVoiceUserInfoModel            * userInfo;



//@property (nonatomic,assign)int index;
//
//@property (nonatomic,copy)NSString *nameStr;
//
//@property (nonatomic,copy)NSString *avtorStr;
//
//@property (nonatomic,copy)NSString *urlStr;

@end

@interface NeighborsSimpleCuteVoicePlayView : UIView
@property (nonatomic,strong)NeighborsSimpleCuteExploreListModel *exporeModel;
@property (nonatomic,strong) NeighborsSimpleCuteHomeVoiceModel *voiceModel;
@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewCallBlock)(void);
@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewChatBlock)(void);
@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewReportBlock)(void);
@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewDelBlock)(void);
@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewCloseBlock)(void);
@end

@interface NeighborsSimpleCuteVideoCallView :UIView
@property (nonatomic,strong) NeighborsSimpleCuteHomeVoiceModel *voiceModel;
@end

//@interface NeighborsSimpleCuteSubPlayVideoView :UIView
//@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewReportBlock)(void);
//@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewDelBlock)(void);
//@property (nonatomic,copy)void(^NeighborsSimpleCuteVoicePlayViewBlockBlock)(void);
//@end

//聊天界面的model
@interface SocializeIntercourseMessageModel : NSObject
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)NSString *storeNameStr;
@property (nonatomic,copy)NSString *sendIconStr;
@property (nonatomic,copy)NSString *sendTimeStr;
@property (nonatomic,copy)NSString *sendType; // 0 代表文字 1代表图片
@property (nonatomic,copy)NSString *sendContentStr;
@property (nonatomic,copy)NSData *sendPicture;
@end


//聊天界面的model
@interface SocializeIntercourseMessageOtherModel :NSObject
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)NSString *storeNameStr;
@property (nonatomic,copy)NSString *storeIconStr;
@property (nonatomic,copy)NSString *storeTimeStr;
@property (nonatomic,copy)NSString *storeLastStr;
@end


// 本地数据库的内容
@interface NeighborsSimpleCuteDBTool : NSObject

+ (instancetype)NeighborsSimpleCuteProjectSharaDBTool;
- (void)NeighborsSimpleCuteProjectCreateDataBase;

-(void)insertNeighborsSimpleCuteProjectPlanModel:(NeighborsSimpleCuteHomeVoiceModel *)voicemodel;
- (NSMutableArray *)queryAllNeighborsSimpleCuteProjectVoice;
-(void)deleteNeighborsSimpleCuteProjectVoiceModel:(NeighborsSimpleCuteHomeVoiceModel *)voicemodel;
//聊天界面需要的
-(void)insertMessageModel:(SocializeIntercourseMessageModel *)messageModel;
-(void)deleteMessageModel:(SocializeIntercourseMessageModel *)messageModel;
- (NSMutableArray *)queryAllMessageModel;

-(void)insertMessageStoreModel:(SocializeIntercourseMessageOtherModel *)messageStoreModel;
-(void)updateMessageStoreModel:(SocializeIntercourseMessageOtherModel *)messageStoreModel;
-(void)deleteMessageStoreModel:(SocializeIntercourseMessageOtherModel *)messageStoreModel;
-(BOOL)isExistMessageStoreModel:(NSString *)storeNameStr;
- (NSMutableArray *)queryAllMessageStoreModel;


@end

@interface LZPlayerManager : NSObject

/*存放歌曲数组*/
@property (nonatomic, strong) NSMutableArray *musicArray;
/*播放下标*/
@property (nonatomic, assign) NSInteger index;
/*是不是正在播放*/
@property (nonatomic, assign) BOOL isPlay;
/*播放器*/
@property (nonatomic, strong) AVPlayer *player;
/*标记是不是没点列表直接点了播放按钮如果是就默认播放按钮*/
@property (nonatomic, assign) BOOL isFristPlayerPauseBtn;
/*开始播放*/
@property (nonatomic,copy)void(^isStartPlayer)(NSInteger index);//0是开始 1 暂停
/*播放工具单利*/
+(instancetype)lzPlayerManager;
/*播放和暂停*/
- (void)playAndPause;
/*前一首*/
- (void)playPrevious;
/*后一首*/
- (void)playNext;
/*当前播放项*/
- (void)replaceItemWithUrlString:(NSString *)urlString;
/*声音*/
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
/*进度条*/
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;

@end

@interface NeighborsSimpleCuteResposeModel : NSObject

@property(nonatomic, assign)NSInteger code;
@property(nonatomic, copy)NSString *msg;
@property(nonatomic, strong)id data;
@property(nonatomic, copy)NSString *token;

@end

@interface NeighborsSimpleCuteNetworkTool : NSObject

+ (instancetype)sharedNetworkTool;
-(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * error))failure;
-(void)GET2:(NSString *)URLString parameters:(id)parameters success:(void (^)(NeighborsSimpleCuteResposeModel *response))success failure:(void (^)(NSError * error))failure;
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NeighborsSimpleCuteResposeModel *response))success failure:(void (^)(NSError * error))failure;
-(void)POST2:(NSString *)URLString parameters:(id)parameters success:(void (^)(NeighborsSimpleCuteResposeModel *response))success failure:(void (^)(NSError * error))failure;
-(void)POST3:(NSString *)URLString parameters:(id)parameters success:(void (^)(NeighborsSimpleCuteResposeModel *response))success failure:(void (^)(NSError * error))failure;

@end


@interface NeighborsSimpleClinentInfo : NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * clientNum;
@property (nonatomic , copy) NSString              * description;
@property (nonatomic , assign) NSInteger              auditingState;
@property (nonatomic , assign) NSInteger              updateFlag;
@property (nonatomic , copy) NSString              * updateUrl;
@property (nonatomic , copy) NSString              * updateDescription;
@property (nonatomic , assign) NSInteger              delFlag;
@property (nonatomic , copy) NSString              * spare1st;
@property (nonatomic , copy) NSString              * spare2nd;
@property (nonatomic , copy) NSString              * spare3rd;
@property (nonatomic , copy) NSString              * spare4th;
@property (nonatomic , copy) NSString              * spare5th;
@property (nonatomic , copy) NSString              * spare6th;
@property (nonatomic , copy) NSString              * spare7th;
@property (nonatomic , copy) NSString              * spare8th;
@property (nonatomic , copy) NSString              * spare9th;
@property (nonatomic , copy) NSString              * spare10th;
@property (nonatomic , copy) NSString              * spare11th;
@property (nonatomic , copy) NSString              * spare12th;
@property (nonatomic , copy) NSString              * spare13th;
@property (nonatomic , copy) NSString              * spare14th;
@property (nonatomic , copy) NSString              * spare15th;
@property (nonatomic , copy) NSString              * spare16th;
@property (nonatomic , copy) NSString              * spare17th;
@property (nonatomic , copy) NSString              * spare18th;
@property (nonatomic , copy) NSString              * spare19th;
@property (nonatomic , copy) NSString              * spare20th;
@property (nonatomic , assign) NSInteger              generalStatus;
@property (nonatomic , copy) NSString              * generalMaleMsg;
@property (nonatomic , assign) NSInteger              generalMaleSize;
@property (nonatomic , copy) NSString              * generalFemaleMsg;
@property (nonatomic , assign) NSInteger              generalFemaleSize;
@property (nonatomic , assign) NSInteger              maleStatus;
@property (nonatomic , copy) NSString              * maleMsg;
@property (nonatomic , assign) NSInteger              maleSize;
@property (nonatomic , assign) NSInteger              femaleStatus;
@property (nonatomic , copy) NSString              * femaleMsg;
@property (nonatomic , assign) NSInteger              femaleSize;
@property (nonatomic , copy) NSString              * stateSet;

+ (void)save:(NeighborsSimpleClinentInfo *)model;
+ (NeighborsSimpleClinentInfo *)getUserInfo2;

@end


@interface NeighborsSimpleTool : NSObject

///获取本地ip地址

+ (NSString*)getCurentLocalIP;

///是否开启了VPN的功能

+ (BOOL)isVPNOn;

@end

@interface EaseTextView :UITextView

/**
 *  提示用户输入的标语
 */
@property (nonatomic, copy) NSString *placeHolder;

/**
 *  标语文本的颜色
 */
@property (nonatomic, strong) UIColor *placeHolderTextColor;

/**
 *  提示语距离左侧的距离
 */
@property (nonatomic,assign) CGFloat leftPadding;

/**
 *  获取自身文本占据有多少行
 *
 *  @return 返回行数
 */
- (NSUInteger)numberOfLinesOfText;

/**
 *  获取每行的高度
 *
 *  @return 根据iPhone或者iPad来获取每行字体的高度
 */
+ (NSUInteger)maxCharactersPerLine;

/**
 *  获取某个文本占据自身适应宽带的行数
 *
 *  @param text 目标文本
 *
 *  @return 返回占据行数
 */
+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;


@property (nonatomic,copy) void (^textViewDidChange) (void);

@property (nonatomic,copy) void (^textViewReturnBlock) (NSString *text);

/**插入图片*/
- (void)addImage:(UIImage *)image;

@end

@interface ViewInstance : NSObject
/**
 创建label
 */
+ (UILabel *)defindLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font;

/**
 创建button
 */
+ (UIButton *)defindButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;

//只有标题的按钮
+ (UIButton *)defindButOnlyTileWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;

//只有图片的按钮
+ (UIButton *)defindButOnlyImageWithFrame:(CGRect)frame image:(UIImage *)image;

//只有标题的渐变颜色的按钮
+ (UIButton *)defindColorButOnlyTileWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font;


/**
 创建imageView
 */
+ (UIImageView *)defindImageViewWithFrame:(CGRect)frmae image:(UIImage *)image;

/**
 创建一个view
 */
+ (UIView *)defindViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

/**
 *  创建一个textView
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor;

/**
 *  创建一个textView(重载)
 */
+ (EaseTextView *)defindTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 *  创建一个textField
 */
+ (UITextField *)defindTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

/**
 *  创建一个textField
 */
+ (UITextField *)defindColorTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder placeColor:(UIColor *)color;

/**
 *  创建分割线
 */
+ (UILabel *)defindLinelWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor;


@end

typedef void (^SelectBlock)(void);

typedef void (^CancleBlock)(void);

@interface GlobalModel : NSObject

//根据颜色获取图片
+ (UIImage*) imageWithColor:(UIColor*)color;

+ (BOOL)isNum:(id)obj;

//自适应宽度
+ (CGFloat)returnSieByLabelText:(NSString *)text withlabelFont:(NSInteger)fontOfLab;

//自适应高度
+ (CGFloat)returnSieHeightWithText:(NSString *)text withCGSzie:(CGSize)size withTextFont:(CGFloat)fontNum;

//带有行间距计算高度
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGSize)maxSize withLineSpace:(CGFloat)lineSpace;

//给label设置行距和字距
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withKernSpace:(CGFloat)kernSpace;

//设置行间距
+ (NSMutableParagraphStyle *)settingLabelLineSpacing:(CGFloat)lineSpace;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 获取已date为节点n天之前的日期
 @parame n 多少天之前
 date 时间节点
 
 */

+ (NSString *)getPastNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm;

/**
 获取已date为节点n天之后的日期
 @parame n 多少天之后
 date 时间节点
 
 */
+ (NSString *)getFutureNDay:(NSInteger)n withDate:(NSDate *)date withDateForm:(NSString *)dateForm;

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

//全局时间日期格式 yyyy-MM-dd

+ (NSDateFormatter *)wholeDateFormmatter;

//HH:mm
+ (NSDateFormatter *)dateFormHourMinute;

//yyyy-MM-dd HH:mm
+ (NSDateFormatter *)dateFormYMDHourMinute;

+ (void)setUpLayerrPropertyWithView:(UIView *)view withCornerRadius:(CGFloat)cornerRadius withBorderWidth:(CGFloat)borderWidth withBoderColor:(UIColor *)borderColor;

//根据不同mol值设置不同字体颜色
+ (UIColor *)accordingDifferenceMolToChangeLabelColorWithMol:(CGFloat)mol withTimeIndex:(NSInteger)index;


/**
 系统弹框
 */
+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message alertStyle:(UIAlertControllerStyle)style actionTitle:(NSString *)actionTitle cancelActionTitle:(NSString *)cancelTitle selectBlock:(SelectBlock)selectBlock cancleBlock:(CancleBlock)cancleBlock;

/**
 获取当前视图的控制器
 
 @return 控制器
 */
+ (UIViewController*)getCurrentViewController:(UIView *)view;



/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

//实用的常用公共方法

/**
 获取磁盘总空间大小
 */
+ (CGFloat)diskOfAllSizeMBytes;

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes;

//获取指定路径下某个文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;

//获取字符串(或汉字)首字母 --- 返回大写字母
+ (NSString *)firstCharacterWithString:(NSString *)string;

//将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;

//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format;

//获取指定时间与当前时间的时间差
+ (NSInteger)timeIntervalFromActivityTime:(NSString *)activityTime;

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

//利用正则表达式验证
+ (BOOL)isAvailableEmail:(NSString *)email;

//Avilable in iOS 8.0 and later -- 毛玻璃效果的view
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame withEffectStyle:(UIBlurEffectStyle)effectStyle;

//全屏截图
+ (UIImage *)shotScreen;

//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view;

//截取view中某个区域生成一张图片
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

//判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;

//判断字符串中是否全部为数字
+ (BOOL)isAllNum:(NSString *)string;

/*
 ** 绘制虚线
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

/**
 *  创建一个倒计时
 *  count  -  倒计时多少秒(int)
 *  running - 返回还剩多少秒
 *  finish - 倒计时完毕
 */
+ (dispatch_source_t)defindCountDownWithTimeCount:(int)count running:(void(^)(NSString *restTime))running finish:(void(^)(void))finish;

/**
 *  获取当前window顶层的控制器
 */
+ (UIViewController*)topViewController;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

//判断两个日期的大小
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//获取整个app缓存大小
+ (CGFloat)folderSize;

//清除缓存
+ (void)removeCache:(void (^) (BOOL success))success;

//高德天气判断
+ (NSString *)weatherImageWithState:(NSString *)state withPageType:(NSInteger)type;

//拨打电话
+ (void)callPhoneWithPhoneStr:(NSString *)tel;

/**
 *  返回截取屏幕的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot;

/**
 *  并发执行完毕后处理逻辑（如多个网络请求完成之后再刷新UI）
 *  num---需要并发操作的数量
 *  block---传出循环个数i以及并发队列group
 *  notiBlock---所有的并发操作完成之后通知主线程操作
 *  需注意、在实现block时需要主动调用dispatch_group_leave、因为此方法的循环中是有调用dispatch_group_enter的。需一一对应才会回调notiBlock
 */

+ (void)handleMutipleNetworkWithNumber:(int)num block:(void (^) (int i,dispatch_group_t group))block notiBlock:(void (^) (void))notiBlock;

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)isNotchScreen;

//判断文件是否已经在沙盒中已经存在？
+ (BOOL)isFileExist:(NSString *)fileName;

//不能输入特殊字符
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;

//判断长度大于6位后再接着判断是否同时包含数字和大小写字母
+ (BOOL)judgePassWordLegal:(NSString *)pass;

//用户名为6-16位字母加数字组成
+ (NSString *)verifyUserName:(NSString *)userName;

//密码为6-32为数字与字母组成
+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName;

/*
 *  处理小数点、price（doubel）。position（保留小数点后几位）。进位或降位修改model即可
 */
-(NSString *)stringByNotRounding:(double)price afterPoint:(int)position;

//改变文字颜色及大小
+ (NSMutableAttributedString *)changeTextColorFont:(NSString *)str char:(NSString *)charStr color:(UIColor *)color font:(UIFont *)font;

//改变文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeTextBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor color:(UIColor *)color font:(UIFont *)font;

//改变3个不同文字背景颜色、颜色及大小
+ (NSMutableAttributedString *)changeThreeBgColorFont:(NSString *)str char:(NSString *)charStr bgColor:(UIColor *)bgColor char2:(NSString *)charStr2 bgColor2:(UIColor *)bgColor2 color:(UIColor *)color font:(UIFont *)font;

//添加图标
+ (NSMutableAttributedString *)addPullDownIcon:(NSString *)value color:(UIColor *)color;

//添加标签
+ (NSMutableAttributedString *)addLabelsIcon:(NSString *)value img:(UIImage *)img;

//h5转富文本
+ (NSMutableAttributedString *)ChangeToNSMutableAttributedString:(NSString *)contentStr;

// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString*)idCard;

//是否安装了QQ
+ (BOOL)isQQ;
//是否安装了微信
+ (BOOL)isWX;
//是否安装了新浪微博
+ (BOOL)isSina;

@end

@interface UIView (ViewCayegory)

@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat bottom;

@property (nonatomic,assign) CGFloat right;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

//Method

//移除所有子视图
- (void)removeAllSubviews;

/**
  *  视图旋转动画
  *  isAsTimeDirection = yes 表示顺时针  为no逆时针旋转
 */
- (void)startRotateAnimation:(BOOL)isAsTimeDirection;
- (void)stopRotateAnimation;
- (BOOL)isRotateAnimation;

/**
 *  视图闪烁
 *  duration --- 动画周期时长
 */

- (void)startFlashAnimation:(CGFloat)duration;
- (void)stopFlashAnimation;
- (BOOL)isFlashAnimation;

//视图中某个位置的颜色
- (UIColor *) colorOfPoint:(CGPoint)point;

/**
 
 * 添加阴影
 *
 
 */
- (void)addLayerShadowOfColor:(UIColor *)shadowColor withOpacity:(CGFloat)Opacity withRadius:(CGFloat)Radius withSize:(CGSize)size;

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

//添加毛玻璃效果 alpha 0-1
- (UIVisualEffectView *)addBlurEffectWithAlpha:(CGFloat)alpha;


@end


@interface MyPickerView : UIView

+ (void)showWithData:(NSArray *)arr flag:(NSInteger)flag tipText:(NSString *)tip block:(void(^)(NSArray *arr))block;

@end

@interface MyPickerSingleCell : UITableViewCell

@property (nonatomic,strong) NSString *text;

@property (nonatomic,assign) BOOL selectTag;

@end


@interface NeighborsSimpleCuteSettingMainController : NeighborsSimpleCuteBaseController

@end


@interface NeighborsSimpleCuteSettingOtherMainController : NeighborsSimpleCuteBaseController

@end


@interface NeighborsSimpleCuteBaseSettingMainController : NeighborsSimpleCuteBaseController

@end


@interface NeighborsSimpleCuteMessagePictureCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *timeLab;

@property (nonatomic,strong)UIImageView *iconImage;

@property (nonatomic,strong)UIView *contentBgView;

@property (nonatomic,strong)UIImageView *pictureImage;

@end

@interface NeighborsSimpleCuteMessageContentCell : UICollectionViewCell

@property (nonatomic,strong)SocializeIntercourseMessageModel *model;

@property (nonatomic,strong)UILabel *timeLab;

@property (nonatomic,strong)UIImageView *iconImage;

@property (nonatomic,strong)UIView *contentBgView;

@property (nonatomic,strong)UILabel *contentLab;

@end

@interface NeighborsSimpleCuteMessageChatMainController : NeighborsSimpleCuteBaseController
@property (nonatomic,copy)NSString *NameStr;
@property (nonatomic,copy)NSString *IconStr;
@end

// 聊天界面的cell
@interface NeighborsSimpleCuteMessageListCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImageView;

@property (nonatomic,strong)UILabel *titleLab;

@property (nonatomic,strong)UILabel *subTitleLab;

@end

@interface NeighborsSimpleCuteMessageMainController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteSettingContentViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UILabel *titleLab;

@end

/// 新ui设计的功能
@interface NeighborsSimpleCuteSettingHeaderOtherViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UIButton *nameBtn;

@end

@interface CusLabel :UILabel

@property (nonatomic, strong) NSArray *colors;

@end


@interface NeighborsSimpleCuteSettingRechargeOtherViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIButton *rechagerBtn;

@property (nonatomic,copy)void(^NeighborsSimpleCuteSettingRechargeViewCellRechageBlock)(void);

@end

@interface NeighborsSimpleCuteSettingContentOtherViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UILabel *titleLab;

@end

//base Setting

@interface NeighborsSimpleCuteBaseSettingContentViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *titleLab;

@end


@interface NeighborsSimpleCuteSettingHeaderViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UILabel *iconLab;

@end

@interface NeighborsSimpleCuteSettingRechargeViewCell : UICollectionViewCell

@property (nonatomic,strong)UIButton *rechagerBtn;

@property (nonatomic,copy)void(^NeighborsSimpleCuteSettingRechargeViewCellRechageBlock)(void);

@end



@interface NeighborsSimpleCuteDelAccountView : UIView
@property (nonatomic,copy)void(^NeighborsSimpleCuteDelAccountViewBlock)(void);
@end


@interface NeighborsSimpleCuteReportView : UIView

@property(nonatomic,copy)void(^NeighborsSimpleCuteReportViewReportBlock)(void);

@property(nonatomic,copy)void(^NeighborsSimpleCuteReportViewBlockBlock)(void);

@property(nonatomic,copy)void(^NeighborsSimpleCuteReportViewCancelBlock)(void);

@end

@interface NeighborsSimpleCuteSignOutView : UIView

@property (nonatomic,copy)void(^NeighborsSimpleCuteSignOutViewShowBlock)(void);

@end

@interface NeighborsSimpleCuteDelAccountController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteChnageNameView : UIView
@property (nonatomic,copy)void(^NeighborsSimpleCuteChnageNameViewBlcok)(NSString *nameStr);
@end


@interface NeighborsSimpleCuteSettingProfileController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteSettingFeedBackController : NeighborsSimpleCuteBaseController

@property (nonatomic,assign)BOOL isisMute;

@property (nonatomic,copy)void(^NeighborsSimpleCuteSettingFeedBackControllerBackBlock)(void);

@end

@interface NeighborsSimpleCuteSettingAboutusController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteSettingBlockController : NeighborsSimpleCuteBaseController

@end



@interface NeighborsSimpleCuteAppClientModel : NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * clientNum;
@property (nonatomic , copy) NSString              * description;
@property (nonatomic , assign) NSInteger              auditingState;
@property (nonatomic , assign) NSInteger              updateFlag;
@property (nonatomic , copy) NSString              * updateUrl;
@property (nonatomic , copy) NSString              * updateDescription;
@property (nonatomic , assign) NSInteger              delFlag;
@property (nonatomic , copy) NSString              * spare1st;
@property (nonatomic , copy) NSString              * spare2nd;
@property (nonatomic , copy) NSString              * spare3rd;
@property (nonatomic , copy) NSString              * spare4th;
@property (nonatomic , copy) NSString              * spare5th;
@property (nonatomic , copy) NSString              * spare6th;
@property (nonatomic , copy) NSString              * spare7th;
@property (nonatomic , copy) NSString              * spare8th;
@property (nonatomic , copy) NSString              * spare9th;
@property (nonatomic , copy) NSString              * spare10th;
@property (nonatomic , copy) NSString              * spare11th;
@property (nonatomic , copy) NSString              * spare12th;
@property (nonatomic , copy) NSString              * spare13th;
@property (nonatomic , copy) NSString              * spare14th;
@property (nonatomic , copy) NSString              * spare15th;
@property (nonatomic , copy) NSString              * spare16th;
@property (nonatomic , copy) NSString              * spare17th;
@property (nonatomic , copy) NSString              * spare18th;
@property (nonatomic , copy) NSString              * spare19th;
@property (nonatomic , copy) NSString              * spare20th;
@property (nonatomic , assign) NSInteger              generalStatus;
@property (nonatomic , copy) NSString              * generalMaleMsg;
@property (nonatomic , assign) NSInteger              generalMaleSize;
@property (nonatomic , copy) NSString              * generalFemaleMsg;
@property (nonatomic , assign) NSInteger              generalFemaleSize;
@property (nonatomic , assign) NSInteger              maleStatus;
@property (nonatomic , copy) NSString              * maleMsg;
@property (nonatomic , assign) NSInteger              maleSize;
@property (nonatomic , assign) NSInteger              femaleStatus;
@property (nonatomic , copy) NSString              * femaleMsg;
@property (nonatomic , assign) NSInteger              femaleSize;
@property (nonatomic , copy) NSString              * stateSet;
@end


@interface NeighborsSimpleCuteTokenDtoModel : NSObject
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * refreshToken;
@property (nonatomic , assign) NSInteger              expiresIn;
@end


@interface NeighborsSimpleCuteUserInfoModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy)  NSString             * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr18th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr23th; //zf开发，zjf移植, 界面a，强制配置不能支付
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@property (nonatomic , assign) NSInteger              isIpCheck;
@property (nonatomic, copy) NSString                 *ipContent;

//new add
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , strong) NSString              * city;

@property (nonatomic , strong) NSString              * spareStr2nd;
@property (nonatomic , strong) NSString              * spareStr3rd;
@property (nonatomic , strong) NSString              * spareStr4th;
@property (nonatomic , strong) NSString              * spareStr5th;
@property (nonatomic , strong) NSString              * spareStr8th;
@property (nonatomic , strong) NSString              * spareStr9th;
@property (nonatomic , strong) NSString              * spareStr11th;
@property (nonatomic , strong) NSString              * spareStr15th;
@property (nonatomic , strong) NSString              * spareStr6th;
@property (nonatomic , strong) NSString              * spareStr10th;
@property (nonatomic , strong) NSString              * spareStr12th;
@property (nonatomic , strong) NSString              * tempStr2nd;
@property (nonatomic , strong) NSString              * tempStr1st;
@property (nonatomic , strong) NSString              * tempStr8th;
@property (nonatomic , strong) NSString              * tempStr9th;
@property (nonatomic , strong) NSString              * introduce;


@end

@interface NeighborsSimpleCuteAccountModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , assign) NSInteger              restrictLogin;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              gmFlag;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * clientNum;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , assign) NSInteger              flshTime;
@end

@interface NeighborsSimpleCuteUserModel : NSObject

@property (nonatomic , strong) NeighborsSimpleCuteAccountModel              * account;
@property (nonatomic , strong) NeighborsSimpleCuteUserInfoModel             * userInfo;
@property (nonatomic , strong) NeighborsSimpleCuteTokenDtoModel             * tokenDto;
@property (nonatomic , strong) NeighborsSimpleCuteAppClientModel            * appClient;
@property (nonatomic , strong) NSArray <NSString *>              * photos;

+ (void)setMemberLevel:(NSInteger)memberLevel;
+ (NSInteger)memberLevel;
+ (NSDictionary *)locaOrderInfo;
+ (void)setLocaOrderInfo:(NSDictionary *)locaOrderInfo;
+ (void)save:(NeighborsSimpleCuteUserModel *)model;
+ (NeighborsSimpleCuteUserModel *)getUserInfo;
+(void)removeUpgradatelocaOrderInfo;
+ (BOOL)isOnline;
+ (void)logout;

@end

#pragma mark -- 付费系统

@interface KJBananerModel : NSObject

@property (nonatomic,copy)NSString *iconImg;

@property (nonatomic,copy)NSString *titleStr;

@property (nonatomic,copy)NSString *subTitleStr;

@end


@interface ZFMemberUpgradeIAPModel : NSObject

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, copy) NSString *orderNum;

@property (nonatomic, copy) NSString *tempStr9th;

@property (nonatomic, assign) NSInteger reRequestInt;

-(void)actionRequestAddPurchaseUpgradeRecord;

@end


@interface ZFUpgradteBottomProlicyViewCell : UICollectionViewCell

@end

@interface ZFUpgradteOtherBottomProlicyViewCell : UICollectionViewCell

@end


@interface ZFUpgradteCommitBuyViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *contiue_btn;
@property (nonatomic,copy)void(^ZFUpgradteCommitBuyViewCellContinueBlock)(void);
@end

@interface ZFUpgradteOtherCommitBuyViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *contiue_btn;
@property (nonatomic,copy)void(^ZFUpgradteCommitBuyViewCellContinueBlock)(void);
@end

@interface ZFUpgradteContentViewCell : UICollectionViewCell
@property (strong, nonatomic) UIButton *bg_view;
@property (strong, nonatomic) UIView *bg_view2;
@property (strong, nonatomic) UILabel *middle_lab;
@property (strong, nonatomic) UILabel *top_lab;
@property (strong, nonatomic) UILabel *bottom_lab;

@end

@interface ZFUpgradteOtherContentViewCell : UICollectionViewCell
@property (strong, nonatomic) UIButton *bg_view;
@property (strong, nonatomic) UIView *bg_view2;
@property (strong, nonatomic) CusLabel *middle_lab;
@property (strong, nonatomic) UILabel *top_lab;
@property (strong, nonatomic) UILabel *bottom_lab;

@end


@interface ZFMemberUpgrdeController : NeighborsSimpleCuteBaseController

@end

@interface ZFMemberUpgrdeOtherController : NeighborsSimpleCuteBaseController

@end

@interface XSDKResourceUtil : NSObject

+(CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont;

//获取字符串宽 // 传一个字符串和字体大小来返回一个字符串所占的宽度

+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont;

//获取字符串高 // 传一个字符串和字体大小来返回一个字符串所占的高度

+(float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width;

 

+(UIImage*)imageAt:(NSString*)imgNamePath;

 

+(BOOL)xsdkcheckName:(NSString*)name;

+(BOOL)xsdkcheckPhone:(NSString *)userphone;

 

+ (UIColor *)xsdkcolorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

 

+(BOOL)xsdkstringIsnilOrEmpty:(NSString*)string;

 

+(BOOL)jsonFieldIsNull:(id)jsonField;

+(int)filterIntValue:(id)value withDefaultValue:(int)defaultValue;

+(NSString*)filterStringValue:(id)value withDefaultValue:(NSString*)defaultValue;


@end

//IMChat内容部分

@interface TCLoginParam : NSObject

@property (nonatomic, assign) NSInteger tokenTime;
@property (nonatomic, assign) BOOL      isLastAppExt;
@property (nonatomic, copy) NSString*   identifier;
@property (nonatomic, copy) NSString*   hashedPwd;

+ (instancetype)shareInstance;

+ (instancetype)loadFromLocal;

- (void)saveToLocal;

- (BOOL)isExpired;

- (BOOL)isValid;

@end


@interface IMManagerUtil : NSObject <V2TIMSimpleMsgListener>

+ (instancetype)IMManagerSharedInstance;

- (void)IMManagerWithlogin:(NSString *)identifier userSig:(NSString *)sig succ:(TSucc)succ fail:(TFail)fail;


- (void)IMManagerconfigIM;

@property (nonatomic, assign) NSInteger CxIMLoginStatus;

@end

@interface PAirSandbox : NSObject

+ (instancetype)sharedInstance;
- (void)enableSwipe;
- (void)showSandboxBrowser;

- (void)addAppGroup:(NSString *)groupId;

@end

//report action
#define Action_Install            @"install"                    //安装
#define Action_Startup            @"startup"                    //启动
#define Action_Staytime           @"staytime"                   //使用时长
#define Action_Register           @"register"                   //注册
#define Action_Login              @"login"                      //登录
#define Action_Logout             @"logout"                     //登出
#define Action_Clickhelper        @"clickhelper"                //点击IM助手
#define Action_Sendmsg2helper     @"sendmsg2helper"             //向IM助手发消息
#define Action_Clickdefaultgrp    @"clickdefaultgrp"            //点击默认交流群
#define Action_Sendmsg2defaultgrp @"sendmsg2defaultgrp"         //向默认群发送消息
#define Action_Createc2c          @"createc2c"                  //发起C2C会话
#define Action_Createprivategrp   @"createprivategrp"           //创建讨论组
#define Action_Createpublicgrp    @"createpublicgrp"            //创建群聊
#define Action_Createchatroomgrp  @"createchatroomgrp"          //创建聊天室
#define Action_Addfriend          @"addfriend"                  //添加好友
#define Action_Addgroup           @"addgroup"                   //添加群组
#define Action_Addblacklist       @"addblacklist"               //添加黑名单
#define Action_Deleteblacklist    @"deleteblacklist"            //删除黑名单
#define Action_Modifyselfprofile  @"modifyselfprofile"          //修改个人信息
#define Action_Setapns            @"setapns"                    //设置消息提醒
#define Action_Clickaboutsdk      @"clickaboutsdk"              //点击关于云通信
#define Action_Clickdebug         @"clickdebug"                 //点击开发调试
#define Action_Clickmemoryreport  @"clickmemoryreport"          //点击内存泄露上报
#define Action_SendMsg            @"sendmsg"                    //发消息

//when Action_SendMsg
#define Action_Sub_Sendtext        @"sendtext"         //发送文本消息
#define Action_Sub_Sendaudio       @"sendaudio"        //发送语音消息
#define Action_Sub_Sendface        @"sendface"         //发送表情消息
#define Action_Sub_Sendpicture     @"sendpicture"      //发送图片消息
#define Action_Sub_Sendvideo       @"sendvideo"        //发送视频消息
#define Action_Sub_Sendfile        @"sendfile"         //发送文件消息
#define Action_Sub_Sendgrouplive   @"sendgrouplive"    //发送群直播消息
#define Action_Sub_Sendcustom      @"sendcustom"       //发送自定义消息

//when Action_Modifyselfprofile
#define Action_Sub_Modifyfaceurl   @"modifyfaceurl"    //修改头像
#define Action_Sub_Modifybirthday  @"modifybirthday"   //修改生日
#define Action_Sub_Modifynick      @"modifynick"       //修改昵称
#define Action_Sub_Modifysignature @"modifysignature"  //修改签名
#define Action_Sub_Modifylocation  @"modifylocation"   //修改所在地
#define Action_Sub_Modifygender    @"modifygender"     //修改性别
#define Action_Sub_Modifyallowtype @"modifyallowtype"  //修改好友申请

@interface TCUtil: NSObject

+ (NSData *)dictionary2JsonData:(NSDictionary *)dict;

+ (NSString *)dictionary2JsonStr:(NSDictionary *)dict;

+ (NSDictionary *)jsonSring2Dictionary:(NSString *)jsonString;

+ (NSDictionary *)jsonData2Dictionary:(NSData *)jsonData;

+ (NSString *)getFileCachePath:(NSString *)fileName;

+ (NSUInteger)getContentLength:(NSString*)string;

+ (void)asyncSendHttpRequest:(NSDictionary*)param handler:(void (^)(int resultCode, NSDictionary* resultDict))handler;
+ (void)asyncSendHttpRequest:(NSString*)command params:(NSDictionary*)params handler:(void (^)(int resultCode, NSString* message, NSDictionary* resultDict))handler;
+ (void)asyncSendHttpRequest:(NSString*)command token:(NSString*)token params:(NSDictionary*)params handler:(void (^)(int resultCode, NSString* message, NSDictionary* resultDict))handler;

// 废弃
+ (void)report:(NSString *)action actionSub:(NSString *)actionSub code:(NSNumber *)code  msg:(NSString *)msg;

@end

typedef NS_OPTIONS(NSUInteger, AspectOptions) {
    AspectPositionAfter   = 0,            /// Called after the original implementation (default)
    AspectPositionInstead = 1,            /// Will replace the original implementation.
    AspectPositionBefore  = 2,            /// Called before the original implementation.

    AspectOptionAutomaticRemoval = 1 << 3 /// Will remove the hook after the first execution.
};

/// Opaque Aspect Token that allows to deregister the hook.
@protocol AspectToken <NSObject>

/// Deregisters an aspect.
/// @return YES if deregistration is successful, otherwise NO.
- (BOOL)remove;

@end

/// The AspectInfo protocol is the first parameter of our block syntax.
@protocol AspectInfo <NSObject>

/// The instance that is currently hooked.
- (id)instance;

/// The original invocation of the hooked method.
- (NSInvocation *)originalInvocation;

/// All method arguments, boxed. This is lazily evaluated.
- (NSArray *)arguments;

@end

/**
 Aspects uses Objective-C message forwarding to hook into messages. This will create some overhead. Don't add aspects to methods that are called a lot. Aspects is meant for view/controller code that is not called a 1000 times per second.

 Adding aspects returns an opaque token which can be used to deregister again. All calls are thread safe.
 */
@interface NSObject (Aspects)

/// Adds a block of code before/instead/after the current `selector` for a specific class.
///
/// @param block Aspects replicates the type signature of the method being hooked.
/// The first parameter will be `id<AspectInfo>`, followed by all parameters of the method.
/// These parameters are optional and will be filled to match the block signature.
/// You can even use an empty block, or one that simple gets `id<AspectInfo>`.
///
/// @note Hooking static methods is not supported.
/// @return A token which allows to later deregister the aspect.
+ (id<AspectToken>)aspect_hookSelector:(SEL)selector
                           withOptions:(AspectOptions)options
                            usingBlock:(id)block
                                 error:(NSError **)error;

/// Adds a block of code before/instead/after the current `selector` for a specific instance.
- (id<AspectToken>)aspect_hookSelector:(SEL)selector
                           withOptions:(AspectOptions)options
                            usingBlock:(id)block
                                 error:(NSError **)error;

@end


typedef NS_ENUM(NSUInteger, AspectErrorCode) {
    AspectErrorSelectorBlacklisted,                   /// Selectors like release, retain, autorelease are blacklisted.
    AspectErrorDoesNotRespondToSelector,              /// Selector could not be found.
    AspectErrorSelectorDeallocPosition,               /// When hooking dealloc, only AspectPositionBefore is allowed.
    AspectErrorSelectorAlreadyHookedInClassHierarchy, /// Statically hooking the same method in subclasses is not allowed.
    AspectErrorFailedToAllocateClassPair,             /// The runtime failed creating a class pair.
    AspectErrorMissingBlockSignature,                 /// The block misses compile time signature info and can't be called.
    AspectErrorIncompatibleBlockSignature,            /// The block signature does not match the method or is too large.

    AspectErrorRemoveObjectAlreadyDeallocated = 100   /// (for removing) The object hooked is already deallocated.
};

extern NSString *const AspectErrorDomain;

//聊天界面 Cell

@interface GroupCreateCellData : TUISystemMessageCellData

@end


@interface MyCustomCellData : TUIMessageCellData
@property NSString *text;
@property NSString *link;
@end

@interface GroupCreateCell : TUISystemMessageCell

- (void)fillWithData:(GroupCreateCellData *)data;

@end

@interface MyCustomCell :TUIMessageCell
@property UILabel *myTextLabel;
@property UILabel *myLinkLabel;

@property MyCustomCellData *customData;
- (void)fillWithData:(MyCustomCellData *)data;

@end

// 聊天界面Controller
 
@interface TUIInputBar (Cxshareldstaretl)

@end
 
@interface GroupInfoController :UIViewController
@property (nonatomic, strong) NSString *groupId;
@end

@interface GroupMemberController :UIViewController
@property (nonatomic, strong) NSString *groupId;
@end

#import "TUIUserProfileControllerServiceProtocol.h"
@interface TUserProfileController:UITableViewController <TUIUserProfileControllerServiceProtocol>

@end

@interface ChatViewController: UIViewController
@property (nonatomic, strong) TUIConversationCellData *conversationData;
@property (nonatomic, strong) TUnReadView *unRead;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *tempStr20th;
@property (nonatomic, copy)NSString *nickName;
- (void)sendMessage:(TUIMessageCellData*)msg;
@end


// 界面界面用到的其他功能View
@interface IMUpdateGrdateView : UIView
@property (nonatomic,copy)void(^IMUpdateGrdateViewUpgradeBlock)(void);
@property (nonatomic,copy)void(^IMUpdateGrdateViewUpgradeDissmissBlock)(void);
@end

@interface CXMessageFraudAlterView : UIView
@property (nonatomic,copy)void(^CXMessageFraudAlterViewOKBlock)(void);
@end

@interface CXMessageMuteAlterView :UIView
@property (nonatomic,copy)void(^CXMessageMuteAlterViewFeedBackBlock)(void);
@end

@interface VerifyAccountUpdateView : UIView
@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)void(^VerifyAccountUpdateViewCancelBlock)(void);
@property (nonatomic,copy)void(^VerifyAccountUpdateViewMessageBlock)(void);
@end

@interface CXMessageConversationViewCell : TCommonTableViewCell

/**
 *  头像视图。
 *  当该会话为1对1好友会话时，头像视图为用户头像。
 *  当该会话为群聊时，头像视图为群头像。
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**
 *  会话标题
 *  当该会话为1对1好友会话时，标题为好友的备注，若对应好友没有备注的话，则显示好友 ID。
 *  当该会话为群聊时，标题为群名称。
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  会话消息概览（下标题）
 *  概览负责显示对应会话最新一条消息的内容/类型。
 *  当最新的消息为文本消息/系统消息时，概览的内容为消息的文本内容。
 *  当最新的消息为多媒体消息时，概览的内容为对应的多媒体形式，如：“动画表情” / “[文件]” / “[语音]” / “[图片]” / “[视频]” 等。
 *  若当前会话有草稿时，概览内容为：“[草稿]XXXXX”，XXXXX为草稿内容。
 */
@property (nonatomic, strong) UILabel *subTitleLabel;

/**
 *  时间标签
 *  负责在会话单元中显示最新消息的接收/发送时间。
 *  对于当天的消息，以 “HH：MM”的格式显示时间。
 *  对于非当天的消息，则显示消息收/发当天为星期几。
 */
@property (nonatomic, strong) UILabel *timeLabel;

/**
 *  消息免打扰
 */
@property (nonatomic, strong) UIImageView *disturbImageView;

/**
 *  未读视图
 *  如果当前会话有消息未读的话，则在会话单元右侧显示红底白字的原型图标来展示未读数量。
 */
@property (nonatomic, strong) TUnReadView *unReadView;

/**
 *  会话消息数据源
 *  存储会话单元所需的一系列信息与数据。包含会话头像、会话类型（1对1/群组）、会话标题、未读计数等等。
 *  数据源还会负责部分数据的获取与处理。
 *  数据源的详细信息请参考 \Section\Conversation\Cell\TUIConversationCellData.h
 */
@property (atomic, strong) TUIConversationCellData *convData;

/**
 * 会话选中图标
 * 多选场景中用来标识是否选中会话
 */
@property (nonatomic, strong) UIImageView *selectedIcon;

/**
 *  填充数据
 *  根据传入的数据源，对会话单元中的各个属性进行赋值。
 *  本函数中还包含了一些会话单元的初始化操作。
 */
- (void)fillWithData:(TUIConversationCellData *)convData;


@property (nonatomic, strong) UIView *bgView;;

@property (nonatomic, strong) UIView *bgHeaderView;


@property (nonatomic, assign) BOOL isHideSubTitleInfo;

@end

@interface CXMessageNoDataAlertView : UIView
@property (nonatomic, copy) void (^CXMessageNoDataAlertViewBottomClickBlock)(void);
@end

@interface CXChatBlockAlertView : UIView

@property (nonatomic, strong) UIButton *chat_btn_1;
@property (nonatomic, copy) void (^CXChatBlockAlertViewBtnsClickBlock)(NSInteger btnIndex);
@end

@interface CXChatBlockMaterialAlertView :UIView
@property (nonatomic, strong) UIButton *chat_btn_1;
@property (nonatomic, copy) void (^CXChatBlockAlertViewBtnsClickBlock)(NSInteger btnIndex);
@end


// 聊天界面主要的功能列表
@class CXConversationListController;

@protocol CXConversationListControllerListener <NSObject>
/**
 *  在会话列表中，获取会话展示信息时候回调。
 *
 *  @param conversation 会话单元数据
 */
- (NSString *)getConversationDisplayString:(V2TIMConversation *)conversation;

/**
 *  在会话列表中，点击了具体某一会话后的回调。
 *  您可以通过该回调响应用户的点击操作，跳转到该会话对应的聊天界面。
 *
 *  @param conversationController 委托者，当前所在的消息列表。
 *  @param conversationCell 被选中的会话单元
 */
- (void)conversationListController:(CXConversationListController *)conversationController didSelectConversation:(TUIConversationCell *)conversationCell;
@end

@interface CXConversationListController: UIViewController

/**
 *  消息列表。
 *  消息列表控制器通过 UITableView 的形式实现会话的统一展示。
 *  UITableView 同时能够提供各个单元的删除、点击响应等管理操作。
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  委托类，负责实现 TUIConversationListControllerListener 的委托函数。（已废弃，请使用 TUIKitListenerManager -> addConversationListControllerListener 方法监听）
 */
//@property (nonatomic, weak) id<TUIConversationListControllerListener> delegate;

/**
 *  消息列表的视图模型
 *  视图模型能够协助消息列表界面实现数据的加载、移除、过滤等多种功能。替界面分摊部分的业务逻辑运算。
 */
@property (nonatomic, strong) TConversationListViewModel *viewModel;

@end


@interface CXMessageConverListtionController : NeighborsSimpleCuteBaseController

/**
 *跳转到对应的聊天界面
 */
- (void)pushToChatViewController:(NSString *)groupID userID:(NSString *)userID;

@end

@interface CXSCommonTools :NSObject

+ (instancetype)sharedNetworkTool;

-(void)acitonTimeWithtransactiontime;


@end

@interface NeighborsSimpleCuteEmpteryController : NeighborsSimpleCuteBaseController

@end


// 新需求的功能 tabbard的功能
@interface  ZFTabbarController :UITabBarController

@end

//头部
@interface NeighborsSimpleCuteSettingHeaderWookaViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UIButton *nameBtn;

@end

//中部
@interface NeighborsSimpleCuteSettingMiddleWookaViewCell : UICollectionViewCell

@property (nonatomic,strong)UIButton *vistorBtn;

@property (nonatomic,strong)UILabel *vistorNumberLab;

@property (nonatomic,strong)UILabel *vistorLab;

@property (nonatomic,strong)UIButton *likeMeBtn;

@property (nonatomic,strong)UILabel *likeMeNumberLab;

@property (nonatomic,strong)UILabel *likeMeLab;

@property (nonatomic,strong)UIButton *requestBtn;

@property (nonatomic,strong)UILabel *requestNumberLab;

@property (nonatomic,strong)UILabel *requestLab;

@property (nonatomic,copy)void(^NeighborsSimpleCuteSettingMiddleWookaViewCellMiddleBlock)(int tag);

@end

// 内容
@interface NeighborsSimpleCuteSettingContentWookaViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *iconImg;

@property (nonatomic,strong)UILabel *titleLab;

@end
//个人中心
@interface NeighborsSimpleCuteSettingMainWookaController: NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleEmpteryView:UIView

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic,copy)void(^NeighborsSimpleEmpteryViewSearchMatchBlock)(void);

@end

@interface NeighborsSimpleCuteVistoerWookaViewCell : UICollectionViewCell

@property (strong, nonatomic)  UIView *active_view;
@property (strong, nonatomic)  UIImageView *hg_img;
@property (strong, nonatomic)  UIImageView *icon_img;
@property (strong, nonatomic)  UIView *icon_bg_view;
@property (strong, nonatomic)  UILabel *name_lab;
@property (strong, nonatomic)  UILabel *time_lab;
@property (strong, nonatomic)  UILabel *number_lab;

@end

@interface NeighborsSimpleCuteVisoterWookaModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              regionId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr2nd;
@property (nonatomic , copy) NSString              * spareStr3rd;
@property (nonatomic , copy) NSString              * spareStr4th;
@property (nonatomic , copy) NSString              * spareStr5th;
@property (nonatomic , copy) NSString              * spareStr6th;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr8th;
@property (nonatomic , copy) NSString              * spareStr9th;
@property (nonatomic , copy) NSString              * spareStr10th;
@property (nonatomic , copy) NSString              * spareStr11th;
@property (nonatomic , copy) NSString              * spareStr12th;
@property (nonatomic , copy) NSString              * spareStr13th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr15th;
@property (nonatomic , copy) NSString              * spareStr16th;
@property (nonatomic , copy) NSString              * spareStr17th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , copy) NSString              * spareStr20th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr1st;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr8th;
@property (nonatomic , copy) NSString              * tempStr9th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr24th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@property (nonatomic , assign) NSInteger              isIpCheck;
@property (nonatomic , assign) NSInteger              isNew;
@property (nonatomic , assign) NSInteger              totalNum;
@property (nonatomic , assign) NSInteger              sortTime;
@end

//访客列表
@interface NeighborsSimpleCuteSettingVistoeWookaController:NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteLikeMeWookaViewCell :UICollectionViewCell
@property (strong, nonatomic) UIButton *all_bg_btn;
@property (strong, nonatomic) UIButton *bg_btn;
@property (strong, nonatomic) UIView *icon_bg_view;
@property (strong, nonatomic) UIImageView *icon_img;
@property (strong, nonatomic) UILabel *name_lab;
@property (strong, nonatomic) UIView *time_bg_view;
@property (strong, nonatomic) UILabel *time_lab;
@property (strong, nonatomic) UIView *active_view;
@property (strong, nonatomic) UIImageView *hg_img;

@end

@interface NeighborsSimpleCuteLikeWookaModel: NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              regionId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr2nd;
@property (nonatomic , copy) NSString              * spareStr3rd;
@property (nonatomic , copy) NSString              * spareStr4th;
@property (nonatomic , copy) NSString              * spareStr5th;
@property (nonatomic , copy) NSString              * spareStr6th;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr8th;
@property (nonatomic , copy) NSString              * spareStr9th;
@property (nonatomic , copy) NSString              * spareStr10th;
@property (nonatomic , copy) NSString              * spareStr11th;
@property (nonatomic , copy) NSString              * spareStr12th;
@property (nonatomic , copy) NSString              * spareStr13th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr15th;
@property (nonatomic , copy) NSString              * spareStr16th;
@property (nonatomic , copy) NSString              * spareStr17th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , copy) NSString              * spareStr20th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr1st;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr8th;
@property (nonatomic , copy) NSString              * tempStr9th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr24th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@property (nonatomic , assign) NSInteger              isIpCheck;
@property (nonatomic , assign) NSInteger              isNew;
@property (nonatomic , assign) NSInteger              totalNum;
@property (nonatomic , assign) NSInteger              sortTime;
@end

//喜欢列表
@interface NeighborsSimpleCuteSettingLikeMeWookaController:NeighborsSimpleCuteBaseController
@property (nonatomic,copy)NSString *numberStr;
@end
//请求列表v
@interface NeighborsSimpleSettingRequestWookaController : NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteHomeVoiceUserInfoWookaModel : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr14th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@end

@interface NeighborsSimpleCuteHomeVoiceWookaModel: NSObject

@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              cityId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr18th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@property (nonatomic , assign) NSInteger              times;
@property (nonatomic , assign) NSInteger              isIpCheck;


@end

@interface NeighborsSimpleCuteUserVoiceWookaViewCell :UICollectionViewCell
@property (strong, nonatomic)  UIView *bg_view;
@property (strong, nonatomic)  UIImageView *icon_img;
@property (strong, nonatomic)  UILabel *name_lab;
@property (strong, nonatomic)  UILabel *other_lab;
@property (strong, nonatomic)  UIImageView *gh_img;
@end

@interface NeighborsSimpleCuteFiterModel : NSObject
@property (nonatomic,copy)NSString *genderStr;
@property (nonatomic,copy)NSString *maxStr;
@property (nonatomic,copy)NSString *minStr;
@property (nonatomic,copy)NSString *countryStr;
@property (nonatomic,copy)NSString *stateStr;
@property (nonatomic,copy)NSString *cityStr;
@property (nonatomic,copy)NSString *countryId;
@property (nonatomic,copy)NSString *stateId;
@property (nonatomic,copy)NSString *cityId;
@property (nonatomic,assign)BOOL isanyWhere;

+ (void)save:(NeighborsSimpleCuteFiterModel *)model;
+ (NeighborsSimpleCuteFiterModel *)getUserInfo;
+ (BOOL)isOnline;
+ (void)logout;

@end

//全部的数据功能
@interface NeighborsSimpleCuteHomeAllWookaController: NeighborsSimpleCuteBaseController

@end

//主页用户列表
@interface NeighborsSimpleCuteHomeUserListWookaController: NeighborsSimpleCuteBaseController

-(void)actionNewFiterList2;

@end

@interface CXSGradientLabel : UILabel

- (instancetype)initWithColors:(NSArray *)colors;

@property (nonatomic, strong) NSArray *colors;


@end

//头部功能
@interface ScammerHeaderViewCell : UICollectionViewCell
@property (strong, nonatomic)  CusLabel *titleLab;
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIButton *writeScammerBtn;
@property (strong, nonatomic)  UILabel *contentLab;
@property (nonatomic,copy)void(^ScammerHeaderViewCellAddBlock)(void);
@end

//中间部分
@interface ScammerContentViewCell: UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet CusLabel *titleLab;
@property (strong, nonatomic) IBOutlet CusLabel *numberLab;
@property (strong, nonatomic) IBOutlet CusLabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *typeContentLab;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet CusLabel *detailLab;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@end

@interface ScammerModelUserInfo : NSObject
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * socialNum;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              age;
@property (nonatomic , copy) NSString              * imgUrl;
@property (nonatomic , assign) NSInteger              memberLevel;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , assign) CGFloat              longitude;
@property (nonatomic , assign) CGFloat              latitude;
@property (nonatomic , assign) NSInteger              maritalStaus;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , assign) NSInteger              countryId;
@property (nonatomic , assign) NSInteger              provinceId;
@property (nonatomic , assign) NSInteger              loginTime;
@property (nonatomic , assign) NSInteger              imgStatus;
@property (nonatomic , assign) NSInteger              appType;
@property (nonatomic , copy) NSString              * spareStr1st;
@property (nonatomic , copy) NSString              * spareStr7th;
@property (nonatomic , copy) NSString              * spareStr14th;
@property (nonatomic , copy) NSString              * spareStr18th;
@property (nonatomic , copy) NSString              * spareStr19th;
@property (nonatomic , assign) NSInteger              spareNum1st;
@property (nonatomic , assign) NSInteger              spareNum2nd;
@property (nonatomic , assign) NSInteger              spareNum3rd;
@property (nonatomic , assign) NSInteger              spareNum4th;
@property (nonatomic , assign) NSInteger              spareNum5th;
@property (nonatomic , assign) NSInteger              spareNum6th;
@property (nonatomic , assign) NSInteger              spareNum7th;
@property (nonatomic , assign) NSInteger              spareNum8th;
@property (nonatomic , assign) NSInteger              spareNum9th;
@property (nonatomic , assign) NSInteger              spareNum10th;
@property (nonatomic , assign) NSInteger              isSugar;
@property (nonatomic , copy) NSString              * tempStr5th;
@property (nonatomic , copy) NSString              * tempStr6th;
@property (nonatomic , copy) NSString              * tempStr7th;
@property (nonatomic , copy) NSString              * tempStr18th;
@property (nonatomic , copy) NSString              * tempStr20th;
@property (nonatomic , copy) NSString              * tempStr30th;
@property (nonatomic , assign) NSInteger              isDel;
@property (nonatomic , assign) NSInteger              isHidden;
@property (nonatomic , assign) NSInteger              imImgStatus;
@end

@interface ScammerModel : NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              isDelete;
@property (nonatomic , copy) NSString              * dynamicId;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , copy) NSString              * audios;
@property (nonatomic , copy) NSString              * videos;
@property (nonatomic , assign) NSInteger              goodCount;
@property (nonatomic , assign) NSInteger              commentCount;
@property (nonatomic , assign) NSInteger              viewCount;
@property (nonatomic , assign) NSInteger              isEssence;
@property (nonatomic , assign) NSInteger              isRecommend;
@property (nonatomic , assign) NSInteger              isHot;
@property (nonatomic , assign) NSInteger              isNew;
@property (nonatomic , assign) NSInteger              beReportedCount;
@property (nonatomic , assign) NSInteger              delDate;
@property (nonatomic , assign) NSInteger              delForMe;
@property (nonatomic , copy) NSString              * dyLbs;
@property (nonatomic , copy) NSString              * location;
@property (nonatomic , copy) NSString              * appTypeId;
@property (nonatomic , assign) NSInteger              audit;
@property (nonatomic , assign) NSInteger              recommendSocre;
@property (nonatomic , strong) ScammerModelUserInfo              * userInfo;
@end

//SAMMER 系统
@interface  NeighborsSimpleCuteScammerListController :NeighborsSimpleCuteBaseController

@end

//标题cell
@interface ScammerSendTitleViewCell: UICollectionViewCell
@property (strong, nonatomic) CusLabel *titleLab;
@end

//头部cell
@interface ScammerSendHeaderViewCell: UICollectionViewCell
@property (strong, nonatomic)  UIButton *firstBtn;
@property (strong, nonatomic)  UIButton *secondBtn;
@property (strong, nonatomic)  UIButton *thirdBtn;
@property (strong, nonatomic)  UIButton *fourBtn;
@property (nonatomic,copy)void(^ScammerSendHeaderViewCellChooseTypeBlock)(NSString *typeStr,NSString *contentStr);
@end
//中间cell
@interface ScammerSendMiddleViewCell : UICollectionViewCell

@end

//底部cell
@interface ScammerSendBottomViewCell : UICollectionViewCell

@end

///空cell
@interface ScammerEmptyViewCell : UICollectionViewCell

@end

//Send SACMMER
@interface NeighborsSimpleCuteScammerSendController:NeighborsSimpleCuteBaseController

@end

@interface NeighborsSimpleCuteCountryModel : NSObject
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *code;
@end

@interface NeighborsSimpleCuteResetCountryModel : NSObject
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *sectionTitle; // 本地添加的字段
-(instancetype)initWithName:(NSString *)name withID:(NSInteger)id withCode:(NSString *)code;
@end

@interface NeighborsSimpleCuteCountryViewCell: UICollectionViewCell

@property (nonatomic,strong)UIButton *content_btn;

@end

@interface NeighborsSimpleCuteCountryReusableView :UICollectionReusableView

@property (strong, nonatomic)UILabel *title_lab;

@end

@interface UICollectionViewLeftAlignedLayout : UICollectionViewFlowLayout

@end

@protocol UICollectionViewDelegateLeftAlignedLayout <UICollectionViewDelegateFlowLayout>

@end


@interface NeighborsSimpleCuteLocationShowView : UIView
@property (strong, nonatomic) UIView *bg_view;
@property (strong, nonatomic) CusLabel *title_lab;
@property (nonatomic,copy)void(^NeighborsSimpleCuteLocationShowViewSelectBlock)(NeighborsSimpleCuteResetCountryModel *countryModel,NeighborsSimpleCuteResetCountryModel *statemodel,NeighborsSimpleCuteResetCountryModel *cityModel);
+ (instancetype)alertViewShow;
- (void)show;
- (void)dismiss;
@end

//fiter
@interface NeighborsSimpleCuteFiterController:NeighborsSimpleCuteBaseController
@property (nonatomic,copy)void(^NeighborsSimpleCuteHomeFiterControllerBlock)(NSString *minStr,NSString *maxStr,NSString *genderStr,NeighborsSimpleCuteResetCountryModel *countryModel,NeighborsSimpleCuteResetCountryModel *stateModel,NeighborsSimpleCuteResetCountryModel *cityModel, BOOL anyWhere);
@end

#pragma mark --- ZF todo -- 完善个人资料的功能

@interface GradientTextHelp : NSObject

+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

@interface NSCPersonMessageInfoModel : NSObject
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSInteger appType;
@property (copy, nonatomic) NSString *area;
@property (assign, nonatomic) NSInteger birthday;
@property (copy, nonatomic) NSString *city;
@property (assign, nonatomic) NSInteger cityId;
@property (copy, nonatomic) NSString *constellation;
@property (copy, nonatomic) NSString *country;
@property (assign, nonatomic) NSInteger countryId;
@property (assign, nonatomic) NSInteger friendsIntention;
@property (assign, nonatomic) NSInteger gender;
@property (assign, nonatomic) NSInteger height;
@property (assign, nonatomic) NSInteger imImgStatus;
@property (assign, nonatomic) NSInteger imgStatus;
@property (copy, nonatomic) NSString *imgUrl;
@property (assign, nonatomic) NSInteger integral;
@property (assign, nonatomic) NSInteger isDel;
@property (assign, nonatomic) NSInteger isHidden;
@property (assign, nonatomic) NSInteger isIpCheck;
@property (assign, nonatomic) NSInteger isSugar;
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *likes;
@property (assign, nonatomic) NSInteger loginTime;
@property (copy, nonatomic) NSString *longitude;
@property (assign, nonatomic) NSInteger maritalStaus;
@property (assign, nonatomic) NSInteger memberLevel;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *profession;
@property (copy, nonatomic) NSString *province;
@property (assign, nonatomic) NSInteger provinceId;
@property (copy, nonatomic) NSString *region;
@property (assign, nonatomic) NSInteger regionId;
@property (assign, nonatomic) NSInteger sexual;
@property (copy, nonatomic) NSString *signature;
@property (assign, nonatomic) NSInteger socialNum;
@property (assign, nonatomic) NSInteger spareNum10th;
@property (assign, nonatomic) NSInteger spareNum1st;
@property (assign, nonatomic) NSInteger spareNum2nd;
@property (assign, nonatomic) NSInteger spareNum3rd;
@property (assign, nonatomic) NSInteger spareNum4th;
@property (assign, nonatomic) NSInteger spareNum5th;
@property (assign, nonatomic) NSInteger spareNum6th;
@property (assign, nonatomic) NSInteger spareNum7th;
@property (assign, nonatomic) NSInteger spareNum8th;
@property (assign, nonatomic) NSInteger spareNum9th;
@property (copy, nonatomic) NSString *spareStr10th;
@property (copy, nonatomic) NSString *spareStr11th;
@property (copy, nonatomic) NSString *spareStr12th;
@property (copy, nonatomic) NSString *spareStr13th;
@property (copy, nonatomic) NSString *spareStr14th;
@property (copy, nonatomic) NSString *spareStr15th;
@property (copy, nonatomic) NSString *spareStr16th;
@property (copy, nonatomic) NSString *spareStr17th;
@property (copy, nonatomic) NSString *spareStr18th;
@property (copy, nonatomic) NSString *spareStr19th;
@property (copy, nonatomic) NSString *spareStr1st;
@property (copy, nonatomic) NSString *spareStr20th;
@property (copy, nonatomic) NSString *spareStr2nd;
@property (copy, nonatomic) NSString *spareStr3rd;
@property (copy, nonatomic) NSString *spareStr4th;
@property (copy, nonatomic) NSString *spareStr5th;
@property (copy, nonatomic) NSString *spareStr6th;
@property (copy, nonatomic) NSString *spareStr7th;
@property (copy, nonatomic) NSString *spareStr8th;
@property (copy, nonatomic) NSString *spareStr9th;
@property (copy, nonatomic) NSString *tempStr10th;
@property (copy, nonatomic) NSString *tempStr11th;
@property (copy, nonatomic) NSString *tempStr12th;
@property (copy, nonatomic) NSString *tempStr13th;
@property (copy, nonatomic) NSString *tempStr14th;
@property (copy, nonatomic) NSString *tempStr15th;
@property (copy, nonatomic) NSString *tempStr16th;
@property (copy, nonatomic) NSString *tempStr17th;
@property (copy, nonatomic) NSString *tempStr18th;
@property (copy, nonatomic) NSString *tempStr19th;
@property (copy, nonatomic) NSString *tempStr1st;
@property (copy, nonatomic) NSString *tempStr20th;
@property (copy, nonatomic) NSString *tempStr21th;
@property (copy, nonatomic) NSString *tempStr22th;
@property (copy, nonatomic) NSString *tempStr23th;
@property (copy, nonatomic) NSString *tempStr24th;
@property (copy, nonatomic) NSString *tempStr25th;
@property (copy, nonatomic) NSString *tempStr26th;
@property (copy, nonatomic) NSString *tempStr27th;
@property (copy, nonatomic) NSString *tempStr28th;
@property (copy, nonatomic) NSString *tempStr29th;
@property (copy, nonatomic) NSString *tempStr2nd;
@property (assign, nonatomic) NSInteger tempStr30th;
@property (copy, nonatomic) NSString *tempStr3rd;
@property (copy, nonatomic) NSString *tempStr4th;
@property (copy, nonatomic) NSString *tempStr5th;
@property (copy, nonatomic) NSString *tempStr6th;
@property (copy, nonatomic) NSString *tempStr7th;
@property (copy, nonatomic) NSString *tempStr9th;
@property (assign, nonatomic) NSInteger times;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger weight;
@property (copy, nonatomic) NSString *introduce;

@end

@interface NSCPersonMessagePhotoModel : NSObject

@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger imgCode;
@property (copy, nonatomic) NSString *imgUrl;
@property (assign, nonatomic) NSInteger reviewStatus;
@property (assign, nonatomic) NSInteger userId;

@end

@interface NSCPersonMessageMainModel : NSObject
@property (assign, nonatomic) NSInteger attentionState;
@property (assign, nonatomic) NSInteger distance;
@property (strong, nonatomic) NSArray<NSCPersonMessagePhotoModel *> *photos;
@property (assign, nonatomic) NSInteger upvoteState;
@property (strong, nonatomic) NSCPersonMessageInfoModel *userInfo;
@end

typedef NS_ENUM(NSUInteger, MCLayoutStatus){
    /** 正常位置，图左字右 */
    MCLayoutStatusNormal,
    /** 图右字左 */
    MCLayoutStatusImageRight,
    /** 图上字下 */
    MCLayoutStatusImageTop,
    /** 图下字上 */
    MCLayoutStatusImageBottom,
};
@interface UIButton (MCLayout)
- (void)layoutWithStatus:(MCLayoutStatus)status andMargin:(CGFloat)margin;
@end

@interface UITextView (ZWPlaceHolder)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *zw_placeHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *zw_placeHolderColor;

@end

@interface NSCPersonMessageHeaderView : UIView

@end


@interface NSCPersonMessageInfoTableViewCell : UITableViewCell

-(void)reloadUIWithModel:(NSCPersonMessageInfoModel *)model data:(NSArray *)data;
-(void)reloadUIWithName:(NSString *)name info:(NSString *)info data:(NSArray *)data;

@end

@interface NSCPersonMessageAboutMeTableViewCell : UITableViewCell
-(void)reloadUIWithStr:(NSString *)str;
@end

@interface NSCPersonMessageAboutMatchTableViewCell : UITableViewCell
-(void)reloadUIWithStr:(NSString *)str;
@end

@interface NSCPersonMessageContactTableViewCell : UITableViewCell
-(void)reloadUIWithStr:(NSString *)str;
@end

@interface NSCPersonMessageContaceHeightCell2: UICollectionViewCell

@property (nonatomic,copy)NSString *incomStr;

@end

@interface NSCPersonMessageContaceHeightCell: UICollectionViewCell

@end

@protocol NSCPersonMessageContactNoDataTableViewCellDelegate <NSObject>
-(void)clickVisorButton;
@end
@interface NSCPersonMessageContactNoDataTableViewCell : UITableViewCell
@property (nonatomic, weak) id<NSCPersonMessageContactNoDataTableViewCellDelegate> delegate;
@end

@interface NSCMyMessageTagTableView : UITableViewCell

@end

@protocol NSCMyMessageViewDelegate <NSObject>
-(void)myMessageIsAllReadyWithIndex:(NSInteger)index;
@end

@interface NSCMyMessageView : UIView
@property (nonatomic , assign) NSInteger  index;
@property (nonatomic, weak) id<NSCMyMessageViewDelegate> delegate;
@end




@interface NSCPersonMessageViewController : NeighborsSimpleCuteBaseController
@property (nonatomic , assign) NSInteger              personUserId;
@property (nonatomic,  copy)   NSString              *tempStr20th;
@property (nonatomic,  copy)   NSString              *nickName;
@end





























