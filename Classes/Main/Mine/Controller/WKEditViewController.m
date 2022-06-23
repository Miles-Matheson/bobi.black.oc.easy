//
//  WKEditViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKEditViewController.h"
#import "WKMineEditView.h"
#import "HQPickerView.h"

@interface WKEditViewController ()<HQPickerViewDelegate>
{
    NSInteger _index;
}
@property (nonatomic, strong) WKMineEditView *editView;
@property (nonatomic, strong) NSMutableArray *arrayAge;

@end

@implementation WKEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBarWithAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    for (int i = 18; i < 100; i ++) {
        [self.arrayAge addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.editView];
}

- (void)createLayout {
    [super createLayout];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"MineBackAction"]) {
        [self.navigationController popViewControllerAnimated:NO];
    } else if ([eventName isEqualToString:@"changeSexAction"]) {
        _index = 1;
        HQPickerView *picker = [[HQPickerView alloc] initWithFrame:self.view.bounds title:@"Sex"];
        picker.delegate = self ;
        picker.customArr = @[@"Men",@"Women"];
        [[UIApplication sharedApplication].keyWindow addSubview:picker];
    } else if ([eventName isEqualToString:@"changeAgeAction"]) {
        _index = 2;
        HQPickerView *picker = [[HQPickerView alloc] initWithFrame:self.view.bounds title:@"age"];
        picker.delegate = self;
        picker.customArr = self.arrayAge;
        [[UIApplication sharedApplication].keyWindow addSubview:picker];
    } else if ([eventName isEqualToString:@"ChooseImage"]) {
        [self startPicker];
    }else if ([eventName isEqualToString:@"uploadRecordings"]){
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showStatusMessageWithTitle:@"success" finishBlock:^{
                [self.editView.bottomView deleteBtnAction];
            }];
        }];
    }
}
- (void)startPicker {
    CBImagePicker *picker = [CBImagePicker shared];
    [picker startWithVC:self];
    [picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
        if (!error) {
            [self.editView changeUserAvatar:image];
            NSData *data = UIImageJPEGRepresentation(image , 0.1);
            [[WKUserInforManager sharedInstance] changeUserImageAction:[data base64Encoding]];
            [[DBManager sharedInstance] createDB];
            [[DBManager sharedInstance] updataStudentWithImage:[data base64Encoding] userName:[[WKUserInforManager sharedInstance] getUserInforUserAcount]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadHeadImage" object:nil];
            
        } else {
            NSLog(@"error.description = %@",error.userInfo[@"description"]);
        }
    }];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text {
    if (_index == 1) {
        [self.editView changeUserInforSex:text];
        [[WKUserInforManager sharedInstance] changeUserSexAction:text];
        [[DBManager sharedInstance] createDB];
        [[DBManager sharedInstance] updataStudentWithGender:text userName:[[WKUserInforManager sharedInstance] getUserInforUserAcount]];
    } else {
        [self.editView changeUserInforAge:text];
        [[WKUserInforManager sharedInstance] changeUserAgeAction:text];
        [[DBManager sharedInstance] createDB];
        [[DBManager sharedInstance] updataStudentWithAge:text userName:[[WKUserInforManager sharedInstance] getUserInforUserAcount]];
    }
}
#pragma mark - lazy
- (WKMineEditView *)editView {
    if (!_editView) {
        _editView = [[WKMineEditView alloc] init];
    }
    return _editView;
}
- (NSMutableArray *)arrayAge {
    if (!_arrayAge) {
        _arrayAge = [[NSMutableArray alloc] init];
    }
    return _arrayAge;
}

@end
