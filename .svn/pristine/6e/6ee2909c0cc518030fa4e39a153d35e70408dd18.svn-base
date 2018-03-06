//
//  DCSliderController.m
//  讯通
//
//  Created by 许大成 on 16/1/12.
//  Copyright © 2016年 许大成. All rights reserved.
//

#import "DCSliderController.h"
#import "DCPersonPlistController.h"
#import "DCMoreFriendController.h"
#define kMargin 5
@interface DCSliderController ()<UIScrollViewDelegate>
{
    UIView *navView;
    UIView *batteryView;
    UILabel *titleLabel;
}
@property(strong,nonatomic)UIScrollView *scrollView;
@end

@implementation DCSliderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpHeaderView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moreBtnDidClick11) name:@"MOREBTNDIDCLICK" object:nil];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.width = self.view.width;
    scrollView.height = self.view.height - batteryView.height - navView.height - 48;
    scrollView.x = 0;
    scrollView.y = CGRectGetMaxY(navView.frame);
    scrollView.contentSize = CGSizeMake(self.view.width * 2, 1);
    scrollView.scrollEnabled = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    DCPersonPlistController *firstVC = [[DCPersonPlistController alloc]init];
    [self addChildViewController:firstVC];
    [scrollView addSubview:firstVC.view];
    
    DCMoreFriendController *secondVC = [[DCMoreFriendController alloc]init];
    [self addChildViewController:secondVC];
    secondVC.view.x = self.view.width;
    [scrollView addSubview:secondVC.view];
}

/**
 *   navigationView布局
 
 */
-(void)setUpHeaderView
{
    batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    batteryView.backgroundColor = DCColor(82.0, 82.0, 82.0);
    [self.view addSubview:batteryView];
    
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, batteryView.height, self.view.width, 50)];
    navView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [self.view addSubview:navView];
    /**
     title
     */
    titleLabel = [[UILabel alloc]init];
    titleLabel.width = self.view.width / 2;
    titleLabel.height = 35;
    titleLabel.x = (self.view.width - titleLabel.width) / 2;
    titleLabel.y = kMargin;
    titleLabel.text = NSLocalizedString(@"LATEST_COLL", nil);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
}


#pragma method
-(void)moreBtnDidClick11
{
    self.scrollView.scrollEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(DCScreenW, 0);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//    if (self.scrollView.contentOffset.x) {
//        
//    }
    if (scrollView.contentOffset.x == DCScreenW) {
        titleLabel.text = NSLocalizedString(@"PERSONLIST_HOME", @"");
    }
    else
    {
        titleLabel.text = NSLocalizedString(@"LATEST_COLL", nil);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
