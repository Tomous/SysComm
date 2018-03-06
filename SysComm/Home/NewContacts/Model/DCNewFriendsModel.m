//
//  DCNewFriendsModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/24.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCNewFriendsModel.h"

@implementation DCNewFriendsModel

MJCodingImplementation;

+(DCNewFriendsModel *)shareFriendModel
{
    static DCNewFriendsModel *newFriendModel;
    static dispatch_once_t dispatchNewToken;
    dispatch_once(&dispatchNewToken, ^{
       
        if (!newFriendModel) {
            newFriendModel = [[self alloc]init];
        }
    });
    return newFriendModel;
}
/**
 *  这个方法是避免最近浏览的时候重复保存cell
 */
-(BOOL)isEqual:(DCNewFriendsModel *)newFriend
{
    return [self.uid isEqual:newFriend.uid];
}

@end
