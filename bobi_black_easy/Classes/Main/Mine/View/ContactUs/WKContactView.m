//
//  WKContactView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKContactView.h"
#import "BobiEasyHeader.h"
@interface WKContactView () <UITextViewDelegate>
@property (nonatomic, strong) UIView *textBg;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *lblNumer;
@property (nonatomic, strong) UIView *photoBg;
@property (nonatomic, strong) UIButton *btnPhoto;
@property (nonatomic, strong) UIButton *btnSubmit;

@end

@implementation WKContactView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.textBg];
    [self.textBg addSubview:self.textView];
    [self.textBg addSubview:self.lblNumer];
    [self.containerView addSubview:self.photoBg];
    [self.photoBg addSubview:self.btnPhoto];
    [self.containerView addSubview:self.btnSubmit];
}

- (void)createLayout {
    [super createLayout];
    [self.textBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(KRelative(40));
        make.right.offset(-KRelative(40));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(KRelative(20));
        make.right.offset(-KRelative(20));
        make.height.offset(KRelative(400));
    }];
    [self.lblNumer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.right.offset(-KRelative(20));
        make.bottom.offset(-KRelative(16));
    }];
    [self.photoBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.right.offset(-KRelative(40));
        make.top.equalTo(self.textBg.mas_bottom).offset(KRelative(40));
    }];
    [self.btnPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(20));
        make.top.offset(KRelative(38));
        make.bottom.offset(-KRelative(38));
        make.size.sizeOffset(CGSizeMake(KRelative(204), KRelative(204)));
    }];
    [self.btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.photoBg.mas_bottom).offset(KRelative(140));
        make.size.sizeOffset(CGSizeMake(KWidth-KRelative(64), KRelative(102)));
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    //字数限制-200
    if (textView.text.length >= 500) {
        textView.text = [textView.text substringToIndex:500];
    }
    CGSize constraintSize = CGSizeMake(KWidth-KRelative(120), CGFLOAT_MAX);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <= KRelative(400)) {
        size.height = KRelative(400);
    } else {
        size.height = size.height;
    }
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(size.height);
    }];
    self.lblNumer.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
}

//禁止换行
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}

- (void)uploadImage:(UIImage *)image {
    [self.btnPhoto setBackgroundImage:image forState:UIControlStateNormal];
}

#pragma mark - lazy
- (UIView *)textBg {
    if (!_textBg) {
        _textBg = [[UIView alloc] init];
        _textBg.backgroundColor = KHexColor(0x373636);
        _textBg.layer.cornerRadius = KRelative(10);
        _textBg.clipsToBounds = YES;
    }
    return _textBg;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.textColor = [UIColor whiteColor];
        _textView.backgroundColor = KHexColor(0x373636);
        _textView.font = KRelativeBoldFont(30);
        UILabel *placeHolderLabel = [[UILabel alloc]init];
        placeHolderLabel.text = @"Describe your problem...";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.font = KRelativeBoldFont(30);
        placeHolderLabel.textColor = KHexColor(0xA3A3A3);
        [_textView addSubview:placeHolderLabel];
        [placeHolderLabel sizeToFit];
        [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];

    }
    return _textView;
}
- (UILabel *)lblNumer {
    if (!_lblNumer) {
        _lblNumer = [[UILabel alloc] init];
        _lblNumer.text = @"0/500";
        _lblNumer.font = KRelativeBoldFont(26);
        _lblNumer.textColor = KHexColor(0xECC478);
    }
    return _lblNumer;
}
- (UIView *)photoBg {
    if (!_photoBg) {
        _photoBg = [[UIView alloc] init];
        _photoBg.backgroundColor = KHexColor(0x373636);
        _photoBg.layer.cornerRadius = KRelative(22);
        _photoBg.clipsToBounds = YES;
    }
    return _photoBg;
}
- (UIButton *)btnPhoto {
    if (!_btnPhoto) {
        _btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPhoto.layer.cornerRadius = KRelative(22);
        _btnPhoto.clipsToBounds = YES;
        [_btnPhoto setBackgroundImage:ImageName(@"mine_camera") forState:UIControlStateNormal];
        [_btnPhoto addTarget:self action:@selector(onChooseImageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPhoto;
}

- (UIButton *)btnSubmit {
    if (!_btnSubmit) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.layer.cornerRadius = KRelative(14);
        CGSize size = CGSizeMake(KWidth-KRelative(64), KRelative(102));
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        [_btnSubmit setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btnSubmit.titleLabel.font = KRelativeBoldFont(36);
        [_btnSubmit addTarget:self action:@selector(onSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

- (void)onChooseImageClick {
    [self routerEventWithName:@"uploadImageAction" userInfo:@{}];
}

- (void)onSubmitClick {
    if (self.textView.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please fill in the question" finishBlock:nil];
        return;
    }
    [self routerEventWithName:@"submitAction" userInfo:@{}];
}


@end
