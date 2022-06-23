//
//  WKSignInView.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKSignInView.h"

@interface WKSignInView ()
@property (nonatomic, strong) UILabel *lblEmail;///E-Mail
@property (nonatomic, strong) UITextField *textEmail;
@property (nonatomic, strong) UILabel *lblPassWord;
@property (nonatomic, strong) UITextField *textPassWord;
@property (nonatomic, strong) UIButton *forgetBtn; //Forgot Password
@property (nonatomic, strong) UIButton *btnSignIn;///Sign in

@end

@implementation WKSignInView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.lblEmail];
    [self.containerView addSubview:self.textEmail];
    [self.containerView addSubview:self.lblPassWord];
    [self.containerView addSubview:self.textPassWord];
    [self.containerView addSubview:self.forgetBtn];
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
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRelative(40));
        make.top.equalTo(self.textPassWord.mas_bottom).offset(KRelative(16));
    }];
    [self.btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.right.offset(-KRelative(32));
        make.height.offset(KRelative(102));
        make.bottom.offset(-KRelative(216));
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
        _textEmail.layer.cornerRadius = KRelative(10);
        _textEmail.textColor = [UIColor whiteColor];
        _textEmail.backgroundColor = KHexColor(0x373636);
        _textEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _textEmail.placeholder = @"please input your email";
        [_textEmail setValue:KHexColor(0xA3A3A3) forKeyPath:@"placeholderLabel.textColor"];
        _textEmail.font = KRelativeBoldFont(30);
        _textEmail.text = [[WKUserInforManager sharedInstance] getUserInforUserAcount] ? [[WKUserInforManager sharedInstance] getUserInforUserAcount]:@"";
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
        _textPassWord.textColor = [UIColor whiteColor];
        _textPassWord.backgroundColor = KHexColor(0x373636);
        _textPassWord.placeholder = @"Please enter the password";
        [_textPassWord setValue:KHexColor(0xA3A3A3) forKeyPath:@"placeholderLabel.textColor"];
        _textPassWord.font = KRelativeBoldFont(30);
        _textPassWord.text = [[WKUserInforManager sharedInstance] getUserInforPassword] ? [[WKUserInforManager sharedInstance] getUserInforPassword]:@"";
        [_textPassWord setTextFieldLeftPadding:_textPassWord forWidth:KRelative(20)]; //前面空格10
    }
    return _textPassWord;
}
- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"Forgot Password" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:KHexColor(0x9E9D9D) forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = KRelativeBoldFont(26);
        [_forgetBtn addTarget:self action:@selector(onForgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
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
    if (self.textPassWord.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter your passWord" finishBlock:nil];
        return;
    }
    [[DBManager sharedInstance] createDB];
    Person *person = [[DBManager sharedInstance] getPersonWithName:self.textEmail.text];
    if (![self.textEmail.text isEqualToString:CanLoginAcount] && !person) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please enter the correct account number" finishBlock:nil];
        return;
    }
    if ([self.textEmail.text isEqualToString:CanLoginAcount]) {
        if (![self.textPassWord.text isEqualToString:CanLoginPassWord]) {
            [YPCSVProgress showStatusMessageWithTitle:@"Please enter the correct password" finishBlock:nil];
            return;
        }
    } else {
        if (![self.textPassWord.text isEqualToString:person.password]) {
            [YPCSVProgress showStatusMessageWithTitle:@"Please enter the correct password" finishBlock:nil];
            return;
        }
    }
    if (person) {
        WKUserInfoModel *model = [WKUserInfoModel new];
        model.acount = person.acount;
        model.password = person.password;
        model.sex = person.sex;
        model.age = person.age;
        model.username = person.username;
        model.headData = person.headData;
        model.loginStatus = YES;
        [[WKUserInforManager sharedInstance] updateUserInfor:model];
    } else {
        //存储数据
        WKUserInfoModel *model = [WKUserInfoModel new];
        model.acount = self.textEmail.text;
        model.password = self.textPassWord.text;
        model.sex = UserSex;
        model.username = UserName;
        model.loginStatus = YES;
        [[WKUserInforManager sharedInstance] updateUserInfor:model];
    }
    
    [self routerEventWithName:@"OnSignInclickAction" userInfo:@{@"acount":self.textEmail.text,
                                                                @"passWord":self.textPassWord.text
                                                              }];
}
//Forgot Password
- (void)onForgetBtnClick {
    [self routerEventWithName:@"forgetPassWordAction" userInfo:@{}];
}

@end
