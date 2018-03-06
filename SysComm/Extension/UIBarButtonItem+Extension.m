//
//  UIBarButtonItem+Extension.m
//  包子微博
//
//  Created by 尚承教育 on 15/6/4.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)creatBarButtonItemWithNorImageName:(NSString *)norImageName higImageName:(NSString *)higImageName target:(id)target active:(SEL)action
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    
    Btn.size = Btn.currentImage.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
}

@end
