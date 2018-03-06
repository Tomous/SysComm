//
//  DCRelationModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/12/7.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCRelationModel.h"

@implementation DCRelationModel
MJCodingImplementation;
+(DCRelationModel *)shareRelations
{
    static DCRelationModel *relations = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch,^{
        if (!relations) {
            relations = [[self alloc]init];
        }
    });
    return relations;
}
@end
