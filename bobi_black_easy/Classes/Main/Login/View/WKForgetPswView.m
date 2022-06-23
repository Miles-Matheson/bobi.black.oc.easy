//
//  WKForgetPswView.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKForgetPswView.h"

@interface WKForgetPswView ()
@property (nonatomic, strong) UITextField *textEmail;
@property (nonatomic, strong) UILabel *lblNote;///note
@property (nonatomic, strong) UIButton *btnContinue;///Sign in

@end

@implementation WKForgetPswView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.textEmail];
    [self.containerView addSubview:self.lblNote];
    [self.containerView addSubview:self.btnContinue];
}

- (void)createLayout {
    [super createLayout];
    [self.textEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.offset(KRelative(56));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(98));
    }];
    [self.lblNote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.textEmail.mas_bottom).offset(KRelative(18));
    }];
    [self.btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(KWidth-KRelative(80), KRelative(102)));
        make.centerX.equalTo(self.containerView);
        make.bottom.offset(-KRelative(218));
    }];
}

#pragma mark - lazy
- (UITextField *)textEmail {
    if (!_textEmail) {
        _textEmail = [[UITextField alloc] init];
        _textEmail.layer.cornerRadius = KRelative(10);
        _textEmail.textColor = [UIColor whiteColor];
        _textEmail.backgroundColor = KHexColor(0x373636);
        _textEmail.placeholder = @"please input your email";
        [_textEmail setValue:KHexColor(0xA3A3A3) forKeyPath:@"placeholderLabel.textColor"];
        _textEmail.font = KRelativeBoldFont(30);
        [_textEmail setTextFieldLeftPadding:_textEmail forWidth:KRelative(20)]; //前面空格10
    }
    return _textEmail;
}
- (UILabel *)lblNote {
    if (!_lblNote) {
        _lblNote = [[UILabel alloc] init];
        _lblNote.text = @"Please enter your email and I will send you the reset\npassword link.You can reset the password\nin the link.";
        _lblNote.textColor = UIColor.whiteColor;
        _lblNote.font = KRelativeBoldFont(26);
        _lblNote.numberOfLines = 0;
    }
    return _lblNote;
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
- (void)onbtnContinueClick {
    [self endEditing:YES];
    if (self.textEmail.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter your account number" finishBlock:nil];
        return;
    }
    if (![self.textEmail.text dn_isValidEmail]) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter the correct email format" finishBlock:nil];
        return;
    }
    [self routerEventWithName:@"ContinueClickAction" userInfo:@{}];
}

@end
