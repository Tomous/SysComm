//
//  DCRefreshView.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/12/3.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCRefreshView.h"

@interface DCRefreshView ()

@property(nonatomic,strong)UILabel *shuaxinLabel;

@property(nonatomic,strong)UIActivityIndicatorView *activity;

@end
@implementation DCRefreshView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *shuaxinLabel = [[UILabel alloc]init];
//        shuaxinLabel.backgroundColor = [UIColor whiteColor];
        shuaxinLabel.text = NSLocalizedString(@"PROMPT_LOADING", nil);
        shuaxinLabel.textColor = DCTextColor;
        shuaxinLabel.font = [UIFont systemFontOfSize:14];
        self.shuaxinLabel = shuaxinLabel;
        shuaxinLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:shuaxinLabel];
        
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerrrr) userInfo:nil repeats:YES];
//        [timer fire];


        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.color = [UIColor grayColor];
        activity.autoresizingMask = self.autoresizingMask;
        [activity startAnimating];
        self.activity = activity;
        [self addSubview:activity];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView animateWithDuration:2.3 animations:^{
        self.shuaxinLabel.width = self.width / 2;
    }];
    self.shuaxinLabel.height = 30;
    self.shuaxinLabel.y = 130;
    self.shuaxinLabel.x = (self.width - self.shuaxinLabel.width) / 2 + 35;
    
    self.activity.center = CGPointMake(100, 145);

}
@end
