//
//  DCSearchViewController.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCSearchResultModel;
@interface DCSearchViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *result;

@property(nonatomic,strong)DCSearchResultModel *resultModel;

@end
