//
//  WKUpLoadImageView.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKUpLoadImageView.h"
#import "BobiEasyHeader.h"
@interface WKUpLoadImageView ()
{
    UIImage *_image;
}
@property (nonatomic, strong) UIButton *btnUpload;
@property (nonatomic, strong) UILabel *lblNote;
@property (nonatomic, strong) UILabel *lblThird;
@property (nonatomic, strong) UIButton *btnContinue;

@end

@implementation WKUpLoadImageView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.btnUpload];
    [self.containerView addSubview:self.lblNote];
    [self.containerView addSubview:self.lblThird];
    [self.containerView addSubview:self.btnContinue];
}

- (void)createLayout {
    [super createLayout];
    [self.btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(KRelative(184));
        make.centerX.equalTo(self.containerView);
        make.size.sizeOffset(CGSizeMake(KRelative(342), KRelative(342)));
    }];
    [self.lblNote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.btnUpload.mas_bottom).offset(KRelative(38));
    }];
    [self.lblThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.lblNote.mas_bottom).offset(KRelative(36));
    }];
    [self.btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(KWidth-KRelative(80), KRelative(102)));
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.lblThird.mas_bottom).offset(KRelative(128));
    }];
}
- (void)changeImage:(UIImage *)image {
    _image = image;
    [self.btnUpload setBackgroundImage:image forState:UIControlStateNormal];
    [self.btnUpload setImage:ImageName(@"") forState:UIControlStateNormal];
}
#pragma mark - lazy
- (UIButton *)btnUpload {
    if (!_btnUpload) {
        _btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUpload setBackgroundImage:ImageName(@"btn_backImage") forState:UIControlStateNormal];
        [_btnUpload setImage:ImageName(@"btn_camera") forState:UIControlStateNormal];
        _btnUpload.layer.cornerRadius = KRelative(171);
        _btnUpload.clipsToBounds = YES;
        [_btnUpload addTarget:self action:@selector(onChooseImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUpload;
}
- (UILabel *)lblNote {
    if (!_lblNote) {
        _lblNote = [[UILabel alloc] init];
        _lblNote.text = @"Upload you best photo";
        _lblNote.font = KRelativeBoldFont(34);
        CGSize size = [@"Upload you best photo" dn_getTextSize:KRelativeBoldFont(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        _lblNote.textColor = [UIColor colorWithPatternImage:bgImg];
    }
    return _lblNote;
}
- (UILabel *)lblThird {
    if (!_lblThird) {
        _lblThird = [[UILabel alloc] init];
        _lblThird.text = @"Post a profile photo to increase the likelihood\nyou'll find someone!";
        _lblThird.textColor = [UIColor whiteColor];
        _lblThird.font = KRelativeBoldFont(30);
        _lblThird.textAlignment = NSTextAlignmentCenter;
        _lblThird.numberOfLines = 0;
    }
    return _lblThird;
}
- (UIButton *)btnContinue {
    if (!_btnContinue) {
        _btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnContinue.layer.cornerRadius = KRelative(14);
        CGSize size = CGSizeMake(KWidth-KRelative(64), KRelative(102));
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        [_btnContinue setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_btnContinue setTitle:@"Continue" forState:UIControlStateNormal];
        [_btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btnContinue.titleLabel.font = KRelativeBoldFont(36);
        [_btnContinue addTarget:self action:@selector(onbtnContinueClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnContinue;
}
- (void)onChooseImage {
    [self routerEventWithName:@"ChooseImageAction" userInfo:@{}];
}
- (void)onbtnContinueClick {
    if (!_image) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please upload your avatar" finishBlock:nil];
        return;
    }
    [self routerEventWithName:@"OnContinueAction" userInfo:@{@"image":_image}];
}

@end
