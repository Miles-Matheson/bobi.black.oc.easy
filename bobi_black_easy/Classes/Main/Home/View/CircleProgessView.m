//
//  CircleProgessView.m
//  Woko
//
//  Created by 王树银 on 2022/4/27.
//

#import "CircleProgessView.h"

@interface CircleProgessView ()<CAAnimationDelegate>
{
    CABasicAnimation *strokeEndAni;
}
//@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)CAShapeLayer *circleLayer;
@end

@implementation CircleProgessView

-(instancetype)initWithFrame:(CGRect)frame withRadius:(CGFloat)radius withLineWidth:(CGFloat)lineWidth
{
self = [super initWithFrame:frame];
if (self) {
    
    self.backgroundColor = [UIColor clearColor];
    strokeEndAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAni.fromValue = @0;
    strokeEndAni.delegate = self;
    self.lineWidth = lineWidth > 0.1f ? lineWidth : 1.99f;
    self.defaultColor = [UIColor colorWithHexString:@"#46403B"];
    self.progressColor = [UIColor colorWithHexString:@"#DEA167"];
    self.progress = 0.0f;
    self.radius = radius > 0 ? radius : 40;
    // 环
    CGFloat circleX = self.frame.size.width / 2 - self.radius;
    CGFloat circleY = self.frame.size.height / 2 - self.radius;
    CGFloat circleWidth = self.radius * 2;
    self.circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(circleX, circleY, circleWidth, circleWidth) cornerRadius:self.radius];
    // 环形layer
    
    [self prepareTheProgressLayerWithShapeLayer];
  }
  return self;
  }

-(void)prepareTheProgressLayerWithShapeLayer{
    if (self.circleLayer) {
        [self.circleLayer removeFromSuperlayer];
    }
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.strokeColor = [UIColor colorWithHexString:@"#46403B"].CGColor;
    //    circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineWidth = self.lineWidth;
    self.circleLayer.path = self.circlePath.CGPath;
    self.circleLayer.strokeEnd = 1;
    [self.layer addSublayer:self.circleLayer];
    
    if (self.progressLayer) {
        [self.progressLayer removeFromSuperlayer];
    }
    // 进度layer
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor colorWithHexString:@"#DEA167"].CGColor;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = self.circlePath.CGPath;
    self.progressLayer.strokeEnd = 0;
    [self.layer addSublayer:self.progressLayer];
}

 #pragma mark - private method
 -(void)updateProgress:(CGFloat)progress{
    self.progress = progress;
    self.progressLayer.strokeEnd = 100;
    //开始执行扇形动画
    strokeEndAni.fromValue = @(progress);
    strokeEndAni.toValue = @(100);
    strokeEndAni.duration = 3000.0;
    strokeEndAni.repeatCount = 1; // 重复次数
    [self.progressLayer addAnimation:strokeEndAni forKey:@"ani"];
}

-(void)updateProgressWithTime:(NSInteger)timer{
    self.progress = 0;
    self.progressLayer.strokeEnd = 100;
    //开始执行扇形动画
    strokeEndAni.fromValue = @(0);
    strokeEndAni.toValue = @(100);
    strokeEndAni.duration = 100*timer;
    strokeEndAni.repeatCount = 1; // 重复次数
    [self.progressLayer addAnimation:strokeEndAni forKey:@"ani"];
}

-(void)beginRecordingAnmation{
    [self.progressLayer addAnimation:strokeEndAni forKey:@"ani"];
}

-(void)pauseTheAnmaition{
    [self pauseLayer:self.progressLayer];
}

-(void)stopTheAnmation{
    [self.progressLayer removeAllAnimations];
}

-(void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;

}

-(void)goOnRecording{
    [self resumeLayer:self.progressLayer];
}

-(void)resumeLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;

}

@end
