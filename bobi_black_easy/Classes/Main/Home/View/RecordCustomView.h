//
//  RecordCustomView.h
//  VoiceProject
//
//  Created by 王树银 on 2022/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RecordCustDelegate <NSObject>

-(void)cancelAction;
-(void)senderAudioAction;

@end

@interface RecordCustomView : UIView

@property(nonatomic,weak)id<RecordCustDelegate>delegate;

-(void)prepareTheRecording;

-(void)removeTheVoiceFile;
@end

NS_ASSUME_NONNULL_END
