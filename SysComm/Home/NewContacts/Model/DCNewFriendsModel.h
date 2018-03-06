//
//  DCNewFriendsModel.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/24.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCNewFriendsModel : NSObject<NSCoding>

/**
 *  email，座机，手机号
 */
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *telphone;
/**
 *  名字
 */
@property(nonatomic,copy)NSString *relname;
/**
 *  微信号，QQ号，
 */
@property(nonatomic,copy)NSString *weixin;
@property(nonatomic,copy)NSString *qq;
/**
 *  性别
 */
@property(nonatomic,assign)int sex;
/**
 *  用户头像,刚进来的时候是空的
 */
@property(nonatomic,copy)NSString *photos;

/**
 *  用户所在城市
 */
@property(nonatomic,copy)NSString *lastgeo;
/**
 *  最后登录时间
 */
@property(nonatomic,copy)NSString *lastlogin;

@property(nonatomic,copy)NSString *uid;

@property(nonatomic,copy)NSDictionary *group_job;

+(DCNewFriendsModel *)shareFriendModel;

@end
