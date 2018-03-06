//
//  DCPersonPlistController.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCDataModel,DCResponseModel;
@interface DCPersonPlistController : UIViewController

@property(nonatomic,strong)NSMutableArray *friendModel;

@property(nonatomic,strong)NSMutableArray *zuijinliulanModel;

@property(nonatomic,strong)DCDataModel *dataModel;

@property(nonatomic,strong)DCResponseModel *token;
@property(nonatomic,strong)UIImageView *imageView;
@end
