//
//  DCAlertView.h
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/16.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HANDLE_ensure)();

typedef void(^HANDLE_exit)();


//typedef void(^HANDLE_yanzheng)();

@interface DCAlertView : UIView

/**
 * alertView
 */

-(void)setTitleLabel:(NSString *)titleLabel alertTitle:(NSString *)alertTitle exitBtnImg:(NSString *)exitBtnImage btnTitle:(NSString *)btnTitle handleEnsureBlock:(HANDLE_ensure)ensure handleExitBlock:(HANDLE_exit)exit;

@property(nonatomic,copy)HANDLE_ensure ensure;
@property(nonatomic,copy)HANDLE_exit exit;

-(void)setTitleLabel:(NSString *)titleLabel alertTitle:(NSString *)alertTitle exitBtnImg:(NSString *)exitBtnImage btnImg:(NSString *)btnImg selImg:(NSString *)selImg handleEnsureBlock:(HANDLE_ensure)ensure handleExitBlock:(HANDLE_exit)exit;
/**
 * 验证码弹框
 */

//-(void)setTitleLabel:(NSString *)titleLabel alertTitle:(NSString *)alertTitle exitBtnImg:(NSString *)exitBtnImage btnTitle:(NSString *)btnTitle handleEnsureBlock:(HANDLE_yanzheng)yanzheng;









@end
