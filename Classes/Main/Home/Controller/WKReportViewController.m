//
//  WKReportViewController.m
//  Woko
//
//  Created by 王树银 on 2022/4/20.
//

#import "WKReportViewController.h"
#import "WsyStrokeLab.h"
#import "wsyShosePicView.h"
#import "WsyShoseProx.h"
@interface WKReportViewController ()<wsyShoseProtocol,UITextViewDelegate>
@property(nonatomic,strong)UIView   *btnView;

@property(nonatomic,strong)UIImageView   *view_1;
@property(nonatomic,strong)UIImageView   *view_2;
@property(nonatomic,strong)UIImageView   *view_3;
@property(nonatomic,strong)UIImageView   *view_4;

//@property(nonatomic,strong)UIButton  *btn_1;
//@property(nonatomic,strong)UIButton *btn_2;
//@property(nonatomic,strong)UIButton  *btn_3;
//@property(nonatomic,strong)UIButton *btn_4;
@property(nonatomic,strong)UITextView   *textV;
@property(nonatomic,strong)UILabel  *maxTitleLab;
@property(nonatomic,strong)wsyShosePicView  *shoseView;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)UIButton   *senderBtn;
@property(nonatomic,strong)WsyShoseProx  *shoseProx;
@property(nonatomic,strong)WsyStrokeLab   *titleLab;
@property(nonatomic,assign)NSInteger  wordsNum;
@property(nonatomic,strong)UIScrollView  *scrollV;

@end

@implementation WKReportViewController

-(UIView *)btnView{
    if (!_btnView) {
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, KWidth, 250)];
        _btnView.backgroundColor = [UIColor clearColor];
    }
    return _btnView;
}

-(UILabel *)maxTitleLab{
    if (!_maxTitleLab) {
        _maxTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(KWidth - 135, 220 - 31, 80, 21)];
        _maxTitleLab.textColor = [UIColor colorWithHexString:@"#ECC478"];
        _maxTitleLab.text = @"0/500";
        _maxTitleLab.textAlignment = NSTextAlignmentRight;
        _maxTitleLab.font = [UIFont systemFontOfSize:15];
    }
    return _maxTitleLab;
}

-(WsyStrokeLab *)titleLab{
    if (!_titleLab) {
        _titleLab = [[WsyStrokeLab alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.outLineWidth = 0.0f;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
        _titleLab.text = @"Report";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        _scrollV.contentSize = CGSizeMake(KWidth, KHeight + 120);
//        _scrollV.backgroundColor = KHexColor(0x221E1E);
        _scrollV.backgroundColor = [UIColor clearColor];
    }
    return _scrollV;
}

-(UIImageView *)view_1{
    if (!_view_1) {
        _view_1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 100, 45)];
        _view_1.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 85, 20)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.text = @"Scammer";
        _view_1.contentMode = UIViewContentModeScaleAspectFill;
        _view_1.userInteractionEnabled = true;
        _view_1.layer.masksToBounds = true;
        _view_1.layer.cornerRadius = 5.0f;
        _view_1.tag = 300;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickAction:)];
        [_view_1 addSubview:titleLab];
        [_view_1 addGestureRecognizer:tap];
    }
    return _view_1;
}

-(UIImageView *)view_2{
    if (!_view_2) {
        _view_2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 155, 45)];
        _view_2.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 125, 20)];
        titleLab.textColor = [UIColor whiteColor];
        _view_2.contentMode = UIViewContentModeScaleAspectFit;
        titleLab.text = @"Ssending spam";
        _view_2.layer.masksToBounds = true;
        _view_2.layer.cornerRadius = 5.0f;
        _view_2.tag = 301;
        _view_2.userInteractionEnabled = true;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickAction:)];
        [_view_2 addSubview:titleLab];
        [_view_2 addGestureRecognizer:tap];
    }
    return _view_2;
}

-(UIImageView *)view_3{
    if (!_view_3) {
        _view_3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 130, 155, 45)];
        _view_3.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        _view_3.contentMode = UIViewContentModeScaleAspectFit;
        UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 125, 20)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.text = @"Rude or abusive";
        _view_3.layer.masksToBounds = true;
        _view_3.layer.cornerRadius = 5.0f;
        _view_3.tag = 302;
        _view_3.userInteractionEnabled = true;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickAction:)];
        [_view_3 addSubview:titleLab];
        [_view_3 addGestureRecognizer:tap];
    }
    return _view_3;
}

-(UIImageView *)view_4{
    if (!_view_4) {
        //CGRectMake(20, 190, 200, 45)
        _view_4 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 190, 200, 45)];
        _view_4.backgroundColor = [UIColor colorWithHexString:@"#3C3C3C"];
        _view_4.contentMode = UIViewContentModeScaleAspectFit;
        UILabel  *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 170, 20)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.text = @"inappropriate content";
        _view_4.layer.masksToBounds = true;
        _view_4.layer.cornerRadius = 5.0f;
        _view_4.tag = 303;
        _view_4.userInteractionEnabled = true;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickAction:)];
        [_view_4 addSubview:titleLab];
        [_view_4 addGestureRecognizer:tap];
    }
    return _view_4;
}

