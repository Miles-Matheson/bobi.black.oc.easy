//
//  WKVoiceListCollectCell.h
//  Woko
//
//  Created by 王树银 on 2022/4/26.
//

#import <UIKit/UIKit.h>
#import "WSYBaseCollectionCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^videoBtnClickBlock)(NSDictionary *dic);
@interface WKVoiceListCollectCell : WSYBaseCollectionCell

@property(nonatomic,strong)UIImageView   *iconImgV;

@property(nonatomic,strong)UIImageView  *voiceImgV;

@property(nonatomic,strong)UIView   *backV;

@property(nonatomic,strong)UIButton  *videoBtn;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,copy)videoBtnClickBlock  block;
@end

NS_ASSUME_NONNULL_END
