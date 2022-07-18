//
//  HUProgressView.m
//  CALayerDemo1
//
//  Created by jewelz on 15/4/4.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "HUProgressView.h"
#import "BobiEasyHeader.h"
static const CFTimeInterval DURATION = 2;
static const CGFloat WIDTH_NORMAL = 22;
static const CGFloat HEIGHT_NORMAL = 22;
static const CGFloat LINE_WIDTH_NORMAL = 1;

#define kDefaultStrokeColor [UIColor lightGrayColor]
#define WIDTH_B  40
#define HEIGHT_B  40
#define LINE_WIDTH_BIG  2.5

@interface HUProgressView()

@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CABasicAnimation *rotateAnimation;
@property (strong, nonatomic) CABasicAnimation *strokeAnimatinStart;
@property (strong, nonatomic) CABasicAnimation *strokeAnimatinEnd;
@property (strong, nonatomic) CAAnimationGroup *animationGroup;
@end

@implementation HUProgressView

- (instancetype)initWithProgressIndicatorStyle:(HUProgressIndicatorStyle)style {
    
    switch (style) {
        case 0:self =  [self initWithFrame:CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL)];
               self.progressIndicatorStyle = HUProgressIndicatorStyleNormal;
               self.hidden = YES;
            break;
            
        case 1: self = [self initWithFrame:CGRectMake(0, 0, WIDTH_B, HEIGHT_B)];
                self.progressIndicatorStyle = HUProgressIndicatorStyleLarge;
                self.hidden = YES;
            break;
        
    }
    return self;
}

- (instancetype)init {
    
    return [self initWithFrame:CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.progressLayer];
        
    }
    return self;
}


- (void)setProgressIndicatorStyle:(HUProgressIndicatorStyle)progressIndicatorStyle {
    _progressIndicatorStyle = progressIndicatorStyle;
    switch (_progressIndicatorStyle) {
        case 0:
            break;
        case 1:
            {
                self.progressLayer.bounds = CGRectMake(0, 0, WIDTH_B, HEIGHT_B);
                self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH_B/2, HEIGHT_B/2) radius:(WIDTH_B-LINE_WIDTH_BIG) /2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES].CGPath;
                self.progressLayer.lineWidth = LINE_WIDTH_BIG;
            }

            break;
            
        default:
            break;
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.progressLayer.strokeColor = strokeColor.CGColor;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.bounds = CGRectMake(0, 0, WIDTH_NORMAL, HEIGHT_NORMAL);
        _progressLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH_NORMAL/2, HEIGHT_NORMAL/2) radius:(WIDTH_NORMAL-LINE_WIDTH_NORMAL) /2 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = LINE_WIDTH_NORMAL;
        _progressLayer.strokeColor = kDefaultStrokeColor.CGColor;
        _progressLayer.strokeEnd = 0;
        _progressLayer.strokeStart = 0;
        _progressLayer.lineCap = kCALineCapRound;
    }
    return _progressLayer;
}


- (CABasicAnimation *)rotateAnimation {
    if (!_rotateAnimation) {
        _rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _rotateAnimation.fromValue = @0;
        _rotateAnimation.toValue = @(2*M_PI);
        _rotateAnimation.duration = DURATION/2;
        _rotateAnimation.repeatCount = HUGE;
        _rotateAnimation.removedOnCompletion = NO;
    }
    return _rotateAnimation;
}

- (CABasicAnimation *)strokeAnimatinStart {
    if (!_strokeAnimatinStart) {
        _strokeAnimatinStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        _strokeAnimatinStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _strokeAnimatinStart.duration = DURATION/2;
        _strokeAnimatinStart.fromValue = @0;
        _strokeAnimatinStart.toValue = @0.95;
        _strokeAnimatinStart.beginTime = 1;
        _strokeAnimatinStart.removedOnCompletion = NO;
        _strokeAnimatinStart.fillMode = kCAFillModeForwards;
        _strokeAnimatinStart.repeatCount = HUGE;
    }
    return _strokeAnimatinStart;
}

- (CABasicAnimation *)strokeAnimatinEnd {
    if (!_strokeAnimatinEnd) {
        _strokeAnimatinEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeAnimatinEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _strokeAnimatinEnd.duration = DURATION;
        _strokeAnimatinEnd.fromValue = @0;
        _strokeAnimatinEnd.toValue = @0.95;
        _strokeAnimatinEnd.removedOnCompletion = NO;
        _strokeAnimatinEnd.fillMode = kCAFillModeForwards;
        _strokeAnimatinEnd.repeatCount = HUGE;
    }
    return _strokeAnimatinEnd;
}

- (CAAnimationGroup *)animationGroup {
    if (!_animationGroup) {
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.animations = @[self.strokeAnimatinStart, self.strokeAnimatinEnd];
        _animationGroup.repeatCount = HUGE;
        _animationGroup.duration = DURATION;
        
    }
    return _animationGroup;
}

- (void)startProgressAnimating {
    self.hidden = NO;
    [self.progressLayer addAnimation:self.animationGroup forKey:@"group"];
    [self.progressLayer addAnimation:self.rotateAnimation forKey:@"rotate"];
}

- (void)stopProgressAnimating {
    @ktweakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @ktstrongify(self)
        if (self.rotateAnimation && self.animationGroup) {
            [self.progressLayer removeAllAnimations];
            self.hidden = YES;
        }
    });
}

@end
