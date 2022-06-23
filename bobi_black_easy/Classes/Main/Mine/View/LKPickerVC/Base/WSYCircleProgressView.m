//
//  WSYCircleProgressView.m
//  VoiceProject
//
//  Created by 王树银 on 2022/4/13.
//

#import "WSYCircleProgressView.h"
#import "UIColor+CHRegex.h"

@interface WSYCircleProgressView ()
{
    CAShapeLayer  *outLayer;
    float         wsy_lineWith;
    
}
@property(nonatomic,strong)UIImageView  *imageV;

@property(nonatomic,assign)CGRect   rect;

@property(nonatomic,strong)CAShapeLayer  *progressLayer;

@end

@implementation WSYCircleProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self createTheSubViews];
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        [self createTheSubViews];
    }
    return self;
}

-(CGRect)rect{
    return self.frame;
}

-(void)createTheSubViews{
    wsy_lineWith = 5;
    [self addSubview:self.imageV];
    outLayer = [CAShapeLayer layer];
    CGRect  imgRect = CGRectMake(wsy_lineWith/2, wsy_lineWith/2,self.rect.size.width - wsy_lineWith, self.rect.size.height - wsy_lineWith);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:imgRect];
    outLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    outLayer.lineWidth = wsy_lineWith;
    outLayer.fillColor = [UIColor clearColor].CGColor;
    outLayer.lineCap = kCALineCapRound;
    outLayer.path = path.CGPath;
    [self.layer addSublayer:outLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor colorWithHexString:@"FF7D3A"].CGColor;
    self.progressLayer.lineWidth = wsy_lineWith;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = path.CGPath;
    [self.layer addSublayer:self.progressLayer];
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.imageV.transform = CGAffineTransformMakeRotation(M_PI_2);
}

-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.rect];
        _imageV.layer.masksToBounds = true;
        _imageV.layer.cornerRadius = self.rect.size.width/2;
    }
    return _imageV;
}

-(void)setScirImage:(UIImage *)scirImage{
    _scirImage = scirImage;
    if (_scirImage) {
        self.imageV.image = _scirImage;
    }
}

-(void)updateProgressWithNumber:(NSInteger)num{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.progressLayer.strokeEnd = num/100.0;
    [CATransaction commit];
}
@end
