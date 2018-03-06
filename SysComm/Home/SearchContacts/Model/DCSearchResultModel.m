//
//  DCSearchResultModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCSearchResultModel.h"

@implementation DCSearchResultModel

MJCodingImplementation;

+(DCSearchResultModel *)shareResultModel
{
    static DCSearchResultModel *model = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        if (!model) {
            model = [[self alloc]init];
        }
    });
    return model;
}

@end
