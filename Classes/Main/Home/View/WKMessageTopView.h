//
//  WKMessageTopView.h
//  Woko
//
//  Created by 王树银 on 2022/6/23.
//

#import <UIKit/UIKit.h>
#import "WKBaseView.h"
#import "WsyStrokeLab.h"
NS_ASSUME_NONNULL_BEGIN

@interface WKMessageTopView : WKBaseView
@property (nonatomic, strong) UIButton *btnBack;
@property(nonatomic,strong)WsyStrokeLab   *titleLab;
@end

NS_ASSUME_NONNULL_END
