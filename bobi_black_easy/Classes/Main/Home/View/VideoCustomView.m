//
//  VideoCustomView.m
//  Woko
//
//  Created by 王树银 on 2022/4/19.
//

#import "VideoCustomView.h"

@interface VideoCustomView ()

@property(nonatomic,strong)UILabel     *contenLab;

@property(nonatomic,copy)NSString      *name;

@property(nonatomic,strong)UIButton   *btn;

@end

@implementation VideoCustomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        [self createTheSubViews];
    }
    return self;
}

-(void)createTheSubViews{
    [self addSubview:self.titleLab];
    [self addSubview:self.contenLab];
    [self addSubview:self.btn];
    [self.contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(38);
        make.right.mas_equalTo(self.mas_right).offset(-38);
        make.top.mas_equalTo(self.mas_top).offset(95);
        make.height.equalTo(@50);
    }];
    self.btn.frame = CGRectMake(45, 226, self.frame.size.width - 90, 50);
    [self.btn.layer insertSublayer:[UIColor setGradualChangingColor:self.btn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.5,0.0) AndEndTheEndPoint:CGPointMake(1,1)]atIndex:0];
    [self.btn bringSubviewToFront:self.btn.titleLabel];

}

-(WsyStrokeLab *)titleLab{
    if (!_titleLab) {
        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 55, 24, 110, 30)];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.outLineWidth = 0.0f;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
//        _titleLab.text = @"Send voice";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(UILabel *)contenLab{
    if (!_contenLab) {
        _contenLab = [[UILabel alloc]init];
        _contenLab.textColor = [UIColor whiteColor];
        _contenLab.font = [UIFont boldSystemFontOfSize:18];
        _contenLab.layer.masksToBounds = true;
        _contenLab.numberOfLines = 0;
        _contenLab.textAlignment = NSTextAlignmentCenter;
        _contenLab.text = [NSString stringWithFormat:@"Click listen %@ voice",_name];
    }
    return _contenLab;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"OK" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_btn addTarget:self action:@selector(videoBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.masksToBounds = true;
        _btn.layer.cornerRadius = 5.0f;
    }
    return _btn;
}

-(void)videoBtnAction{
    if (_block) {
        _block();
    }
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _name = [dic objectForKey:@"name"];
    self.titleLab.text = @"Tips";
    self.contenLab.text = [NSString stringWithFormat:@"Sorry, %@ is not online and can't start a video chat.",_name];
}

@end
