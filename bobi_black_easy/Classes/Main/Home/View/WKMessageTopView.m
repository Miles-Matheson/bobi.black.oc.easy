//
//  WKMessageTopView.m
//  Woko
//
//  Created by 王树银 on 2022/6/23.
//

#import "WKMessageTopView.h"

@implementation WKMessageTopView

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.btnBack];
    [self.containerView addSubview:self.titleLab];
}

-(void)createLayout{
    [super createLayout];
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KRelative(40));
        make.centerY.equalTo(self.containerView);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.centerY.mas_equalTo(self.containerView);
    }];
    
    
}

-(WsyStrokeLab *)titleLab{
    if (!_titleLab) {
        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(0, 0, 7, 30)];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.outLineWidth = 0.0f;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
        _titleLab.text = @"Message";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIButton *)btnBack {
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBack setImage:ImageName(@"back") forState:UIControlStateNormal];
//        [_btnBack addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}
- (void)onClickBack {
    [self routerEventWithName:@"MessageBackAction" userInfo:@{}];
}
@end
