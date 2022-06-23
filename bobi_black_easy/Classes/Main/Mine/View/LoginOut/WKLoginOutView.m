//
//  WKLoginOutView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKLoginOutView.h"
#import "BobiEasyHeader.h"
@interface WKLoginOutView ()
@property (nonatomic, strong) UIView *alertView;

@end


@implementation WKLoginOutView

- (instancetype)initWithLoginOut:(NSString *)title content:(NSString *)content {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0,KWidth , KHeight);
        //
        UIView *viewBack = [[UIView alloc] init];
        viewBack.frame = CGRectMake(0, 0, KWidth, KHeight);
        viewBack.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:viewBack];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRemove)];
        [viewBack addGestureRecognizer:tap];
        //弹框
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = KHexColor(0x373636);
        self.alertView.layer.cornerRadius = KRelative(10);
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.offset(KRelative(646));
        }];
        //
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.text = title;
        lblTitle.font = KRelativeMediumFont(34);
        CGSize size = [title dn_getTextSize:KRelativeBoldFont(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        lblTitle.textColor = [UIColor colorWithPatternImage:bgImg];
        [self.alertView addSubview:lblTitle];
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.alertView.mas_centerX);
            make.top.offset(KRelative(60));
        }];
        //
        UILabel *lblUseContent = [[UILabel alloc] init];
        lblUseContent.text = content;
        lblUseContent.textAlignment = NSTextAlignmentCenter;
        lblUseContent.numberOfLines = 0;
        lblUseContent.textColor = [UIColor whiteColor];
        lblUseContent.font = KRelativeBoldFont(34);
        [self.alertView addSubview:lblUseContent];
        [lblUseContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.alertView);
            make.top.equalTo(lblTitle.mas_bottom).offset(KRelative(84));
        }];
        //cancle
        UIButton *btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancle setTitle:@"Cancel" forState:UIControlStateNormal];
        [btnCancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGSize size1 = CGSizeMake(KRelative(262), KRelative(100));
        UIImage *bgImg1 = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size1];
        [btnCancle setBackgroundColor:[UIColor colorWithPatternImage:bgImg1]];
        [btnCancle addTarget:self action:@selector(onRemove) forControlEvents:UIControlEventTouchUpInside];
        btnCancle.titleLabel.font = KRelativeBoldFont(34);
        btnCancle.layer.cornerRadius = KRelative(10);
        [self.alertView addSubview:btnCancle];
        [btnCancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KRelative(40));
            make.top.equalTo(lblUseContent.mas_bottom).offset(KRelative(164));
            make.bottom.offset(-KRelative(48));
            make.size.sizeOffset(CGSizeMake(KRelative(262), KRelative(100)));
        }];
        //Confirm
        UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
        [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnConfirm setBackgroundColor:[UIColor colorWithPatternImage:bgImg1]];
        [btnConfirm addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btnConfirm.titleLabel.font = KRelativeBoldFont(34);
        btnConfirm.layer.cornerRadius = KRelative(10);
        [self.alertView addSubview:btnConfirm];
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(KRelative(-40));
            make.top.equalTo(lblUseContent.mas_bottom).offset(KRelative(164));
            make.bottom.offset(-KRelative(48));
            make.size.sizeOffset(CGSizeMake(KRelative(262), KRelative(100)));
        }];
    }
    return self;
}
- (void)showAnimation {
    
    self.backgroundColor = [UIColor clearColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];

    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);

    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}
- (void)onRemove {
    [self removeFromSuperview];
}
- (void)onConfirmClick {
    self.block();
}

@end
