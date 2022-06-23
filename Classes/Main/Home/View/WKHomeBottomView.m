//
//  WKHomeBottomView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKHomeBottomView.h"

@interface WKHomeBottomView ()
@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnVolice;
@property (nonatomic, strong) UIButton *btnMenu;

@end

@implementation WKHomeBottomView

- (void)createUI {
    [super createUI];
    self.containerView.backgroundColor = KHexColor(0x373636);
    [self.containerView addSubview:self.btnLoad];
    [self.containerView addSubview:self.btnVolice];
    [self.containerView addSubview:self.btnMenu];
}

- (void)createLayout {
    [super createLayout];
    [self.btnLoad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(self.btnVolice);
    }];
    [self.btnVolice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnLoad.mas_right);
        make.top.bottom.offset(0);
        make.width.equalTo(self.btnMenu);
    }];
    [self.btnMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.width.equalTo(self.btnLoad);
        make.left.equalTo(self.btnVolice.mas_right);
    }];
}
#pragma mark - lazy
- (UIButton *)btnLoad {
    if (!_btnLoad) {
        _btnLoad = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLoad.tag = 200;
        [_btnLoad setImage:ImageName(@"btn_load") forState:UIControlStateNormal];
        [_btnLoad addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLoad;
}
- (UIButton *)btnVolice {
    if (!_btnVolice) {
        _btnVolice = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnVolice.tag = 201;
        [_btnVolice setImage:ImageName(@"btn_volice") forState:UIControlStateNormal];
        [_btnVolice addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnVolice;
}
- (UIButton *)btnMenu {
    if (!_btnMenu) {
        _btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMenu.tag = 202;
        [_btnMenu setImage:ImageName(@"btn_menu") forState:UIControlStateNormal];
        [_btnMenu addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMenu;
}

- (void)onClick:(UIButton *)sender {
    NSDictionary  *dic = @{@"tag":@(sender.tag-200)};
    [self routerEventWithName:@"botomBlankPages" userInfo:dic];
}

@end
