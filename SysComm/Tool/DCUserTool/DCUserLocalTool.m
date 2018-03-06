//
//  DCUserLocalTool.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/27.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCUserLocalTool.h"
#import "DCNewFriendsModel.h"

#define DCRecentDealsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentDeals.data"]

#define DCRecentUidPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentUids.data"]

@implementation DCUserLocalTool

static NSMutableArray *_historyDeals;
static NSMutableArray *_historyUids;

+(NSMutableArray *)recentFriends
{
    if (!_historyDeals) {
        
        _historyDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:DCRecentDealsPath];
        if (!_historyDeals) {
            _historyDeals = [NSMutableArray array];
        }
    }
    return _historyDeals;
}

+(void)saveRecentFriend:(DCNewFriendsModel *)newFriend
{
    [self recentFriends];
    [_historyDeals removeObject:newFriend];
    [_historyDeals insertObject:newFriend atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:DCRecentDealsPath];
}
+(void)deleteRecentFriend:(DCNewFriendsModel *)newFriend
{
    [_historyDeals removeObject:newFriend];
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:DCRecentDealsPath];
}
+(void)deleteRecentFriends:(NSArray *)newFriends
{
    [_historyDeals removeObjectsInArray:newFriends];
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:DCRecentDealsPath];
    
}
/**
 *  保存用户的uid
 */

+(NSMutableArray *)historyUids
{
    if (!_historyUids) {
        _historyUids = [NSKeyedUnarchiver unarchiveObjectWithFile:DCRecentUidPath];
        if (!_historyUids) {
            _historyUids = [NSMutableArray array];
        }
    }
    return _historyUids;
}
+(void)saveUsersUID:(NSArray *)uid
{
    [self historyUids];
    [_historyUids removeObject:uid];
    [_historyUids insertObject:uid atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyUids toFile:DCRecentUidPath];
}
+(NSArray *)getUserUid
{
    NSArray *uid = [NSKeyedUnarchiver unarchiveObjectWithFile:DCRecentUidPath];
    return uid;
}






@end