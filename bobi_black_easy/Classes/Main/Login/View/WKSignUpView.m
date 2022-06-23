//
//  WKSignUpView.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKSignUpView.h"
#import "ZHAttributeTextView.h"

@interface WKSignUpView ()
{
    BOOL _isAgree;//defalut no
}
@property (nonatomic, strong) UILabel *lblEmail;///E-Mail
@property (nonatomic, strong) UITextField *textEmail;
@property (nonatomic, strong) UILabel *lblPassWord;
@property (nonatomic, strong) UITextField *textPassWord;
@property (nonatomic, strong) UILabel *lblUserName;
@property (nonatomic, strong) UITextField *textUserName;
@property (nonatomic, strong) ZHAttributeTextView *myTextView;
@property (nonatomic, strong) UIButton *btnSignIn;///Sign in

@end

@implementation WKSignUpView

- (void)createUI {
    [super createUI];
    _isAgree = NO;
    [self.containerView addSubview:self.lblEmail];
    [self.containerView addSubview:self.textEmail];
    [self.containerView addSubview:self.lblPassWord];
    [self.containerView addSubview:self.textPassWord];
    [self.containerView addSubview:self.lblUserName];
    [self.containerView addSubview:self.textUserName];
    [self.containerView addSubview:self.myTextView];
    [self.containerView addSubview:self.btnSignIn];
}

