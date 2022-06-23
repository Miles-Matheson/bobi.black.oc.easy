//
//  WKDelegateView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKDelegateView.h"
#import "BobiEasyHeader.h"
@interface WKDelegateView ()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imageRight;

@end

@implementation WKDelegateView

- (void)createUI {
    [super createUI];
    self.containerView.backgroundColor = KHexColor(0x373636);
    [self.containerView addSubview:self.lblTitle];
    [self.containerView addSubview:self.imageRight];
}

- (void)createLayout {
    [super createLayout];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.centerY.equalTo(self.containerView);
    }];
    [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRelative(30));
        make.centerY.equalTo(self.containerView);
    }];
    
}
- (void)configTitleAction:(NSString *)title {
    self.lblTitle.text = title;
}
#pragma mark - lazy

- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor whiteColor];
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

@end
