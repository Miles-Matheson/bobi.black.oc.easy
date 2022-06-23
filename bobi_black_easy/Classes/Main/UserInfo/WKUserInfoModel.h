//
//  WKUserInfoModel.h
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKUserInfoModel : NSObject <NSSecureCoding>
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *acount;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *headData;
@property(nonatomic,strong)NSMutableArray   *voiceListArr;
@property(nonatomic,strong)NSMutableArray   *dataArr;
@property (nonatomic, assign) BOOL loginStatus;

@end

NS_ASSUME_NONNULL_END
