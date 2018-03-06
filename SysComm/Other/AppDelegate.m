//
//  AppDelegate.m
//  讯通
//
//  Created by 许大成 on 16/1/11.
//  Copyright © 2016年 许大成. All rights reserved.
//

#import "AppDelegate.h"
#import "DCTabBarViewController.h"
#import "DCLoginViewController.h"
#import "DCPersonPlistController.h"
#import "DCControllerTool.h"
#import "DCAccountTool.h"
#import "DCResponseModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  plist里面  View controller-based status bar appearance的属性设置为NO＋这句话，让电池条变成白色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [NSThread sleepForTimeInterval:1.0];
    [self.window makeKeyAndVisible];
    
    NSString *accountToken = [DCAccountTool token];
    
    DCLog(@"1分钟后的accountToken是－－%@",accountToken);
    if (accountToken) {
        
        [DCDataModel shareDataModel].uid = [DCAccountTool uid];
        
        [DCResponseModel shareResponse].token = accountToken;
        
        self.window.rootViewController = [[DCTabBarViewController alloc]init];
    }
    else
    {
        self.window.rootViewController = [[DCLoginViewController alloc]init];
    }
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
