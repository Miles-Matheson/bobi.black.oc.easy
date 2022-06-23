//
//  DBManager.m
//  WOKO
//
//  Created by admin on 2022/4/11.
//

#import "DBManager.h"
#import <sqlite3.h>

static DBManager *_singleInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
static NSString *DB_SQLITE = @"people.db";
static NSString *DB_TABLE = @"personDetail";

@implementation DBManager


#pragma mark - 单例

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [super allocWithZone:zone];
    });
    return _singleInstance;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [super init];
        if (_singleInstance) {
            // 在这里初始化self的属性和方法
        }
    });
    return _singleInstance;
}


#pragma mark -

- (BOOL)createDB {
    
    BOOL isSuccess = YES;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:DB_SQLITE]];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:databasePath] == NO) {
        
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            NSString *sqliteStr = [NSString stringWithFormat:@"create table if not exists %@ (idx integer primary key autoincrement, username text, password text, acount text, sex text, age text,headData text)", DB_TABLE];
            const char *sqliteChar = [sqliteStr UTF8String];
            char *errMsg;
            if (sqlite3_exec(database, sqliteChar, NULL, NULL, &errMsg) != SQLITE_OK) {
                
                isSuccess = NO;
                NSLog(@"!!! Failed to create table, errMsg:%s", errMsg);
            }
            sqlite3_close(database);
            
        }else {
            
            isSuccess = NO;
            NSLog(@"!!! Failed to open/create database");
        }
    }
    
    return isSuccess;
}


/// 添加
/// @param person person
/// @param completion block
- (void)addPerson:(Person *)person completion:(DBCompletion)completion {
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        NSString *sqliteStr = [NSString stringWithFormat:@"insert into %@ (username, password, acount, sex, age, headData) values (?, ?, ?, ?, ?, ?);", DB_TABLE];
        const char *sqliteChar = [sqliteStr UTF8String];
        int result = sqlite3_prepare_v2(database, sqliteChar, -1, &statement, nil);
        if (result == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [person.username UTF8String], -1, nil);
            sqlite3_bind_text(statement, 2, [person.password UTF8String], -1, nil);
            sqlite3_bind_text(statement, 3, [person.acount UTF8String], -1, nil);
            sqlite3_bind_text(statement, 4, [person.sex UTF8String], -1, nil);
            sqlite3_bind_text(statement, 5, [person.age UTF8String], -1, nil);
            sqlite3_bind_text(statement, 6, [person.headData UTF8String], -1, nil);

            if (sqlite3_step(statement) == SQLITE_DONE) {
                sqlite3_finalize(statement);
                if (completion) completion(YES);
                return;
            }
        }
    }
    
    sqlite3_finalize(statement);
    if (completion) completion(NO);
}


/// 移除
- (void)removePerson:(NSString *)acount completion:(DBCompletion)completion {
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        NSString *sqliteStr = [NSString stringWithFormat:@"delete from %@ where acount = \"%@\"", DB_TABLE, acount];
        const char *sqliteChar = [sqliteStr UTF8String];
        int result = sqlite3_prepare_v2(database, sqliteChar, -1, &statement, nil);
        if (result == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                sqlite3_finalize(statement);
                if (completion) completion(YES);
                return;
            }
        }
    }
    
    sqlite3_finalize(statement);
    if (completion) completion(NO);
}


/// 获取
- (Person *)getPersonWithName:(NSString *)acount {
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {

        NSString *sqliteStr = [NSString stringWithFormat:@"select * from %@ where acount=\"%@\"", DB_TABLE, acount];
        const char *sqliteChar = [sqliteStr UTF8String];
        int result = sqlite3_prepare_v2(database, sqliteChar, -1, &statement, nil);
        if (result == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                Person *person = [Person new];
                person.username = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                person.password = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                person.acount = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                person.sex = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                person.age = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                person.headData = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                if ([person.acount isEqualToString:acount]) {
                    sqlite3_finalize(statement);
                    return person;
                }
            }
        }
    }
    
    sqlite3_finalize(statement);
    return nil;
}
///修改
- (void)updataStudentWithGender:(NSString *)sex userName:(NSString *)name {
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update %@ set sex = '%@' where acount = '%@'",DB_TABLE,sex,name];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(database, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
}
- (void)updataStudentWithAge:(NSString *)age userName:(NSString *)name {
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update %@ set age = '%@' where acount = '%@'",DB_TABLE,age,name];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(database, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
}
- (void)updataStudentWithImage:(NSString *)image userName:(NSString *)name {
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update %@ set headData = '%@' where acount = '%@'",DB_TABLE,image,name];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(database, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
}


@end
