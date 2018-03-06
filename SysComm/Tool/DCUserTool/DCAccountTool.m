//
//  DCAccountTool.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCAccountTool.h"
#import "DCResponseModel.h"

#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#define kSuidPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"suid.data"]

#define kAccess_expiredPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"access_expired.data"]

static NSDate *value_time;
@implementation DCAccountTool

+(void)saveToken:(NSString *)token
{
    value_time = [NSDate dateWithTimeIntervalSince1970:[DCResponseModel shareResponse].access_expired];
    
    DCLog(@"account.value_time是＝－－%@",value_time);

    [NSKeyedArchiver archiveRootObject:token toFile:kAccountPath];
    [NSKeyedArchiver archiveRootObject:value_time toFile:kAccess_expiredPath];
}
+(NSString *)token
{
    
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    value_time = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccess_expiredPath];
    
     // 拿出有效期和现在进行比较，如果过期了，返回空
    NSDate *now = [[NSDate alloc]init];
    DCLog(@"时间戳是%ld",(long)[now compare:value_time]);
    if ([now compare:value_time] == 1) {
        token = nil;
    }
    DCLog(@"1分钟后的token是－－%@",token);
    return token;
}

+(void)deleteToken:(NSString *)userToken
{
    userToken = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    userToken = nil;
    [NSKeyedArchiver archiveRootObject:userToken toFile:kAccountPath];
}

//取出用户uid
+(void)saveSuid:(NSString *)uid
{
    [NSKeyedArchiver archiveRootObject:uid toFile:kSuidPath];
}
+(NSString *)uid
{
    NSString *uid = [NSKeyedUnarchiver unarchiveObjectWithFile:kSuidPath];
    return uid;
}

//储存用户账号
+(void)saveUser:(NSString *)users
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:users forKey:@"usersAddress"];
}
+(NSString *)getUsers
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *users = [user objectForKey:@"usersAddress"];
    return users;
}
//储存用户密码
+(void)savePassWD:(NSString *)passWD
{
    NSUserDefaults *passWord = [NSUserDefaults standardUserDefaults];
    [passWord setObject:passWD forKey:@"passWord"];
}
+(NSString *)passWD
{
    NSUserDefaults *passWord = [NSUserDefaults standardUserDefaults];
    NSString *str = [passWord objectForKey:@"passWord"];
    return str;
}
//储存用户名
+(void)saveUserName:(NSString *)userName
{
    NSUserDefaults *name = [NSUserDefaults standardUserDefaults];
    [name setObject:userName forKey:@"userName"];
}
+(NSString *)getUserName
{
    NSUserDefaults *name = [NSUserDefaults standardUserDefaults];
    NSString *str = [name objectForKey:@"userName"];
    return str;
}
@end
