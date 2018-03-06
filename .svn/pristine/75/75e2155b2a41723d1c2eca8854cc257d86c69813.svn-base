//
//  DCAlertLabel.m
//  MaxScreenContacts
//
//  Created by maxscrenn on 15/12/29.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCAlertLabel.h"

@implementation DCAlertLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setUpAlertLabelWithImageName:(NSString *)imageName alertTitle:(NSString *)title
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:imageName];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    NSString *str = title;
    label.text = str;
    label.textColor = [UIColor redColor];
    label.frame = CGRectMake(CGRectGetMaxX(imageView.frame), 5, self.width - 5, self.height);
    [self addSubview:label];
}

@end
