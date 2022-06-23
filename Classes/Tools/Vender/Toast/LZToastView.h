//
//  ToastView.h
//  Demo6
//
//  Created by Mibao12 on 2019/11/19.
//  Copyright © 2019 Mibao12. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LZToastViewPosition) {
    LZToastViewPostionTop,
    LZToastViewPostionCenter,
    LZToastViewPostionBottom,
    ToastViewPostionTop = 0 ,
    ToastViewPostionCenter = 1,
    ToastViewPostionBottom = 2
};

typedef NS_ENUM(NSInteger,LZToastViewImageSize) {
    LZToastViewImageSizeDefault, //60*60暂定
    LZToastViewImageSizeSmall,//30 *30暂定
    LZToastViewImageSizeFit,//60*60暂定
    LZToastViewImageSizeBig//80*80 暂定
};

typedef NS_ENUM(NSInteger,LZToastViewImagePosition) {
    LZToastViewImagePositionDefault,//默认显示位置
    LZToastViewImagePositionLeft,//图片显示在左边
    LZToastViewImagePositionTop,//图片显示在上边
    LZToastViewImagePositionRight//图片显示在右边
};

@interface UIView(Categories_Frame)

#pragma mark - frame 设置与或取

/// Description

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat bottom;

/// <#Description#>
@property (nonatomic) CGFloat right;

//判断一个view是否在window上面
-(BOOL)isShowingOnWindow;

@end



@interface LZToastView : UIView

///  Toast View显示,不包蒙层
/// @param showView 要展示的View
/// @param toastText Toast显示文字
/// @param delay 显示时长
/// @param position 显示位置
+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withDelay:(NSTimeInterval)delay withPosition:(LZToastViewPosition)position;

/// Toast View显示在中间,不包蒙层
/// @param showView 要展示的View
/// @param toastText Toast显示的文字
/// @param delay 显示多久
+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withDelay:(NSTimeInterval)delay ;

/// Toast View显示在中间,不包蒙层(默认显示时长3秒)
/// @param showView 要展示的View
/// @param toastText Toast显示文字
+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText;

/// Toast View显示在中间,不包蒙层(默认显示时长3秒)
/// @param showView 要展示的View
/// @param toastText Toast显示文字
/// @param position 显示位置
+ (void)showWithView:(UIView *)showView withText:(NSString *)toastText withPosition:(LZToastViewPosition)position;

///  Toast View显示,包涵图片
/// @param showView 要展示的View
/// @param toastText Toast显示文字
/// @param iconImage 图片
/// @param imageSize 图片大小
/// @param delay 显示时长
/// @param position 显示位置
+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withImage:(UIImage *)iconImage withImageSize:(LZToastViewImageSize)imageSize withImagePosition:(LZToastViewImagePosition)imagePosition withDelay:(NSTimeInterval)delay withPosition:(LZToastViewPosition)position;
@end

NS_ASSUME_NONNULL_END
