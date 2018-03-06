//
//  DCRecentViewCell.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/27.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCNewFriendsModel;

@interface DCRecentViewCell : UITableViewCell

@property(nonatomic,strong)DCNewFriendsModel *zuijinliulanModel;


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
