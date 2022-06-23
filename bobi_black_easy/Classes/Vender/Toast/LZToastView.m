//
//  ToastView.m
//  Demo6
//
//  Created by Mibao12 on 2019/11/19.
//  Copyright © 2019 Mibao12. All rights reserved.
//

#import "LZToastView.h"

@interface LZToastView ()

/// <#Description#>
@property (nonatomic,strong) UILabel *toastLabel;

/// <#Description#>
@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,assign) LZToastViewImageSize imageSize;

@property (nonatomic,assign) LZToastViewImagePosition imagePosition;

@property (nonatomic,assign) CGFloat imageHeight;

@end

@implementation UIView(Categories_Frame)
#pragma mark x
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

#pragma mark y
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

#pragma mark width
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

#pragma mark height
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark size
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

#pragma mark centerX
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

#pragma mark centerY
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

#pragma mark 上
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

#pragma mark 左
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

#pragma mark 下
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark 右
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

#pragma mark 判断一个view是否在主窗口上
- (BOOL)isShowingOnWindow {
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    //转换坐标系
    CGRect newFrame = [self.superview convertRect:self.frame toView:keywindow];
    CGRect windowBouns = keywindow.bounds;
    BOOL intersects =  CGRectIntersectsRect(newFrame, windowBouns);
    return !self.isHidden && self.alpha > 0.01 && intersects && self.window == keywindow;
}

@end

@implementation LZToastView
#pragma mark - 公共方法
+ (BOOL)iPhoneX {
    BOOL flag = NO;
    if (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) >= 44) {
        flag = YES;
    }
    return flag;
}

#pragma mark - 初始化方法
+ (instancetype)shareToastViewWithFrame:(CGRect)frame {
    static LZToastView *toastView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastView = [[self alloc] initWithFrame:frame];
    });
    if (frame.size.width != 0)
        toastView.frame = frame;
    return toastView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubUI];
    }
    return self;
}

#pragma mark - UI操作方法
- (void)addSubUI {
    [self addSubview:self.toastLabel];
    [self addSubview:self.iconImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layerUI];
}

- (void)layerUI {
    if (self.iconImageView.hidden) {
        self.toastLabel.frame = CGRectMake(10.f, 0.f, self.width - 20.f, self.height);
    } else {
        CGFloat tempHeight = self.imageHeight - 10.f;
        if (self.imagePosition == LZToastViewImagePositionTop) {
            self.iconImageView.frame = CGRectMake((self.width - tempHeight)/2.f, 5.f, tempHeight, tempHeight);
            self.toastLabel.frame = CGRectMake(10.f, self.iconImageView.bottom , self.width - 20.f, self.height - tempHeight);
        } else if (self.imagePosition == LZToastViewImagePositionDefault || self.imagePosition == LZToastViewImagePositionLeft) {
            self.iconImageView.frame = CGRectMake(5.f, (self.height - tempHeight)/2.f, tempHeight, tempHeight);
            self.toastLabel.frame = CGRectMake(self.iconImageView.right + 5, 0.f, self.width - 20.f - self.iconImageView.width - 5, self.height);
        } else {
            self.iconImageView.frame = CGRectMake(self.width - 5 - tempHeight, (self.height - tempHeight)/2.f, tempHeight, tempHeight);
            self.toastLabel.frame = CGRectMake(5.f, 0.f, self.width - 15 - tempHeight, self.height);
        }
    }
}

#pragma mark - 懒加载UI

- (UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc] init];
        _toastLabel.textColor = [UIColor colorWithRed:0xff/255.f green:0xff/255.f blue:0xff/255.f alpha:1.f];
        _toastLabel.font = [UIFont systemFontOfSize:15.f];
        _toastLabel.textAlignment = NSTextAlignmentCenter;
        _toastLabel.layer.cornerRadius = 6.f;
        _toastLabel.layer.masksToBounds = YES;
    }
    return _toastLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
//        _iconImageView.backgroundColor = [UIColor redColor];
//        _iconImageView.frame = CGRectMake(5.f, 5.f, 20.f, 20.f);
    }
    return _iconImageView;
}

#pragma mark - toast展示方法
+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withDelay:(NSTimeInterval)delay withPosition:(LZToastViewPosition)position {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (toastText.length < 1) {
            return;
        }
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGSize tempSize = [self calcStringSizeWithString:toastText withMaxSize:CGSizeMake(screenWidth * 0.75, NSIntegerMax) withFont:[UIFont systemFontOfSize:16.f]];
        CGFloat toastViewWidth= tempSize.width + 50.f;
        CGFloat left = (screenWidth - toastViewWidth )/2.f;
        CGFloat top = (showView.frame.size.height - 42.f) / 2.f;
        
        if (position == LZToastViewPostionTop) {
            if ([self iPhoneX]) {
                top = 50.f + 88.f;
            } else {
                 top = 50.f + 64.f;
            }
        } else if (position == LZToastViewPostionBottom) {
            if ([self iPhoneX]) {
                top = screenHeight - 34.f - 42.f - 50.f;
            } else {
                top = screenHeight - 41.f-50.f;
            }
        } else {
             top = (showView.frame.size.height - 42.f) / 2.f;
        }
        CGFloat height = 42;
        if (tempSize.height > 30) {
            height = tempSize.height + tempSize.height * 0.4;
        } else {
            height = 42;
        }
        
        LZToastView *toastView = [self shareToastViewWithFrame:CGRectMake((NSInteger)left, top, (NSInteger)toastViewWidth, height)];
        toastView.iconImageView.hidden = YES;
        if (height > 42)
            toastView.toastLabel.attributedText = [self asString:toastText];
        else
            toastView.toastLabel.text = toastText;
        
        if (tempSize.height > 30) {
            toastView.toastLabel.lineBreakMode = NSLineBreakByClipping;
            toastView.toastLabel.numberOfLines = 0;
        } else {
            toastView.toastLabel.numberOfLines = 1;
        }
        toastView.backgroundColor = [UIColor colorWithRed:0x00/255.f green:0x00/255.f blue:0x00/255.f alpha:0.7f];
        toastView.layer.masksToBounds = YES;
        toastView.layer.cornerRadius = 5.f;
        [showView addSubview:toastView];
        [showView bringSubviewToFront:toastView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LZToastView *toastView = [self shareToastViewWithFrame:CGRectZero];
            [toastView removeFromSuperview];
        });
    });
}

