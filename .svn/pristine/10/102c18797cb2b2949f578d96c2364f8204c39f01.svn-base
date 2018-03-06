//
//  DCControllerTool.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCControllerTool.h"
#import "DCPersonPlistController.h"
@implementation DCControllerTool
+(void)chooseRootVC
{
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDict[versionKey];
    
    // 上次使用的版本号
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [ud objectForKey:versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:lastVersion]) {
        // 新特性控制器
        window.rootViewController = [[DCPersonPlistController alloc]init];
        
        // 存一下这次使用的版本号
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:currentVersion forKey:versionKey];
        [ud synchronize];
        
    }
    else
    {
        // 0 还原状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        
        window.rootViewController = [[DCPersonPlistController alloc]init];
        
    }

}
@end
