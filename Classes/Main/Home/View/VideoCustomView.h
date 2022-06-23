//
//  VideoCustomView.h
//  Woko
//
//  Created by 王树银 on 2022/4/19.
//

#import <UIKit/UIKit.h>
#import "WsyStrokeLab.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^videoVDismsBlock)(void);
@interface VideoCustomView : UIView
@property(nonatomic,strong)WsyStrokeLab   *titleLab;
@property(nonatomic,copy)videoVDismsBlock  block;
@property(nonatomic,strong)NSDictionary  *dic;



@end

NS_ASSUME_NONNULL_END
