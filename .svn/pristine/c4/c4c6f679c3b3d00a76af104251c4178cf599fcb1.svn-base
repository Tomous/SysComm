//
//  DCDataModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCDataModel.h"

@implementation DCDataModel

MJCodingImplementation;

+(DCDataModel *)shareDataModel
{
    static DCDataModel *data = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken,^{
        if (!data) {
            data = [[self alloc]init];
        }
    });
    return data;
}

@end
