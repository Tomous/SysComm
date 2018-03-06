//
//  DCContactView.m
//  MaxScreenContacts
//
//  Created by maxscrenn on 15/12/25.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCContactView.h"

#define kMargin 15
@interface DCContactView ()


@end
@implementation DCContactView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn0 = [[UIButton alloc]init];
        btn0.backgroundColor = [UIColor whiteColor];
        self.btn0 = btn0;
        [self addSubview:btn0];
        
        UIButton *btn1 = [[UIButton alloc]init];
        btn1.backgroundColor = [UIColor whiteColor];
        self.btn1 = btn1;
        [self addSubview:btn1];

        UIButton *btn2 = [[UIButton alloc]init];
        btn2.backgroundColor = [UIColor whiteColor];
        self.btn2 = btn2;
        [self addSubview:btn2];

        UIButton *btn3 = [[UIButton alloc]init];
        btn3.backgroundColor = [UIColor whiteColor];
        self.btn3 = btn3;
        [self addSubview:btn3];

        UIButton *btn4 = [[UIButton alloc]init];
        btn4.backgroundColor = [UIColor whiteColor];
        self.btn4 = btn4;
        [self addSubview:btn4];

        UIButton *btn5 = [[UIButton alloc]init];
        btn5.backgroundColor = [UIColor whiteColor];
        self.btn5 = btn5;
        [self addSubview:btn5];

        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.btn0.width = (self.width - kMargin*4) / 3;
    self.btn0.height = self.btn0.width;
    self.btn0.x = kMargin;
    self.btn0.y = kMargin;
    self.btn0.layer.cornerRadius = self.btn0.width / 2;
    
    self.btn1.size = self.btn0.size;
    self.btn1.x = kMargin*2 + self.btn0.width;
    self.btn1.y = kMargin;
    self.btn1.layer.cornerRadius = self.btn0.width / 2;

    self.btn2.size = self.btn0.size;
    self.btn2.x = kMargin*3 + self.btn0.width *2;
    self.btn2.y = kMargin;
    self.btn2.layer.cornerRadius = self.btn0.width / 2;

    self.btn3.size = self.btn0.size;
    self.btn3.x = kMargin;
    self.btn3.y = kMargin*2 + self.btn0.height;
    self.btn3.layer.cornerRadius = self.btn0.width / 2;

    self.btn4.size = self.btn0.size;
    self.btn4.x = kMargin*2 + self.btn0.width;
    self.btn4.y = kMargin*2 + self.btn0.height;
    self.btn4.layer.cornerRadius = self.btn0.width / 2;


    self.btn5.size = self.btn0.size;
    self.btn5.x = kMargin*3 + self.btn0.width *2;
    self.btn5.y = kMargin*2 + self.btn0.height;
    self.btn5.layer.cornerRadius = self.btn0.width / 2;

}
@end
