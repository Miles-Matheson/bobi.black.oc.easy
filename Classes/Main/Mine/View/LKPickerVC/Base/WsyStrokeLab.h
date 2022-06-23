//
//  wsyStrokeLab.h
//  VoiceProject
//
//  Created by 王树银 on 2022/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WsyStrokeLab : UILabel
/** 描多粗的边*/
@property (nonatomic, assign) NSInteger outLineWidth;
/** 外轮颜色*/
@property (nonatomic, strong) UIColor * outLinetextColor;
/** 里面字体默认颜色*/

@property (nonatomic, strong) UIColor * labelTextColor;


@end

NS_ASSUME_NONNULL_END
