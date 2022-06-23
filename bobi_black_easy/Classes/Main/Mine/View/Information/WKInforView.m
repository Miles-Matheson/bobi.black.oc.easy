//
//  WKInforView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKInforView.h"
#import "BobiEasyHeader.h"
@interface WKInforView ()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UIImageView *imageRight;

@end

@implementation WKInforView

- (void)createUI {
    [super createUI];
    self.containerView.backgroundColor = KHexColor(0x373636);
    [self.containerView addSubview:self.lblTitle];
    [self.containerView addSubview:self.imageRight];
    [self.containerView addSubview:self.lblContent];
}

- (void)createLayout {
    [super createLayout];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(60));
        make.centerY.equalTo(self.containerView);
    }];
    [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRelative(58));
        make.centerY.equalTo(self.containerView);
    }];
    [self.lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageRight.mas_left).offset(-KRelative(22));
        make.centerY.equalTo(self.containerView);
    }];
}
- (void)configHeadTile:(NSString *)title andValue:(NSString *)value {
    self.lblTitle.text = title;
    self.lblContent.text = value;
}
- (void)changeUserInforSex:(NSString *)sex {
    self.lblContent.text = sex;
}
- (void)changeUserInforAge:(NSString *)age {
    self.lblContent.text = age;
}
#pragma mark - lazy
- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = KHexColor(0xF1C87B);
        _lblTitle.font = KRelativeBoldFont(32);
    }
    return _lblTitle;
}
- (UIImageView *)imageRight {
    if (!_imageRight) {
        _imageRight = [[UIImageView alloc] init];
        _imageRight.image = ImageName(@"image_rigt");
    }
    return _imageRight;
}
- (UILabel *)lblContent {
    if (!_lblContent) {
        _lblContent = [[UILabel alloc] init];
        _lblContent.textColor = [UIColor whiteColor];
        _lblContent.font = KRelativeBoldFont(32);
    }
    return _lblContent;
}

@end
