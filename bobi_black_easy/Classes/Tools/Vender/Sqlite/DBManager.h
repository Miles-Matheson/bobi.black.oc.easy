//
//  DBManager.h
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DBCompletion)(BOOL success);

@interface DBManager : NSObject
{
    
    NSString *databasePath;
}

+ (DBManager *)sharedInstance;

- (BOOL)createDB;

/// 添加
/// @param person person
/// @param completion block
- (void)addPerson:(Person *)person completion:(DBCompletion)completion;


/// 移除
- (void)removePerson:(NSString *)acount completion:(DBCompletion)completion;


/// 获取
- (Person *)getPersonWithName:(NSString *)acount;

//修改
- (void)updataStudentWithGender:(NSString *)sex userName:(NSString *)name;

- (void)updataStudentWithAge:(NSString *)age userName:(NSString *)name;

- (void)updataStudentWithImage:(NSString *)image userName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
