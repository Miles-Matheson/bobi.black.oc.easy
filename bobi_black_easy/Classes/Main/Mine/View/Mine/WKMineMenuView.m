//
//  WKMineMenuView.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKMineMenuView.h"

@interface WKMineMenuView ()

@end

@implementation WKMineMenuView

- (void)createUI {
    [super createUI];
    [self createButton];
}
- (void)createLayout {
    [super createLayout];
}

#pragma mark - create btn
- (void)createButton {
    NSArray *arrayTitleImage = @[@"btn_phone",@"Contact us",@"btn_us",@"About us",@"btn_delete",@"Delete account",@"btn_loginout",@"Sign out"];
    double itemWith = (KWidth-KRelative(120))/2;
    for (int i = 0; i < 4; i ++) {
        UIButton *btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
        btnImage.backgroundColor = KHexColor(0x373636);
        btnImage.layer.cornerRadius = KRelative(22);
        [btnImage setImage:ImageName(arrayTitleImage[i*2]) forState:UIControlStateNormal];
        [btnImage setTitle:arrayTitleImage[i*2+1] forState:UIControlStateNormal];
        btnImage.titleLabel.font = KRelativeBoldFont(32);
        [btnImage setTitleColor:KHexColor(0xF1C87B) forState:UIControlStateNormal];
        btnImage.tag = i + 1;
        [self.containerView addSubview:btnImage];
        [btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(itemWith*(i%2)+(i%2)*KRelative(40)+KRelative(40));
            make.top.offset(itemWith*(i/2));
            make.height.offset(KRelative(260));
            make.width.offset(itemWith);
            if (i > 2) {
                make.bottom.offset(0);
            }
        }];
        [btnImage addTarget:self action:@selector(onMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnImage layoutButtonWithEdgeInsetsStyle:WPButtonEdgeInsetsStyleTop imageTitleSpace:KRelative(22)];
    }
}
- (void)onMenuClick:(UIButton *)btn {
    [self routerEventWithName:[NSString stringWithFormat:@"menuBtnClick%ld",btn.tag] userInfo:@{}];
}

@end
