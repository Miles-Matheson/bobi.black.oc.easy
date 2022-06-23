//
//  wsyShosePicView.h
//  Woko
//
//  Created by 王树银 on 2022/4/21.
//

#import <UIKit/UIKit.h>
#import "WsyShoseProx.h"

NS_ASSUME_NONNULL_BEGIN

@interface wsyShosePicView : UIView

@property(nonatomic,strong)NSMutableArray  *dataArr;

@property(nonatomic,assign)CGSize   picSize;

@property(nonatomic,strong)WsyShoseProx   *shoseProx;

-(void)wsySetShoseProx:(WsyShoseProx *)shoseProx;

@end

NS_ASSUME_NONNULL_END
