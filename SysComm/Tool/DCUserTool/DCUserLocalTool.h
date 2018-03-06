//
//  DCUserLocalTool.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/27.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCNewFriendsModel;
@interface DCUserLocalTool : NSObject

+(NSMutableArray *)recentFriends;
+(void)saveRecentFriend:(DCNewFriendsModel *)newFriend;
+(void)deleteRecentFriend:(DCNewFriendsModel *)newFriend;
+(void)deleteRecentFriends:(NSArray *)newFriends;


+(NSMutableArray *)historyUids;
+(void)saveUsersUID:(NSArray *)uid;
+(NSArray *)getUserUid;
@end
