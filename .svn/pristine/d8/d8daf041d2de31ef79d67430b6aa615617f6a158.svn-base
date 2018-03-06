//
//  DCPersonalModel.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/24.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCPersonalModel.h"

@implementation DCPersonalModel
MJCodingImplementation;
+(DCPersonalModel *)sharePersonModel
{
    static DCPersonalModel *personModel;
    static dispatch_once_t dispatchPerson;
    dispatch_once(&dispatchPerson, ^{
        
        if (!personModel) {
            personModel = [[self alloc]init];
        }
    });
    return personModel;
}
@end
