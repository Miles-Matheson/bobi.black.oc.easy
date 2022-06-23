//
//  WSYCircleProgressView.h
//  VoiceProject
//
//  Created by 王树银 on 2022/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSYCircleProgressView : UIView

@property(nonatomic,strong)UIImage  *scirImage;

-(void)updateProgressWithNumber:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
