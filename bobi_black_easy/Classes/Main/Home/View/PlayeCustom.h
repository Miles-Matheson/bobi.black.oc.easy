//
//  PlayeCustom.h
//  VoiceProject
//
//  Created by 王树银 on 2022/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayeCustomDelegate <NSObject>
-(void)dissThePlayerView;
-(void)videoWithOthersAction;
-(void)messageWithOthersAction;
-(void)rightItemAction:(NSInteger)index AndTheDic:(NSDictionary *)dic;
@end


@interface PlayeCustom : UIView

@property(nonatomic,weak)id<PlayeCustomDelegate>delegate;

@property(nonatomic,strong)NSDictionary  *dic;

-(void)playStopAction;

//@property(nonatomic,strong)UIImage   *iconImg;



@end

NS_ASSUME_NONNULL_END
