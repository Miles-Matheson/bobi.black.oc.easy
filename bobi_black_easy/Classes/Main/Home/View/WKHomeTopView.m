//
//  WKHomeTopView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKHomeTopView.h"

@interface WKHomeTopView ()
@property (nonatomic, strong) UIButton *btnPerson;
@property (nonatomic, strong) UIImageView *imageTitle;
@property (nonatomic, strong) UIButton *btnMessage;

@end

@implementation WKHomeTopView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.btnPerson];
    [self.containerView addSubview:self.imageTitle];
    [self.containerView addSubview:self.btnMessage];
}

- (void)createLayout {
    [super createLayout];
    [self.btnPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.centerY.equalTo(self.containerView);
    }];
    [self.imageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.containerView);
    }];
    [self.btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRelative(40));
        make.centerY.equalTo(self.containerView);
    }];
}

#pragma mark - lazy
- (UIButton *)btnPerson {
    if (!_btnPerson) {
        _btnPerson = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPerson setImage:ImageName(@"btn_person") forState:UIControlStateNormal];
        [_btnPerson addTarget:self action:@selector(onClickPerson) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPerson;
}
- (UIImageView *)imageTitle {
    if (!_imageTitle) {
        _imageTitle = [[UIImageView alloc] init];
        _imageTitle.image = ImageName(@"Woko");
    }
    return _imageTitle;
}
- (UIButton *)btnMessage {
    if (!_btnMessage) {
        _btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMessage setImage:ImageName(@"btn_message") forState:UIControlStateNormal];
        [_btnMessage addTarget:self action:@selector(onClickMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMessage;
}
- (void)onClickPerson {
    [self routerEventWithName:@"OnPersonBtnClick" userInfo:@{}];
}
- (void)onClickMessage {
    [self routerEventWithName:@"BlankPages" userInfo:@{}];
}

@end
