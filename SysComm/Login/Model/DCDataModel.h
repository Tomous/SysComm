//
//  DCDataModel.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCGroupModel;
@interface DCDataModel : NSObject

//group
@property(nonatomic,copy)NSDictionary *group_job;

@property(nonatomic,copy)NSString *group;
/**
 *  获取用户的uid
 */
@property(nonatomic,copy)NSString *uid;
/**
 *  email，座机，手机号
 */
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *telphone;
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
 *  最后一次登录
 */
@property(nonatomic,copy)NSString *lastlogin;

@property(nonatomic,copy)NSString *lastip;
@property(nonatomic,copy)NSString *thisip;
/**
 *  用户所在城市
 */
@property(nonatomic,copy)NSString *lastgeo;

+(DCDataModel *)shareDataModel;
@end
