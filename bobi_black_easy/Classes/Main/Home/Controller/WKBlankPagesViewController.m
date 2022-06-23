//
//  WKBlankPagesViewController.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "WKBlankPagesViewController.h"

@interface WKBlankPagesViewController ()

@end

@implementation WKBlankPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllerTitleView:@"Blank pages"];
}
- (void)backToPrevious {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
