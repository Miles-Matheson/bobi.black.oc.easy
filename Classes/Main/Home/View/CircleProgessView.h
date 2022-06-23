//
//  CircleProgessView.h
//  Woko
//
//  Created by 王树银 on 2022/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgessView : UIView
@property (nonatomic,assign) CGFloat radius; // 环半径
@property (nonatomic,assign) CGFloat lineWidth; //环的宽度
@property (nonatomic,strong) UIColor *defaultColor; // 默认环的颜色
@property (nonatomic,strong) UIColor *progressColor; // 进度条颜色
@property (nonatomic,assign) CGFloat progress; // 进度值
@property (nonatomic,copy) NSString *labelTextString; //环形里面显示的文字
@property(nonatomic,strong)CAShapeLayer *progressLayer;
@property(nonatomic,strong)UIBezierPath *circlePath;

-(instancetype)initWithFrame:(CGRect)frame withRadius:(CGFloat)radius withLineWidth:(CGFloat)lineWidth;

-(void)updateProgress:(CGFloat)progress;
-(void)updateProgressWithTime:(NSInteger)timer;
-(void)prepareTheProgressLayerWithShapeLayer;
-(void)beginRecordingAnmation;
-(void)pauseTheAnmaition;
-(void)goOnRecording;
-(void)stopTheAnmation;
@end

NS_ASSUME_NONNULL_END
