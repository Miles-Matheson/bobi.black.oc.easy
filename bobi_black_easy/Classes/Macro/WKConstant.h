//
//  WKConstant.h
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#ifndef WKConstant_h
#define WKConstant_h

#define KWidth         [UIScreen mainScreen].bounds.size.width
#define KHeight        [UIScreen mainScreen].bounds.size.height
//UIWindow的安全区域Insets
#define KSafeAreaInsets ({\
UIEdgeInsets insets = UIEdgeInsetsZero;\
SEL safeAreaSel = NSSelectorFromString(@"safeAreaInsets");\
if ([[UIApplication sharedApplication].keyWindow respondsToSelector:safeAreaSel])\
{\
NSMethodSignature * methodSignature = [UIWindow instanceMethodSignatureForSelector:safeAreaSel];\
NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:methodSignature];\
[invocation setSelector:safeAreaSel];\
[invocation setTarget:[UIApplication sharedApplication].keyWindow];\
[invocation invoke];\
[invocation getReturnValue:&insets];\
}\
insets;\
})
//状态栏高度
#define KStatusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height
//NaviBar高度
#define KPortraitNaviBarHeight   (KStatusBarHeight + 44)
//Tabbar高度
#define KPortraitTabBarHeight    (KSafeAreaInsets.bottom + 49)

/// 判断刘海屏屏
#define KIsLiuHai ((KStatusBarHeight == 48 || KStatusBarHeight == 47 || KStatusBarHeight == 44) ? YES : NO)
///底部安全区高度
#define KsafeBtoonHight KIsLiuHai == YES ? 34 : 0
#define safeTopHight (KIsLiuHai ? 44 : 20)

#ifndef ktweakify
#define ktweakify(object)\
k_keywordify __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef ktstrongify
#define ktstrongify(object)\
k_keywordify __strong __typeof__(object) object= weak##_##object;

#endif

#if DEBUG
#define k_keywordify autoreleasepool {}
#else
#define k_keywordify try {} @catch (...) {}
#endif



#define KRelative(a)        (roundf((a) * (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 750.0f) * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale)

//#define KRelative(a)        (a) * (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 750.0f)

#define KRelativeFontSize(a)        (a) * (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 750.0f)

#define KRelativeFont(fontSize)  [UIFont fontWithName:@"PingFangSC-Regular" size:KRelativeFontSize(fontSize)] ?: [UIFont systemFontOfSize:KRelativeFontSize(fontSize)]

#define KRelativeBoldFont(fontSize)  [UIFont fontWithName:@"PingFangSC-Semibold" size:KRelativeFontSize(fontSize)] ?: [UIFont boldSystemFontOfSize:KRelativeFontSize(fontSize)]

#define KRelativeMediumFont(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:KRelativeFontSize(fontSize)] ?: [UIFont systemFontOfSize:KRelativeFontSize(fontSize)]

#define ImageName(name) [UIImage mm_xcassetImageNamed:name]

#define kViewBottomInsert   (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) ? self.view.safeAreaInsets.bottom : 0)

#define KHexColor(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define KHexColorAlpha(hexValue,a) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

//
#define mainColor KHexColor(0xFDCA38)

#define KTDECLARESINGLETON \
+ (id)sharedInstance;\

#define KTSINGLETON \
+ (id)sharedInstance { \
    static id state = nil; \
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        state = [[self alloc] init];\
    });\
    return state; \
}

#define MCColor(r, g, b ,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alp]

#define Baidu_Url @"https://www.baidu.com"
#define Else_Url  @"https://browser.360.cn"

#endif /* WKConstant_h */
