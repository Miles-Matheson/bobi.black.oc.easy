//
//  WKMineView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKMineView.h"
#import "WKMineTopView.h"
#import "WKMineMenuView.h"

@interface WKMineView ()
@property (nonatomic, strong) WKMineTopView *topView;
@property (nonatomic, strong) UIImageView *imageAvater;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) WKMineMenuView *menuView;

@end

@implementation WKMineView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:self.imageAvater];
    [self.containerView addSubview:self.lblName];
    [self.containerView addSubview:self.menuView];
}

- (void)createLayout {
    [super createLayout];
    [self.topView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    [self.imageAvater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.topView.mas_bottom).offset(KRelative(60));
        make.size.sizeOffset(CGSizeMake(KRelative(278), KRelative(278)));
    }];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.imageAvater.mas_bottom).offset(KRelative(20));
    }];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.lblName.mas_bottom).offset(KRelative(116));
    }];
}
- (void)updateHeadImageAction {
    if ([[WKUserInforManager sharedInstance] getUserInforAvater]) {
        NSData *imageData = [[NSData alloc] initWithBase64Encoding:[[WKUserInforManager sharedInstance] getUserInforAvater]];
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageAvater.image = image;
    } else {
        self.imageAvater.image = ImageName(@"galGadot");
    }
}
#pragma mark -lazy
- (WKMineTopView *)topView {
    if (!_topView) {
        _topView = [[WKMineTopView alloc] init];
    }
    return _topView;
}
- (UIImageView *)imageAvater {
    if (!_imageAvater) {
        _imageAvater = [[UIImageView alloc] init];
        if ([[WKUserInforManager sharedInstance] getUserInforAvater]) {
            NSData *imageData = [[NSData alloc] initWithBase64Encoding:[[WKUserInforManager sharedInstance] getUserInforAvater]];
            UIImage *image = [UIImage imageWithData:imageData];
            _imageAvater.image = image;
        } else {
            _imageAvater.image = ImageName(@"galGadot");
        }
        _imageAvater.clipsToBounds = YES;
        _imageAvater.layer.cornerRadius = KRelative(139);
        _imageAvater.layer.borderWidth = KRelative(6);
        _imageAvater.layer.borderColor = MCColor(150, 150, 150, 1).CGColor;
    }
    return _imageAvater;
}
- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.text = [[WKUserInforManager sharedInstance] getUserInforUserName] ? [[WKUserInforManager sharedInstance] getUserInforUserName]:@"UserName";
        _lblName.font = KRelativeBoldFont(34);
        _lblName.textColor = UIColor.whiteColor;
    }
    return _lblName;
}
- (WKMineMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[WKMineMenuView alloc] init];
    }
    return _menuView;
}

@end
