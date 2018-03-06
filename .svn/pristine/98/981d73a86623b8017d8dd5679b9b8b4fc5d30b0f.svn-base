//
//  DCPersonalHeaderView.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/12/10.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCPersonalHeaderView.h"
#define margin 5
@interface DCPersonalHeaderView ()

@property(nonatomic,strong)UIButton *personalBtn;

@end
@implementation DCPersonalHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //用户头像布局
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:20];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        //部门
        UILabel * groupLabel = [[UILabel alloc]init];
        groupLabel.font = [UIFont systemFontOfSize:16];
        groupLabel.textColor = [UIColor whiteColor];
        groupLabel.textAlignment = NSTextAlignmentCenter;
        _groupLabel = groupLabel;
        [self addSubview:groupLabel];
        
        //个人头像
        UIButton * personalBtn = [[UIButton alloc]init];
        personalBtn.backgroundColor = [UIColor whiteColor];
        [personalBtn addTarget:self action:@selector(personalBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        personalBtn.contentMode = UIViewContentModeScaleAspectFit;
        self.personalBtn = personalBtn;
        [self addSubview:personalBtn];
        
        UIImageView * personalImgView = [[UIImageView alloc]init];
        personalImgView.backgroundColor = [UIColor clearColor];
        _personalImgView = personalImgView;
        [personalBtn addSubview:personalImgView];

        // 性别
        UIImageView * genderImgView = [[UIImageView alloc]init];
        genderImgView.backgroundColor = [UIColor colorWithRed:256.0 green:256.0 blue:256.0 alpha:0.5];
        genderImgView.contentMode = UIViewContentModeCenter;
        _genderImgView = genderImgView;
        [self addSubview:genderImgView];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _nameLabel.width = self.width;
    _nameLabel.height = 30;
    _nameLabel.y = self.height - _nameLabel.height *2 +2;
    
    _groupLabel.width = self.width;
    _groupLabel.height = _nameLabel.height;
    _groupLabel.y = self.height - _groupLabel.height - 3;
    
    self.personalBtn.height = self.height - _groupLabel.height *2 - 10;
    self.personalBtn.width = self.personalBtn.height;
    self.personalBtn.x = (self.width - self.personalBtn.width) / 2;
    self.personalBtn.y = margin + 3;
    self.personalBtn.layer.cornerRadius = self.personalBtn.width / 2;
    self.personalBtn.layer.masksToBounds = YES;

    
    _personalImgView.width = self.personalBtn.width;
    _personalImgView.height = self.personalBtn.height;

    _genderImgView.width = self.personalBtn.width / 3;
    _genderImgView.height = _genderImgView.width;
    _genderImgView.layer.cornerRadius = _genderImgView.width / 2;
    _genderImgView.x = self.width / 2 + margin;
    _genderImgView.y = CGRectGetMaxY(self.personalBtn.frame) - _genderImgView.height +margin;


}
-(void)personalBtnDidClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PersonalBtnDidClick" object:nil];
}
@end
