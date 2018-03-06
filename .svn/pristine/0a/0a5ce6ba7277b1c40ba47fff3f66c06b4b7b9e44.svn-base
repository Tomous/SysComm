//
//  DCMoreTableViewCell.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/26.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCMoreTableViewCell.h"
#define kMargin 10

@interface DCMoreTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImg;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userSexImg;


@end
@implementation DCMoreTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)setMoreFriendModel:(DCNewFriendsModel *)moreFriendModel
{
    _moreFriendModel = moreFriendModel;
    
    [self.userPhotoImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",moreFriendModel.photos]]];
    self.userNameLabel.text = moreFriendModel.relname;
//    self.userSexImg.contentMode = UIViewContentModeCenter;
    self.userSexImg.contentMode = UIViewContentModeScaleAspectFit;
    if (moreFriendModel.sex == 0) {

        self.userSexImg.image = [UIImage imageNamed:@"联系同事－实心性别女图标@2x.png"];
    }
    else
    {
         self.userSexImg.image = [UIImage imageNamed:@"联系同事－实心性别男图标@2x.png"];
    }


}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *str = @"Mycell";
    
    DCMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCMoreTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}










@end
