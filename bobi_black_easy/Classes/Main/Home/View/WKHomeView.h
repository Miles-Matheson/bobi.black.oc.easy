//
//  WKHomeView.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBaseView.h"
#import "WsyBackImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKHomeView : WKBaseView

@property(nonatomic,strong)NSMutableArray *wsy_dataArr;
@property (nonatomic, strong) WsyBackImageView *imageBg;
@end

NS_ASSUME_NONNULL_END
