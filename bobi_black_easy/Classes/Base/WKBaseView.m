//
//  WKBaseView.m
//  WOKO
//
//  Created by admin on 2022/4/8.
//

#import "WKBaseView.h"
#import "Masonry.h"

@implementation WKBaseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self createUI];
    [self createLayout];
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerView];
}

- (void)createLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark --lazy
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}
@end
