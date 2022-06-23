//
//  WKMessageViewController.m
//  Woko
//
//  Created by 王树银 on 2022/4/26.
//

#import "WKMessageViewController.h"
#import "WsyStrokeLab.h"
#import "WKMessageTopView.h"
#import "UIColor+CHRegex.h"
#import "BobiEasyHeader.h"
@interface WKMessageViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView   *textV;
@property(nonatomic,strong)UIButton  *sendBtn;
@property(nonatomic,strong)WsyStrokeLab   *titleLab;
@property(nonatomic,strong)WKMessageTopView *topView;
@end

@implementation WKMessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar
//    [self showNavigationBar];
    [self hideNavigationBarWithAnimated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleLab;
   
}

-(void)createUI{
    [super createUI];
    [self.containerView addSubview:self.textV];
    [self.containerView addSubview:self.sendBtn];
    [self.containerView addSubview:self.topView];
}

- (void)createLayout {
    [super createLayout];
    [self.topView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    self.sendBtn.frame = CGRectMake(15, CGRectGetMaxY(self.textV.frame)+ 150, self.view.frame.size.width - 30, 50);
    [self.sendBtn.layer addSublayer:[UIColor setGradualChangingColor:self.sendBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]];

}
//-(WsyStrokeLab *)titleLab{
//    if (!_titleLab) {
//        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
//        _titleLab.font = [UIFont boldSystemFontOfSize:17];
//        _titleLab.outLineWidth = 0.0f;
//        _titleLab.backgroundColor = [UIColor clearColor];
//        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
//        _titleLab.text = @"Message";
//        _titleLab.textAlignment = NSTextAlignmentCenter;
//    }
//    return _titleLab;
//}

-(WKMessageTopView *)topView{
    if (!_topView) {
        _topView = [[WKMessageTopView alloc]init];
        [_topView.btnBack addTarget:self selector:@selector(onClickBack)];
    }
    return _topView;
}

- (void)onClickBack {
    [self routerEventWithName:@"MessagesBackAction" userInfo:@{}];
}


-(UITextView *)textV{
    if (!_textV) {
        _textV = [[UITextView alloc]initWithFrame:CGRectMake(15, 64, self.view.frame.size.width - 30, 220)];
        _textV.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        _textV.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        _textV.font = [UIFont boldSystemFontOfSize:14];
        _textV.layer.masksToBounds = true;
        _textV.layer.cornerRadius = 5.0f;
        _textV.delegate = self;
        _textV.text = @"Say ...";
    }
    return _textV;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"Send" forState:UIControlStateNormal];
        _sendBtn.layer.masksToBounds = true;
        _sendBtn.layer.cornerRadius = 5.0f;
        [_sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

-(void)sendBtnAction{
    if ([self.textV.text isEqualToString:@"Say ..."] || self.textV.text.length == 0) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please input content!" finishBlock:^{
        }];
        return;
    }else{
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showStatusMessageWithTitle:@"success." finishBlock:^{
                [self.navigationController popViewControllerAnimated:false];
            }];
        }];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Say ..."]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0 ) {
        textView.text = @"Say ...";
        textView.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
}
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"MessagesBackAction"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)backToPrevious{
    [self popToHomeViewController];
//    [self.navigationController popViewControllerAnimated:false];
}
@end