- (void)createLayout {
    [super createLayout];
    [self.lblEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.offset(KRelative(146));
    }];
    [self.textEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.lblEmail.mas_bottom).offset(KRelative(24));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(98));
    }];
    [self.lblPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.textEmail.mas_bottom).offset(KRelative(96));
    }];
    [self.textPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.lblPassWord.mas_bottom).offset(KRelative(24));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(98));
    }];
    [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.textPassWord.mas_bottom).offset(KRelative(96));
    }];
    [self.textUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.top.equalTo(self.lblUserName.mas_bottom).offset(KRelative(24));
        make.right.offset(-KRelative(40));
        make.height.offset(KRelative(98));
    }];
    [self.myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-KRelative(38));
    }];
    [self.btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.right.offset(-KRelative(32));
        make.height.offset(KRelative(102));
        make.bottom.equalTo(self.myTextView.mas_top).offset(-KRelative(16));
    }];
}
#pragma mark - lazy
- (UILabel *)lblEmail {
    if (!_lblEmail) {
        _lblEmail = [[UILabel alloc] init];
        _lblEmail.text = @"E-Mail";
        _lblEmail.font = KRelativeBoldFont(30);
        CGSize size = [@"E-Mail" dn_getTextSize:KRelativeBoldFont(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        _lblEmail.textColor = [UIColor colorWithPatternImage:bgImg];
    }
    return _lblEmail;
}
- (UITextField *)textEmail {
    if (!_textEmail) {
        _textEmail = [[UITextField alloc] init];
        _textEmail.keyboardType = UIKeyboardTypeEmailAddress;
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
- (UILabel *)lblPassWord {
    if (!_lblPassWord) {
        _lblPassWord = [[UILabel alloc] init];
        _lblPassWord.text = @"Password";
        _lblPassWord.font = KRelativeBoldFont(30);
        CGSize size = [@"Password" dn_getTextSize:KRelativeBoldFont(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        _lblPassWord.textColor = [UIColor colorWithPatternImage:bgImg];
    }
    return _lblPassWord;
}
- (UITextField *)textPassWord {
    if (!_textPassWord) {
        _textPassWord = [[UITextField alloc] init];
        _textPassWord.layer.cornerRadius = KRelative(10);
        _textEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _textPassWord.textColor = [UIColor whiteColor];
        _textPassWord.backgroundColor = KHexColor(0x373636);
        _textPassWord.placeholder = @"Please enter the password";
        [_textPassWord setValue:KHexColor(0xA3A3A3) forKeyPath:@"placeholderLabel.textColor"];
        _textPassWord.font = KRelativeBoldFont(30);
        [_textPassWord setTextFieldLeftPadding:_textPassWord forWidth:KRelative(20)]; //前面空格10
    }
    return _textPassWord;
}
- (UILabel *)lblUserName {
    if (!_lblUserName) {
        _lblUserName = [[UILabel alloc] init];
        _lblUserName.text = @"Username";
        _lblUserName.font = KRelativeBoldFont(30);
        CGSize size = [@"Username" dn_getTextSize:KRelativeBoldFont(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:0];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        _lblUserName.textColor = [UIColor colorWithPatternImage:bgImg];
    }
    return _lblUserName;
}
- (UITextField *)textUserName {
    if (!_textUserName) {
        _textUserName = [[UITextField alloc] init];
        _textUserName.layer.cornerRadius = KRelative(10);
        _textUserName.textColor = [UIColor whiteColor];
        _textUserName.backgroundColor = KHexColor(0x373636);
        _textUserName.placeholder = @"Please enter the username";
        [_textUserName setValue:KHexColor(0xA3A3A3) forKeyPath:@"placeholderLabel.textColor"];
        _textUserName.font = KRelativeBoldFont(30);
        [_textUserName setTextFieldLeftPadding:_textUserName forWidth:KRelative(20)]; //前面空格10
    }
    return _textUserName;
}
- (ZHAttributeTextView *)myTextView {
    if (!_myTextView) {
        _myTextView = [[ZHAttributeTextView alloc] init];
        _myTextView.numClickEvent = 2;                        // 有几个点击事件(这里只能设为1个或2个)
        _myTextView.oneClickLeftBeginNum = 61;                 // 第一个点击的起始坐标数字是几
        _myTextView.oneTitleLength = 22;                      // 第一个点击的文本长度是几
        _myTextView.twoClickLeftBeginNum = 84;                // 第二个点击的起始坐标数字是几
        _myTextView.twoTitleLength = 14;                      // 第二个点击的文本长度是几
        _myTextView.titleTapColor = KHexColor(0xFFCC59);    // 可点击富文本字体颜色
        // 设置了上面后要在最后设置内容
        _myTextView.content = @"By continuing,I confirm that I have reviewed and agree to\nthe Service Agreement the Privacy Policy.";
        _myTextView.agreeBtnClick = ^(UIButton *btn) {
            btn.selected = !btn.selected;
            if(btn.selected == YES){
                self->_isAgree = YES;
            }else{
                self->_isAgree = NO;
            }
        };
        @ktweakify(self)
        _myTextView.eventblock = ^(NSAttributedString *contentStr) {
            @ktstrongify(self)
            [self routerEventWithName:contentStr.string userInfo:@{}];
        };
        
    }
    return _myTextView;
}
- (UIButton *)btnSignIn {
    if (!_btnSignIn) {
        _btnSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSignIn.layer.cornerRadius = KRelative(14);
        CGSize size = CGSizeMake(KWidth-KRelative(64), KRelative(102));
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        [_btnSignIn setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_btnSignIn setTitle:@"Sign in" forState:UIControlStateNormal];
        [_btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btnSignIn.titleLabel.font = KRelativeBoldFont(36);
        [_btnSignIn addTarget:self action:@selector(onbtnSignInClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSignIn;
}
//sign in
- (void)onbtnSignInClick {
    [self endEditing:YES];
    if (self.textEmail.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter your account number" finishBlock:nil];
        return;
    }
    if (![self.textEmail.text dn_isValidEmail]) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter the correct email address" finishBlock:nil];
        return;
    }
    if (self.textPassWord.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter your passWord" finishBlock:nil];
        return;
    }
    if (self.textUserName.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter your UserName" finishBlock:nil];
        return;
    }
    if (!_isAgree) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please agree to the agreement below" finishBlock:nil];
        return;
    }
    [self routerEventWithName:@"signInAction" userInfo:@{@"email":self.textEmail.text,
                                                         @"passWord":self.textPassWord.text,
                                                         @"userName":self.textUserName.text
                                                       }];
}
@end
