//
//  ZHAttributeTextView.m
//  ZHAttributeTextView
//
//  Created by ZH on 2018/9/18.
//  Copyright © 2018年 张豪. All rights reserved.
//

#import "ZHAttributeTextView.h"
#import "BobiEasyHeader.h"

@implementation ZHAttributeTextView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 左侧是否选中按钮
        self.leftAgreeBtn = [UIButton buttonWithType:0];
        [self.leftAgreeBtn addTarget:self action:@selector(leftAgreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftAgreeBtn setImage:[UIImage mm_xcassetImageNamed:@"btn_nor"] forState:UIControlStateNormal];
        [self.leftAgreeBtn setImage:[UIImage mm_xcassetImageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [self addSubview:self.leftAgreeBtn];
        [self.leftAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KRelative(42));
            make.top.offset(KRelative(10));
        }];
        // 右侧的富文本
        _myTextView = [[UITextView alloc] init];
        _myTextView.backgroundColor = KHexColor(0x221E1E);
        _myTextView.delegate = self;
        _myTextView.editable = NO;        // 禁止输入，否则会弹出输入键盘
        _myTextView.scrollEnabled = NO;   // 可选的，视具体情况而定
        _myTextView.font = KRelativeBoldFont(22);
        _myTextView.textColor = [UIColor whiteColor];
        [self addSubview:_myTextView];
        [_myTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftAgreeBtn.mas_right).offset(KRelative(10));
            make.top.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
        }];
    }
    return self;
    
}
- (void)setTitleTapColor:(UIColor *)titleTapColor {
    // 设置可点击富文本字体颜色
    _myTextView.linkTextAttributes = @{NSForegroundColorAttributeName:titleTapColor};
}
// 字符串内容
- (void)setContent:(NSString *)content{
    _content = content;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:content];
    [attStr addAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} range:NSMakeRange(0, content.length)];
    // 如果有三个点击事件在下面添加
    if (self.numClickEvent == 1) {
        [attStr addAttribute:NSLinkAttributeName value:@"click://" range:NSMakeRange(self.oneClickLeftBeginNum, self.oneTitleLength)];
        [attStr addAttributes:@{NSFontAttributeName: KRelativeBoldFont(22)} range:NSMakeRange(self.oneClickLeftBeginNum, self.oneTitleLength)];
        
    }else if (self.numClickEvent == 2){
        
        [attStr addAttribute:NSLinkAttributeName value:@"click://" range:NSMakeRange(self.oneClickLeftBeginNum, self.oneTitleLength)];
        [attStr addAttribute:NSLinkAttributeName value:@"click1://" range:NSMakeRange(self.twoClickLeftBeginNum, self.twoTitleLength)];
        [attStr addAttributes:@{NSFontAttributeName: KRelativeBoldFont(22)} range:NSMakeRange(self.oneClickLeftBeginNum, self.oneTitleLength)];
        
        [attStr addAttributes:@{NSFontAttributeName: KRelativeBoldFont(22)} range:NSMakeRange(self.twoClickLeftBeginNum, self.twoTitleLength)];
    }
    _myTextView.attributedText = attStr;
    
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    if ([[URL scheme] isEqualToString:@"click"]) {
        NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];
        if (self.eventblock) {
            self.eventblock(abStr);
        }
        return NO;
    }
    if ([[URL scheme] isEqualToString:@"click1"]) {
        NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];
        if (self.eventblock) {
            self.eventblock(abStr);
        }
        return NO;
    }
    return YES;
}
// 按钮点击事件
- (void)leftAgreeBtnClick:(UIButton *)sender{
    if (self.agreeBtnClick) {
        self.agreeBtnClick(sender);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
