//
//  DCGroupModel.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGroupModel : NSObject<NSCoding>

@property(nonatomic,copy)NSString *group;


@property(nonatomic,copy)NSString *job;

+(DCGroupModel *)shareGroup_job;

@end
