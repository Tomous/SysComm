//
//  DCResponseModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/23.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCResponseModel.h"

@implementation DCResponseModel

+(DCResponseModel *)shareResponse
{
    static DCResponseModel *response = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken,^{
        if (!response){
            response = [[self alloc] init];
        }
    });
    return response;
}
@end
