//
//  DCResponseModel.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DCDataModel;
@interface DCResponseModel : NSObject

//获取token值
@property(nonatomic,copy)NSString *token;

@property(nonatomic,assign)NSInteger access_expired;
//@property(nonatomic,copy)NSString *access_expired;

@property(nonatomic,copy)NSString *lastlogin;

/**
 *  单利保存用户的token,全局都可以取到
 */
+(DCResponseModel *)shareResponse;

@end
