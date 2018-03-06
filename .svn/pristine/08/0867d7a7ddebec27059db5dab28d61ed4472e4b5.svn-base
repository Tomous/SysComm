//
//  DCGroupModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCGroupModel.h"

@implementation DCGroupModel

MJCodingImplementation;

+(DCGroupModel *)shareGroup_job
{
    static DCGroupModel *group = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        
        if (!group) {
            group = [[self alloc]init];
        }
    });
    return group;
}
@end
