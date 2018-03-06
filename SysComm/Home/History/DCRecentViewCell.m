//
//  DCRecentViewCell.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/27.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCRecentViewCell.h"
#import "DCNewFriendsModel.h"
#import "DCGroupModel.h"
@interface DCRecentViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bumenLabel;

@property (weak, nonatomic) IBOutlet UIButton *sexImg;
@end
@implementation DCRecentViewCell

-(void)setZuijinliulanModel:(DCNewFriendsModel *)zuijinliulanModel
{
    _zuijinliulanModel = zuijinliulanModel;
    
    self.nameLabel.text = zuijinliulanModel.relname;

//    self.userImage.contentMode = UIViewContentModeCenter;
    self.userImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.userImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",zuijinliulanModel.photos]]];
    
    if (self.zuijinliulanModel.sex == 0) {
        [self.sexImg setImage:[UIImage imageNamed:@"最近查看－实心女图标@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.sexImg setImage:[UIImage imageNamed:@"最近查看－实心男图标@2x.png"] forState:UIControlStateNormal];
    }
    
    self.bumenLabel.text = self.zuijinliulanModel.group_job[@"group"];
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"celle";
    DCRecentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCRecentViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
@end
