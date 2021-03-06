//
//  DCTabBarViewController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCTabBarViewController.h"
#import "DCNavigationController.h"
#import "DCPersonPlistController.h"
#import "DCMoreFriendController.h"
#import "DCSearchViewController.h"
#import "DCPersonalController.h"
#import "DCRecentController.h"
#import "DCSliderController.h"
@interface DCTabBarViewController ()

@end

@implementation DCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    DCSliderController *home = [[DCSliderController alloc]init];
    [self addChildViewController:home title:NSLocalizedString(@"TABBAR_CONTACTS", @"") imageName:@"底部部门同事图标" selImageName:@"底部l绿色部门同事图标"];
    
    DCRecentController *more = [[DCRecentController alloc]init];
    [self addChildViewController:more title:NSLocalizedString(@"TABBAR_RECENT", @"") imageName:@"底部最近查看图标" selImageName:@"底部绿色实心最近查看图标-拷贝"];
    
    DCSearchViewController *searchVC = [[DCSearchViewController alloc]init];
    [self addChildViewController:searchVC title:NSLocalizedString(@"TABBAR_SEARCH", @"") imageName:@"底部搜索同事按钮" selImageName:@"底部彩色搜索同事按钮-拷贝"];
    
    DCPersonalController *me = [[DCPersonalController alloc]init];
    [self addChildViewController:me title:NSLocalizedString(@"TABBAR_PERSONAL", @"") imageName:@"底部个人资料图标" selImageName:@"shi底部绿色个人资料图标"];
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *norAtt = [NSMutableDictionary dictionary];
    norAtt[NSForegroundColorAttributeName] = DCColor(174, 174, 174);
    [item setTitleTextAttributes:norAtt forState:UIControlStateNormal];
    
    NSMutableDictionary *selAtt = [NSMutableDictionary dictionary];
    selAtt[NSForegroundColorAttributeName] = DCColor(33, 184, 188);
    [item setTitleTextAttributes:selAtt forState:UIControlStateSelected];
    

}

-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{
    childController.title = title;
    UIImage *selImage = [UIImage imageNamed:selImageName];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [childController.tabBarItem setImage:image];
    [childController.tabBarItem setSelectedImage:selImage];

    [self addChildViewController:childController];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
