//
//  WKContactViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKContactViewController.h"
#import "WKContactView.h"
#import "BobiEasyHeader.h"
@interface WKContactViewController ()
@property (nonatomic, strong) WKContactView *contactView;

@end

@implementation WKContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Feedback"];
}

- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)custom_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"submitAction"]) {
        [self showProgressView:^(BOOL isDone) {
            [YPCSVProgress showSuccessMessageWithTitle:@"submit successful" finishBlock:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    } else if ([eventName isEqualToString:@"uploadImageAction"]){
        [self startPicker];
    }
}

- (void)startPicker {
    CBImagePicker *picker = [CBImagePicker shared];
    [picker startWithVC:self];
    [picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
        if (!error) {
            [self.contactView uploadImage:image];
        } else {
            NSLog(@"error.description = %@",error.userInfo[@"description"]);
        }
    }];
}

- (void)createUI {
    [super createUI];
    [self.containerView addSubview:self.contactView];
}

- (void)createLayout {
    [super createLayout];
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}
#pragma mark - lazy
- (WKContactView *)contactView {
    if (!_contactView) {
        _contactView = [[WKContactView alloc] init];
    }
    return _contactView;
}


@end
