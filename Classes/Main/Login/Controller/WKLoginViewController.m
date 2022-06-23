//
//  WKLoginViewController.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKLoginViewController.h"
#import "WKSignInViewController.h"
#import "WKSignUpViewController.h"

@interface WKLoginViewController ()
@property (nonatomic, strong) UIImageView *imageBg;///背景颜色
@property (nonatomic, strong) UIImageView *titleView;///标题图片
@property (nonatomic, strong) UIButton *btnSignIn;///Sign in
@property (nonatomic, strong) UIButton *btnSignUp;///SignUp

@end

@implementation WKLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarWithAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.titleView];
    [self.containerView addSubview:self.imageBg];
    [self.containerView addSubview:self.btnSignUp];
    [self.containerView addSubview:self.btnSignIn];
}

- (void)createLayout {
    [super createLayout];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    [self.imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.containerView);
    }];
    [self.btnSignUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.right.offset(-KRelative(32));
        make.height.offset(KRelative(102));
        make.bottom.offset(-KRelative(22));
    }];
    [self.btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.right.offset(-KRelative(32));
        make.height.offset(KRelative(102));
        make.bottom.equalTo(self.btnSignUp.mas_top).offset(-KRelative(22));
    }];
}

#pragma mark - lazy
- (UIImageView *)imageBg {
    if (!_imageBg) {
        _imageBg = [[UIImageView alloc] init];
        _imageBg.image = ImageName(@"login_Bg");
    }
    return _imageBg;
}
- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
        _titleView.contentMode = UIViewContentModeCenter;
        _titleView.image = ImageName(@"Woko");
    }
    return _titleView;
}
- (UIButton *)btnSignUp {
    if (!_btnSignUp) {
        _btnSignUp = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSignUp.layer.cornerRadius = KRelative(14);
        CGSize size = CGSizeMake(KWidth-KRelative(64), KRelative(102));
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:size];
        [_btnSignUp setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_btnSignUp setTitle:@"Sign up" forState:UIControlStateNormal];
        [_btnSignUp setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _btnSignUp.titleLabel.font = KRelativeBoldFont(36);
        [_btnSignUp addTarget:self action:@selector(onSignUpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSignUp;
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
- (void)onSignUpClick {
    WKSignUpViewController *signUp = [[WKSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUp animated:YES];
}

- (void)onbtnSignInClick {
    WKSignInViewController *signIn = [[WKSignInViewController alloc] init];
    [self.navigationController pushViewController:signIn animated:YES];
}

@end