+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withImage:(UIImage *)iconImage withImageSize:(LZToastViewImageSize)imageSize withImagePosition:(LZToastViewImagePosition)imagePosition withDelay:(NSTimeInterval)delay withPosition:(LZToastViewPosition)position {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (toastText.length < 1) {
            return;
        }
        //处理文本显示高度
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGSize tempSize = [self calcStringSizeWithString:toastText withMaxSize:CGSizeMake(screenWidth * 0.75, NSIntegerMax) withFont:[UIFont systemFontOfSize:16.f]];
        CGFloat toastViewWidth= tempSize.width + 50.f;
        CGFloat left = (screenWidth - toastViewWidth )/2.f;
        CGFloat top = (showView.frame.size.height - 42.f) / 2.f;
        
        if (position == LZToastViewPostionTop) {
            if ([self iPhoneX]) {
                top = 50.f + 88.f;
            } else {
                 top = 50.f + 64.f;
            }
        } else if (position == LZToastViewPostionBottom) {
            if ([self iPhoneX]) {
                top = screenHeight - 34.f - 42.f - 50.f;
            } else {
                top = screenHeight - 41.f-50.f;
            }
        } else {
             top = (showView.frame.size.height - 42.f) / 2.f;
        }
        CGFloat height = 42;
        if (tempSize.height > 30) {
            height = tempSize.height + tempSize.height * 0.4;
        } else {
            height = 42;
        }
        //处理图片显示高度
        CGFloat imageHeight = 30.f;
        switch (imageSize) {
            case LZToastViewImageSizeDefault:
            case LZToastViewImageSizeFit:
                    imageHeight = 70.f;
                break;
            case LZToastViewImageSizeBig:
                imageHeight = 90.f;
                break;
            case LZToastViewImageSizeSmall:
                imageHeight = 40.f;
                break;
            default:
                break;
        }
        //处理位置信息
        switch (imagePosition) {
            case LZToastViewImagePositionLeft:
            case LZToastViewImagePositionRight:
            case LZToastViewImagePositionDefault:
                if (height < imageHeight) {
                    height = imageHeight;
                }
                break;
            case LZToastViewImagePositionTop:
                height += imageHeight;
                break;
            default:
                break;
        }
        LZToastView *toastView = [self shareToastViewWithFrame:CGRectMake((NSInteger)left, top, (NSInteger)toastViewWidth, height)];
        toastView.imageSize = imageSize;
        toastView.imagePosition = imagePosition;
        toastView.imageHeight = imageHeight;
        toastView.iconImageView.image = iconImage;
        if (height > 42)
            toastView.toastLabel.attributedText = [self asString:toastText];
        else
            toastView.toastLabel.text = toastText;
        
        if (tempSize.height > 30) {
            toastView.toastLabel.lineBreakMode = NSLineBreakByClipping;
            toastView.toastLabel.numberOfLines = 0;
        } else {
            toastView.toastLabel.numberOfLines = 1;
        }
        toastView.backgroundColor = [UIColor colorWithRed:0x00/255.f green:0x00/255.f blue:0x00/255.f alpha:0.5f];
        toastView.layer.masksToBounds = YES;
        toastView.layer.cornerRadius = 5.f;
        [showView addSubview:toastView];
        [showView bringSubviewToFront:toastView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LZToastView *toastView = [self shareToastViewWithFrame:CGRectZero];
            [toastView removeFromSuperview];
        });
    });
}

+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText {
    [self showWithView:showView withText:toastText withDelay:1.5 withPosition:LZToastViewPostionCenter];
}

+ (void)showWithView:(UIView *)showView  withText:(NSString *)toastText withDelay:(NSTimeInterval)delay {
    [self showWithView:showView withText:toastText withDelay:delay withPosition:LZToastViewPostionCenter];
}

+ (void)showWithView:(UIView *)showView withText:(NSString *)toastText withPosition:(LZToastViewPosition)position {
    [self showWithView:showView withText:toastText withDelay:1.5 withPosition:position];
}

+ (NSMutableAttributedString *)asString:(NSString *)string {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    return attStr;
}


+ (CGSize)calcStringSizeWithString:(NSString *)calcString withMaxSize:(CGSize)makeSize withFont:(UIFont *)font {
    NSDictionary*attrs =@{NSFontAttributeName: font}; //返回一个矩形，大小等于文本绘制完占据的宽和高。
    CGSize resultSize = [calcString boundingRectWithSize:makeSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return resultSize;
}
@end
