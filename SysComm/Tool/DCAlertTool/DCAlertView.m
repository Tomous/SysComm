//
//  DCAlertView.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/16.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCAlertView.h"
#define kMargin 5
@implementation DCAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setTitleLabel:(NSString *)titleLabel alertTitle:(NSString *)alertTitle exitBtnImg:(NSString *)exitBtnImage btnTitle:(NSString *)btnTitle handleEnsureBlock:(HANDLE_ensure)ensure handleExitBlock:(HANDLE_exit)exit
{
        
    self.ensure = ensure;
    self.exit = exit;
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = DCColor(45.0, 45.0, 45.0);
    titleView.width = self.width;
    titleView.height = self.height / 4;
    titleView.x = 0;
    titleView.y = 0;
    [self addSubview:titleView];
    
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, titleView.width / 2, titleView.height)];
    titleText.text = titleLabel;
    titleText.textColor = [UIColor whiteColor];
    [titleView addSubview:titleText];

    UIButton *exitBtn = [[UIButton alloc]init];
//    exitBtn.backgroundColor = [UIColor whiteColor];
    exitBtn.height = titleView.height;
    exitBtn.width = exitBtn.height;
    exitBtn.x = titleView.width - exitBtn.width - kMargin;
    exitBtn.y = 0;
    [exitBtn setImage:[UIImage imageNamed:exitBtnImage] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:exitBtn];
    
    UIView *alertView = [[UIView alloc]init];
    alertView.width = self.width;
    alertView.height = self.height - titleView.height;
    alertView.x = 0;
    alertView.y = CGRectGetMaxY(titleView.frame);
    alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:alertView];
    
    UILabel *alertText = [[UILabel alloc]init];
    alertText.width = alertView.width;
    alertText.height = alertView.height / 3;
    alertText.y = kMargin * 3;
    alertText.font = [UIFont systemFontOfSize:18];
    alertText.textColor = DCTextColor;
    alertText.text = alertTitle;
    alertText.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:alertText];
    
    UIButton *ensureBtn = [[UIButton alloc]init];
    ensureBtn.layer.cornerRadius = 6;
    ensureBtn.layer.masksToBounds = YES;
//    [ensureBtn setBackgroundImage:[UIImage imageNamed:@"u194_normal.png"] forState:UIControlStateNormal];
    ensureBtn.backgroundColor = DCColor(33.0, 184.0, 188.0);
    ensureBtn.width = alertView.width / 4;
    ensureBtn.height = alertText.height;
    ensureBtn.x = (alertView.width - ensureBtn.width) / 2;
    ensureBtn.y = alertView.height - kMargin *3 - ensureBtn.height;
    [ensureBtn setTitle:btnTitle forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(ensureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [alertView addSubview:ensureBtn];
    
}

-(void)setTitleLabel:(NSString *)titleLabel alertTitle:(NSString *)alertTitle exitBtnImg:(NSString *)exitBtnImage btnImg:(NSString *)btnImg selImg:(NSString *)selImg handleEnsureBlock:(HANDLE_ensure)ensure handleExitBlock:(HANDLE_exit)exit
{
    self.ensure = ensure;
    self.exit = exit;
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = DCColor(45.0, 45.0, 45.0);
    titleView.width = self.width;
    titleView.height = self.height / 4;
    titleView.x = 0;
    titleView.y = 0;
    [self addSubview:titleView];
    
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, titleView.width / 2 + 100, titleView.height)];
    titleText.text = titleLabel;
    titleText.textColor = [UIColor whiteColor];
    [titleView addSubview:titleText];
    
    UIButton *exitBtn = [[UIButton alloc]init];
    //    exitBtn.backgroundColor = [UIColor whiteColor];
    exitBtn.height = titleView.height;
    exitBtn.width = exitBtn.height;
    exitBtn.x = titleView.width - exitBtn.width - kMargin;
    exitBtn.y = 0;
    [exitBtn setImage:[UIImage imageNamed:exitBtnImage] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:exitBtn];
    
    UIView *alertView = [[UIView alloc]init];
    alertView.width = self.width;
    alertView.height = self.height - titleView.height;
    alertView.x = 0;
    alertView.y = CGRectGetMaxY(titleView.frame);
    alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:alertView];
    
    UILabel *alertText = [[UILabel alloc]init];
//    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    NSDictionary *dict = @{NSFontAttributeName :[UIFont systemFontOfSize:15]};
//    CGSize size = [alertText.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    alertText.numberOfLines = 0;
    
    alertText.width = alertView.width;
    alertText.height = alertView.height /2;
    alertText.y = kMargin * 2;
    alertText.font = [UIFont systemFontOfSize:22];
//        alertText.backgroundColor = [UIColor redColor];
    alertText.textColor = DCTextColor;
    alertText.text = alertTitle;
    alertText.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:alertText];
    
    UIButton *ensureBtn = [[UIButton alloc]init];
    ensureBtn.layer.cornerRadius = 6;
    ensureBtn.layer.masksToBounds = YES;
    ensureBtn.width = alertView.width / 6;
    ensureBtn.height = titleView.height;
    ensureBtn.x = (alertView.width - ensureBtn.width) / 2;
    ensureBtn.y = alertView.height - kMargin *3 - ensureBtn.height;
    [ensureBtn setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
    [ensureBtn setImage:[UIImage imageNamed:selImg] forState:UIControlStateHighlighted];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(ensureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [alertView addSubview:ensureBtn];

}


-(void)ensureBtnDidClick
{
    self.ensure();
}

-(void)exitBtnDidClick
{
    self.exit();
}
@end
