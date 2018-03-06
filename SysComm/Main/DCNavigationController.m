//
//  DCNavigationController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCNavigationController.h"

@interface DCNavigationController ()

@end

@implementation DCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

+(void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barStyle = UIBarStyleBlackTranslucent;
    
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:@"顶部栏左边左箭头.png" higImageName:@"顶部栏左边左箭头.png" target:self active:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
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
