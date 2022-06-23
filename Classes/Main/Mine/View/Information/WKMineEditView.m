//
//  WKMineEditView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKMineEditView.h"
#import "WKMineTopView.h"
#import "WKPersonInforView.h"
//#import "WKBottomView.h"

@interface WKMineEditView ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *sc_contentView;
@property (nonatomic, strong) WKMineTopView *topView;
@property (nonatomic, strong) UIButton *imageAvater;
@property (nonatomic, strong) WKPersonInforView *personView;

@end

@implementation WKMineEditView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:self.scrollView];
    [self.scrollView addSubview:self.sc_contentView];
    [self.sc_contentView addSubview:self.imageAvater];
    [self.sc_contentView addSubview:self.personView];
    [self.sc_contentView addSubview:self.bottomView];
}

- (void)createLayout {
    [super createLayout];
    [self.topView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.bottom.right.offset(0);
    }];
    [self.sc_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    [self.imageAvater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.offset(KRelative(60));
        make.size.sizeOffset(CGSizeMake(KRelative(278), KRelative(278)));
    }];
    [self.personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(36));
        make.top.equalTo(self.imageAvater.mas_bottom).offset(KRelative(32));
        make.right.offset(-KRelative(36));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(32));
        make.top.equalTo(self.personView.mas_bottom).offset(20);
        make.right.offset(KRelative(-32));
    }];
    [self.sc_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(KRelative(100));
    }];
    
    // 让布局立即生效
    [self layoutIfNeeded];
    
    // 设置contentSize
    self.scrollView.contentSize = CGSizeMake(KWidth, self.sc_contentView.frame.size.height);
}
- (void)changeUserInforSex:(NSString *)sex {
    [self.personView changeUserInforSex:sex];
}

- (void)changeUserInforAge:(NSString *)age {
    [self.personView changeUserInforAge:age];
}
- (void)changeUserAvatar:(UIImage *)image {
    [self.imageAvater setBackgroundImage:image forState:UIControlStateNormal];
}
#pragma mark - lazy
- (WKMineTopView *)topView {
    if (!_topView) {
        _topView = [[WKMineTopView alloc] init];
        [_topView showRightEditBtn:YES];
    }
    return _topView;
}

- (UIButton *)imageAvater {
    if (!_imageAvater) {
        _imageAvater = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageAvater.contentMode = UIViewContentModeScaleAspectFit;
        if ([[WKUserInforManager sharedInstance] getUserInforAvater]) {
            NSData *imageData = [[NSData alloc] initWithBase64Encoding:[[WKUserInforManager sharedInstance] getUserInforAvater]];
            UIImage *image = [UIImage imageWithData:imageData];
            [_imageAvater setBackgroundImage:image forState:UIControlStateNormal];
        } else {
            [_imageAvater setBackgroundImage:ImageName(@"galGadot") forState:UIControlStateNormal];
        }
        [_imageAvater addTarget:self action:@selector(onButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _imageAvater.clipsToBounds = YES;
        _imageAvater.layer.cornerRadius = KRelative(139);
        _imageAvater.layer.borderWidth = KRelative(6);
        _imageAvater.layer.borderColor = MCColor(150, 150, 150, 1).CGColor;
    }
    return _imageAvater;
}
- (void)onButtonClick {
    [self routerEventWithName:@"ChooseImage" userInfo:@{}];
}
- (WKPersonInforView *)personView {
    if (!_personView) {
        _personView = [[WKPersonInforView alloc] init];
        _personView.layer.cornerRadius = KRelative(10);
        _personView.clipsToBounds = YES;
    }
    return _personView;
}
- (WKBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WKBottomView alloc] init];
        _bottomView.layer.cornerRadius = KRelative(10);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}
- (UIView *)sc_contentView {
    if (!_sc_contentView) {
        _sc_contentView = [UIView new];
    }
    return _sc_contentView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.bounces = YES;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _scrollView;
}

@end
