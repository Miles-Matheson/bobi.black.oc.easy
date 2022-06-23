//
//  WKUserInforManager.h
//  WOKO
//
//  Created by admin on 2022/4/9.
//

#import <Foundation/Foundation.h>
#import "WKUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKUserInforManager : NSObject

KTDECLARESINGLETON
/// 更新用户---基本信息模型数据
- (void)updateUserInfor:(WKUserInfoModel *)userModel;
/// 获取用户模型
- (WKUserInfoModel *)getUserInfor;
/// 获取用户的手机号
- (NSString *)getUserInforUserAcount;
///获取密码
- (NSString *)getUserInforPassword;
///获取头像
- (NSString *)getUserInforAvater;
///获取用户名
- (NSString *)getUserInforUserName;
///获取性别
- (NSString *)getUserInforSex;
///获取年龄
- (NSString *)getUserInforAge;
///获取登录状态
- (BOOL)getUserInforLoginStatus;
///修改性别
- (void)changeUserSexAction:(NSString *)sex;
///修改年龄
- (void)changeUserAgeAction:(NSString *)age;
///修改头像
- (void)changeUserImageAction:(NSString *)image;
///修改登录状态
- (void)changeUserLoginStatus:(BOOL)status;
//获取录音列表
-(NSMutableArray  *)getUserVoiceList;
//修改录音列表
-(void)changeTheVoiceListAction:(NSMutableArray *)arr;
/// 清楚用户信息缓存
- (void)clearCachedUserInfor;
//获取首页数据资源
-(NSMutableArray *)getUserDataList;
//删除某一条首页数据资源
-(void)deletTheUserDicFromeDataList:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
