//
//  WKNoMessageController.m
//  Woko
//
//  Created by 王树银 on 2022/5/16.
//

#import "WKNoMessageController.h"
//#import "WsyStrokeLab.h"
#import "WsyEmptyView.h"
#import "WKMessageTopView.h"
@interface WKNoMessageController ()

@property(nonatomic,strong)UILabel   *titleLab;
@property(nonatomic,strong)WsyEmptyView  *emptyView;
@property(nonatomic,strong)WKMessageTopView *topView;

@end

@implementation WKNoMessageController

-(WsyEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[WsyEmptyView alloc]initWithFrame:CGRectMake(0, 0, KWidth - 100, 264)];
        _emptyView.emptyView.image = [UIImage mm_xcassetImageNamed:@"wsy_noMessage"];
        _emptyView.contentLab.text = @"No one has sent you a message";
        _emptyView.btn.hidden = true;
    }
    return _emptyView;
}

//-(UILabel *)titleLab{
//    if (!_titleLab) {
//        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
//        _titleLab.font = [UIFont boldSystemFontOfSize:17];
////        _titleLab.outLineWidth = 0.0f;
//        _titleLab.backgroundColor = [UIColor clearColor];
//        _titleLab.textColor = [UIColor whiteColor];
////        _titleLab.outLinetextColor = [UIColor colorWithHexString:@"#FDCA38"];
//        _titleLab.text = @"Message";
//        _titleLab.textAlignment = NSTextAlignmentCenter;
//    }
//    return _titleLab;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideNavigationBarWithAnimated:NO];
//    self.navigationItem.titleView = self.titleLab;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#221E1E"];
    [self.view addSubview:self.emptyView];
}

-(void)createUI{
    [super createUI];
    [self.containerView addSubview:self.topView];
    [self.containerView addSubview:self.emptyView];
}

-(void)createLayout{
    [super createLayout];
    [self.topView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    self.emptyView.frame = CGRectMake(50, 164, KWidth - 100, 264);
    [self.view bringSubviewToFront:self.emptyView];
}

-(WKMessageTopView *)topView{
    if (!_topView) {
        _topView = [[WKMessageTopView alloc]init];
        [_topView.btnBack addTarget:self selector:@selector(onClickBack)];
    }
    return _topView;
}
- (void)onClickBack {
    [self routerEventWithName:@"NOMessageBackAction" userInfo:@{}];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"NOMessageBackAction"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
