//
//  DCRecentModel.h
//  SysComm
//
//  Created by 许大成 on 16/1/25.
//  Copyright © 2016年 许大成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCRecentModel : NSObject

/**
 *  用户头像,刚进来的时候是空的
 */
@property(nonatomic,copy)NSString *photos;


@property(nonatomic,copy)NSString *relname;

/**
 *  性别
 */
@property(nonatomic,assign)int sex;

@property(nonatomic,copy)NSDictionary *group_job;


@end
