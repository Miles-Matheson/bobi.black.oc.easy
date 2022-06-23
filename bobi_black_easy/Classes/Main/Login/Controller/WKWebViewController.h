//
//  WKWebViewController.h
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewController : WKBaseViewController
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) NSString *webUrl;

@end

NS_ASSUME_NONNULL_END
