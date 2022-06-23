//
//  WKUploadImageViewController.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKUploadImageViewController.h"
#import "WKUpLoadImageView.h"

@interface WKUploadImageViewController ()
@property (nonatomic, strong) WKUpLoadImageView *imageView;

@end

@implementation WKUploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Welcome"];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.imageView];
}

- (void)createLayout {
    [super createLayout];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"ChooseImageAction"]) {
        [self startPicker];
    } else if ([eventName isEqualToString:@"OnContinueAction"]) {
        //存储数据
        WKUserInfoModel *model = [WKUserInfoModel new];
        model.acount = self.email;
        model.password = self.passWord;
        model.username = self.userName;
        model.loginStatus = YES;
        NSData *data = UIImageJPEGRepresentation(userInfo[@"image"] , 0.1);
        // Data解码并且转字符串
        model.headData = [data base64Encoding];
        //存储数据
        Person *person = [Person new];
        person.username = self.userName;
        person.password = self.passWord;
        person.acount = self.email;
        person.sex = @"add";
        person.age = @"add";
        person.headData = [data base64Encoding];
        
        [[DBManager sharedInstance] createDB];
        // 添加
        [[DBManager sharedInstance] addPerson:person completion:^(BOOL success) {
            NSLog(@"success:%d", (int)success);
        }];
        //更新数据
        [[WKUserInforManager sharedInstance] updateUserInfor:model];
        [self showProgressView:^(BOOL isDone) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        }];
    }
}

- (void)startPicker {
    CBImagePicker *picker = [CBImagePicker shared];
    [picker startWithVC:self];
    [picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
        if (!error) {
            [self.imageView changeImage:image];
        } else {
            NSLog(@"error.description = %@",error.userInfo[@"description"]);
        }
    }];
}

#pragma mark - lazy
- (WKUpLoadImageView *)imageView {
    if (!_imageView) {
        _imageView = [[WKUpLoadImageView alloc] init];
    }
    return _imageView;
}


@end
