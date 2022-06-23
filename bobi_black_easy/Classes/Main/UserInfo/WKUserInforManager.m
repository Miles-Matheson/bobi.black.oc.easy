//
//  WKUserInforManager.m
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import "WKUserInforManager.h"

//userInformation
#define kNSKeyedArchPath_UserInfo       [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"WKUserInfor.arch"]


@interface WKUserInforManager ()
@property(nonatomic, strong) WKUserInfoModel *userBsaeModel;

@end

@implementation WKUserInforManager
KTSINGLETON

-(void)updateUserInfor:(WKUserInfoModel *)userModel {
    self.userBsaeModel = userModel;
    
    // 同步一次
    [self cacheSaveUserInfor];
}
- (void)cacheSaveUserInfor {
    
    if (@available(iOS 11.0, *)) {
        NSError *error;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userBsaeModel requiringSecureCoding:YES error:&error];
        if (!error && data) {
            BOOL isSuccess = [data writeToFile:kNSKeyedArchPath_UserInfo atomically:YES];
            if (isSuccess) {
                NSLog(@"归档用户信息成功了1");
            }
        }
    } else {
        [NSKeyedArchiver archiveRootObject:self.userBsaeModel toFile:kNSKeyedArchPath_UserInfo];
        NSLog(@"归档用户信息成功了2");
    }
}
- (WKUserInfoModel *)getUserInfor {
    
    if (self.userBsaeModel) {
        return self.userBsaeModel;
    }
    
    if (@available(iOS 11.0,*)) {
        NSData * undata = [NSData dataWithContentsOfFile:kNSKeyedArchPath_UserInfo];
        if (undata) {
            NSError *error;
            WKUserInfoModel *model = [NSKeyedUnarchiver unarchivedObjectOfClass:[WKUserInfoModel class] fromData:undata error:&error]; // 模型嵌套了
            if (model && !error) {
                self.userBsaeModel = model;
                NSLog(@"解档用户信息成功了1");
            }
        }
    }else {
        self.userBsaeModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kNSKeyedArchPath_UserInfo];
        NSLog(@"解档用户信息成功了2");
}
    
    return self.userBsaeModel;
}

/// 获取用
- (NSString *)getUserInforUserAcount {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.acount;
}
///获取密码
- (NSString *)getUserInforPassword {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    NSLog(@"%@",self.userBsaeModel.password);
    return self.userBsaeModel.password;
}
///获取头像
- (NSString *)getUserInforAvater {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.headData;
}
///获取用户名
- (NSString *)getUserInforUserName {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.username;
}
///获取性别
- (NSString *)getUserInforSex {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.sex;
}
///获取年龄
- (NSString *)getUserInforAge {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.age;
}

//获取录音列表
-(NSMutableArray  *)getUserVoiceList{
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.voiceListArr ? self.userBsaeModel.voiceListArr : [NSMutableArray array];
}

//获取首页数据资源
-(NSMutableArray *)getUserDataList{
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.dataArr ? self.userBsaeModel.dataArr : [NSMutableArray array];
}

-(void)deletTheUserDicFromeDataList:(NSDictionary *)dic{
    WKUserInfoModel  *model = self.userBsaeModel;
    [model.dataArr removeObject:dic];
    [self updateUserInfor:model];
}

///获取登录状态
- (BOOL)getUserInforLoginStatus {
    [self getUserInfor];
    if (!self.userBsaeModel) {
        return nil;
    }
    return self.userBsaeModel.loginStatus;
}
///修改性别
- (void)changeUserSexAction:(NSString *)sex {
    WKUserInfoModel *model = self.userBsaeModel;
    model.sex = sex;
    [self updateUserInfor:model];
}

///修改年龄
- (void)changeUserAgeAction:(NSString *)age {
    WKUserInfoModel *model = self.userBsaeModel;
    model.age = age;
    [self updateUserInfor:model];
}
///修改登录状态
- (void)changeUserLoginStatus:(BOOL)status {
    WKUserInfoModel *model = self.userBsaeModel;
    model.loginStatus = status;
    [self updateUserInfor:model];
}

///修改头像
- (void)changeUserImageAction:(NSString *)image {
    WKUserInfoModel *model = self.userBsaeModel;
    model.headData = image;
    [self updateUserInfor:model];
}

//修改录音列表
-(void)changeTheVoiceListAction:(NSMutableArray *)arr{
    WKUserInfoModel *model = self.userBsaeModel;
    model.voiceListArr = arr;
    [self updateUserInfor:model];
}


- (void)clearCachedUserInfor {
    // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    BOOL isDelete = [manager removeItemAtPath:kNSKeyedArchPath_UserInfo error:nil];
    if (isDelete) {
        self.userBsaeModel = nil;
        NSLog(@"用户信息本地缓存文件删除");
    }
}

@end
