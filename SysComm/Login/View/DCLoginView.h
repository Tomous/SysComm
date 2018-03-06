//
//  DCLoginView.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCodeView.h"
@interface DCLoginView : UIView

@property(nonatomic,retain)UITextField *inputTextField;

@property(nonatomic,retain)UILabel *pointLabel;
@property(nonatomic,retain)UILabel *pointLabel2;
@property(nonatomic,retain)UILabel *pointLabel3;
@property(nonatomic,retain)UILabel *pointLabel4;


@property(nonatomic,retain)UIImageView *pointImg;
@property(nonatomic,retain)DCCodeView *codeView;

@property(nonatomic,retain)UIImageView *inputImageView;
@property(nonatomic,retain)UITextField *userTextField;
@property(nonatomic,retain)UITextField *passWordTextField;
@property(nonatomic,retain)UIButton *loginBtn;
@end
