//
//  WsyBackImageView.h
//  VoiceProject
//
//  Created by 王树银 on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import "WKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^contractWithOthers)(NSDictionary *dic,NSInteger  index);

@interface wsySbuImgView : UIImageView

@property(nonatomic,strong)UIImageView  *iconImgV;
@property(nonatomic,strong)UIImageView  *voiceImgV;
//@property(nonatomic,assign)SEL    seleter;

@end


@interface WsyBackImageView : WKBaseView

@property(nonatomic,strong)UIImageView   *backImageV;
@property(nonatomic,copy)contractWithOthers  block;
@property(nonatomic,strong)wsySbuImgView     *subImgV_1;
@property(nonatomic,strong)wsySbuImgView    *subImgV_2;
@property(nonatomic,strong)wsySbuImgView    *subImgV_3;
@property(nonatomic,strong)wsySbuImgView    *subImgV_4;
@property(nonatomic,strong)wsySbuImgView    *subImgV_5;
@property(nonatomic,strong)wsySbuImgView    *subImgV_6;
@property(nonatomic,strong)NSMutableArray   *dataArr;
@property(nonatomic,strong)NSArray     *subViewsArr;

-(void)freshTheAnmation;
@end

NS_ASSUME_NONNULL_END
