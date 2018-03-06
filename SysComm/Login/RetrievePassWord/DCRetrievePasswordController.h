//
//  DCRetrievePasswordController.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCodeView.h"
@interface DCRetrievePasswordController : UIViewController

@property(nonatomic,retain)UITextField *inputTextField;
@property(nonatomic,retain)UITextField *userNameTextField;
@property(nonatomic,retain)UITextField *NumberTextField;
@property(nonatomic,retain)UITextField *IDCardTextField;

@property(nonatomic,strong)DCCodeView *codeView;

@end
