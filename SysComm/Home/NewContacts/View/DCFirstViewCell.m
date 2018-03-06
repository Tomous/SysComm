//
//  DCFirstViewCell.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/24.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCFirstViewCell.h"

#define kMargin 5

@interface DCFirstViewCell ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *sexImg;

@end
@implementation DCFirstViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = DCTextColor;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = DCColor(204, 204, 204);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView = imageView;
        [self addSubview:imageView];
        
        UIButton *sexImg = [[UIButton alloc]init];
        sexImg.backgroundColor = [UIColor whiteColor];
        sexImg.contentMode = UIViewContentModeScaleToFill;
        self.sexImg = sexImg;
        [self addSubview:sexImg];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.width = self.width;
    self.nameLabel.height = 25;
    self.nameLabel.y = self.height - self.nameLabel.height;
    
    self.imageView.height = self.height - self.nameLabel.height - 7;
    self.imageView.width = self.imageView.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = 3;
    self.imageView.layer.cornerRadius = self.imageView.width / 2;
    self.imageView.layer.masksToBounds = self.imageView.width / 2;
    
    self.sexImg.width = self.imageView.width / 3;
    self.sexImg.height = self.sexImg.width;
    self.sexImg.x = CGRectGetMaxX(self.imageView.frame) - self.sexImg.width;
    self.sexImg.y = CGRectGetMaxY(self.imageView.frame) - self.sexImg.height;
    self.sexImg.layer.cornerRadius = self.sexImg.width / 2;
    self.sexImg.layer.masksToBounds = YES;
    
}
-(void)setFriendModel:(DCNewFriendsModel *)friendModel
{
    _friendModel = friendModel;

    [self.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",friendModel.photos]]];
    self.nameLabel.text = friendModel.relname;
    if (friendModel.sex == 0) {
        [self.sexImg setImage:[UIImage imageNamed:@"最新同事－实心女图标@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.sexImg setImage:[UIImage imageNamed:@"最新同事－实心男图标@2x.png"] forState:UIControlStateNormal];
    }

}


@end