-(UITextView *)textV{
    if (!_textV) {
        _textV = [[UITextView alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.btnView.frame) + 40 , KWidth - 40, 220)];
        _textV.backgroundColor =  [UIColor colorWithHexString:@"#3C3C3C"];
        _textV.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        _textV.font = [UIFont systemFontOfSize:15];
        _textV.text = @"Describe your problem...";
        _textV.delegate = self;
        _textV.layer.masksToBounds = true;
        _textV.layer.cornerRadius = 5.0f;
    }
    return _textV;
}

-(UIButton *)senderBtn{
    if (!_senderBtn) {
        _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_senderBtn setTitle:@"Submit" forState:UIControlStateNormal];
        _senderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _senderBtn.frame = CGRectMake(35,CGRectGetMaxY(self.shoseView.frame)+ 50, KWidth - 70, 50);
        _senderBtn.layer.masksToBounds = true;
        _senderBtn.layer.cornerRadius = 5.0f;
        [_senderBtn addTarget:self selector:@selector(senderBtnAction)];
    }
    return _senderBtn;
}

-(wsyShosePicView *)shoseView{
    if (!_shoseView) {
        _shoseView = [[wsyShosePicView alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.textV.frame)+ 20 , KWidth - 40, 140)];
        //[UIColor colorWithHexString:@"#3C3C3C"];
        _shoseView.backgroundColor = KHexColor(0x3C3C3C);
        _shoseView.layer.masksToBounds = true;
        _shoseView.layer.cornerRadius = 5.0f;
    }
    return _shoseView;
}

-(NSMutableArray *)btnArr{
    if (!_btnArr ) {
        _btnArr = [NSMutableArray arrayWithArray:@[self.view_1,self.view_2,self.view_3,self.view_4]];
    }
    return _btnArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showNavigationBar];
    self.navigationItem.titleView = self.titleLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)createUI{
    [super createUI];
    _wordsNum = 0;
    self.shoseProx =[[WsyShoseProx alloc]init];
    self.shoseProx.maxNum = 3;
    self.shoseProx.picSize = CGSizeMake(100, 100);
    self.shoseProx.delegate = self;
    [self.scrollV addSubview:self.btnView];
    [self.btnView addSubview:self.view_1];
    [self.btnView addSubview:self.view_2];
    [self.btnView addSubview:self.view_3];
    [self.btnView addSubview:self.view_4];
    [self.containerView addSubview:self.scrollV];
    [self.shoseView wsySetShoseProx:self.shoseProx];
    [self.scrollV addSubview:self.textV];
    [self.textV addSubview:self.maxTitleLab];
    [self.textV bringSubviewToFront:self.maxTitleLab];
    [self.scrollV addSubview:self.shoseView];
    [self.scrollV addSubview:self.senderBtn];
    [self.senderBtn.layer insertSublayer:[UIColor setGradualChangingColor:self.senderBtn.bounds fromColor:@"#FDCA38" toColor:@"#FF7D3A" BeginWithTheStartPoint:CGPointMake(0.0,0.0) AndEndTheEndPoint:CGPointMake(1,1)]atIndex:0];

}


-(void)btnClickAction:(id)sender{
    UITapGestureRecognizer  *tap = (UITapGestureRecognizer*)sender;
    UIImageView  *senderV = (UIImageView *)tap.view;
    for (UIImageView  *imageV in self.btnArr) {
        if (imageV.tag == senderV.tag) {
            UIImage *bgImg = [UIImage gradientColorImageFromColors:@[KHexColor(0xFDCA38),KHexColor(0xFF7D3A)] gradientType:GradientTypeTopToBottom imgSize:imageV.frame.size];
            imageV.image = bgImg;
        }else{
            imageV.image = nil;
        }
    }
}

-(void)senderBtnAction{
    if (self.textV.text.length == 0 || [self.textV.text isEqualToString:@"Describe your problem..."]) {
        [YPCSVProgress showStatusMessageWithTitle:@"Please input content!" finishBlock:nil];
        [self.textV isFirstResponder];
        return;
    }else{
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showStatusMessageWithTitle:@"Submitted successfully! " finishBlock:^{
                [self.navigationController popViewControllerAnimated:true];
            }];
        }];
    }
}

-(void)openThePicRouterWithIndexPath:(NSIndexPath *)indexPath withBlock:(void (^)(void))block{
    CBImagePicker *picker = [CBImagePicker shared];
    [picker startWithVC:self];
    [picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
        if (!error) {
            [self.shoseProx dealWithThePicWithIndexPath:indexPath AndTheImage:image];
            if (block) {
                block();
            }
        } else {
            NSLog(@"error.description = %@",error.userInfo[@"description"]);
        }
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Describe your problem..."]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Describe your problem..."] || textView.text.length == 0) {
        textView.text = @"Describe your problem...";
        textView.textColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([textView.text isEqualToString:@"Describe your problem..."]) {
        _wordsNum = 0;
    }else{
        _wordsNum = textView.text.length + text.length;
    }
    if (_wordsNum > 500) {
        [YPCSVProgress showStatusMessageWithTitle:@"enter be limited because the words  is Max" finishBlock:nil];
        return false;
    }
    self.maxTitleLab.text = [NSString stringWithFormat:@"%ld/500",_wordsNum];
    return true;
}

@end
