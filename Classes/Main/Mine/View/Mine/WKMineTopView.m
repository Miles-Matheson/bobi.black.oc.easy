//
//  WKMineTopView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKMineTopView.h"

@interface WKMineTopView ()
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UIButton *btnEdit;

@end

@implementation WKMineTopView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.btnBack];
    [self.containerView addSubview:self.btnEdit];
}

- (void)createLayout {
    [super createLayout];
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.centerY.equalTo(self.containerView);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    [self.btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-KRelative(40));
        make.centerY.equalTo(self.containerView);
    }];
}

- (void)showRightEditBtn:(BOOL)isShow {
    self.btnEdit.hidden = isShow;
}

#pragma mark -lazy
- (UIButton *)btnBack {
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBack setImage:ImageName(@"back") forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

- (UIButton *)btnEdit {
    if (!_btnEdit) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit setImage:ImageName(@"btn_edit") forState:UIControlStateNormal];
        [_btnEdit addTarget:self action:@selector(onClickEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEdit;
}
- (void)onClickBack {
    [self routerEventWithName:@"MineBackAction" userInfo:@{}];
}
- (void)onClickEdit {
    [self routerEventWithName:@"MineEditAction" userInfo:@{}];
}


@end
