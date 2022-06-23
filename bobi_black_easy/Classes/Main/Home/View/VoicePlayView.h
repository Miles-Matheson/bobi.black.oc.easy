//
//  VoicePlayView.h
//  Woko
//
//  Created by 王树银 on 2022/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VoiceCustomDelegate <NSObject>
-(void)dissThePlayerView;
-(void)videoWithOthersAction;
-(void)messageWithOthersAction;
//-(void)rightItemAction:(NSInteger)index AndTheDic:(NSDictionary *)dic;
@end

@interface VoicePlayView : UIView
@property(nonatomic,weak)id<VoiceCustomDelegate>delegate;

@property(nonatomic,strong)NSDictionary  *dic;

-(void)playStopAction;
@end

NS_ASSUME_NONNULL_END
