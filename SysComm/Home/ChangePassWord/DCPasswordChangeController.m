//
//  DCPasswordChangeController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/13.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCPasswordChangeController.h"
#import "DCDataModel.h"
#import "DCResponseModel.h"
//#import "DCLoginView.h"
#import "DCLoginViewController.h"
#define margin 5
@interface DCPasswordChangeController ()<UITextFieldDelegate>
{
    BOOL shadow;
    UIView          * navView;
    UITextField     * oldPasswordField;
    UITextField     * newPassWordField;
    UITextField     * againNewPassField;
    UIImageView     * showImgView;
    UIImageView     * firstView;
//    DCDataModel     * dataModel;
    DCResponseModel * responseModel;
    DCLoginView     *loginView;
    DCAlertLabel *alertLabel1;
    DCAlertLabel *alertLabel2;
    DCAlertLabel *alertLabel3;
    DCAlertLabel *alertLabel4;
}

@end

@implementation DCPasswordChangeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DCColor(239.0, 239.0, 244.0);
    
    [self setUpHeaderView];

    shadow = YES;
    [self setUpMainView];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesture)];
    [self.view addGestureRecognizer:gesture];
}

-(void)setUpMainView
{

    NSString *strr1 = NSLocalizedString(@"ERROR_INFO_PASSWD", nil);
    NSString *strr2 = NSLocalizedString(@"ERROR_PASSWD_LENGTH", nil);
    NSString *strr3 = NSLocalizedString(@"ERROR_NEWPASSWD_AND_OLDPASSWD", nil);
    NSString *strr4 = NSLocalizedString(@"ERROR_OLDPWD_AND_NEWPWD", nil);
    
    CGSize maxSize = CGSizeMake(self.view.width - 20, 50);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    CGSize size1 = [strr1 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGSize size2 = [strr2 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGSize size3 = [strr3 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGSize size4 = [strr4 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;

    alertLabel1 = [[DCAlertLabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(navView.frame), size1.width, size1.height)];
    [alertLabel1 setUpAlertLabelWithImageName:@"登录错误提示.png" alertTitle:strr1];
    alertLabel1.hidden = YES;
    [self.view addSubview:alertLabel1];

    
    alertLabel2 = [[DCAlertLabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(navView.frame), size2.width, size2.height)];
    [alertLabel2 setUpAlertLabelWithImageName:@"登录错误提示.png" alertTitle:strr2];
    alertLabel2.hidden = YES;
    [self.view addSubview:alertLabel2];
    
    alertLabel3 = [[DCAlertLabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(navView.frame), size3.width, size3.height)];
    [alertLabel3 setUpAlertLabelWithImageName:@"登录错误提示.png" alertTitle:strr3];
    alertLabel3.hidden = YES;
    [self.view addSubview:alertLabel3];
    
    alertLabel4 = [[DCAlertLabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(navView.frame), size4.width, size4.height)];
    [alertLabel4 setUpAlertLabelWithImageName:@"登录错误提示.png" alertTitle:strr4];
    alertLabel4.hidden = YES;
    [self.view addSubview:alertLabel4];


    
    UIView *oldPasswordView = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(alertLabel1.frame) +3, self.view.width - 10, 45)];
    oldPasswordView.backgroundColor = [UIColor whiteColor];
    oldPasswordView.layer.cornerRadius = 7;
    oldPasswordView.layer.masksToBounds = YES;
    [self.view addSubview:oldPasswordView];
    UILabel *oldPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 0, 90, 45)];
    oldPasswordLabel.backgroundColor = [UIColor whiteColor];
    oldPasswordLabel.textColor = DCTextColor;
    oldPasswordLabel.text = NSLocalizedString(@"CURRENT_PASSWORD", nil);
    oldPasswordLabel.font = [UIFont systemFontOfSize:14];
    oldPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [oldPasswordView addSubview:oldPasswordLabel];
    oldPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(oldPasswordLabel.width, 0, self.view.width - oldPasswordLabel.width - 10, 45)];
    oldPasswordField.backgroundColor = [UIColor whiteColor];
    oldPasswordField.delegate = self;
    oldPasswordField.textColor = DCTextFieldColor;
    oldPasswordField.placeholder = NSLocalizedString(@"CAPTION_CURRENT_PASSWORD", nil);
    oldPasswordField.secureTextEntry = YES;
    oldPasswordField.clearButtonMode = UITextFieldViewModeAlways;
    oldPasswordField.font = [UIFont systemFontOfSize:14];
    [oldPasswordView addSubview:oldPasswordField];
    
    
    UIView *newPassWordView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(oldPasswordView.frame) + 15, self.view.width - 10, 45)];
    newPassWordView.backgroundColor = [UIColor whiteColor];
    newPassWordView.layer.cornerRadius = 7;
    newPassWordView.layer.masksToBounds = YES;
    [self.view addSubview:newPassWordView];
    UILabel *newPassWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 0, oldPasswordLabel.width, 45)];
    newPassWordLabel.backgroundColor = [UIColor whiteColor];
    newPassWordLabel.textColor = DCTextColor;
    newPassWordLabel.text = NSLocalizedString(@"NEW_PASSWORD", nil);
    newPassWordLabel.textAlignment = NSTextAlignmentCenter;
    newPassWordLabel.font = [UIFont systemFontOfSize:14];
    [newPassWordView addSubview:newPassWordLabel];
    newPassWordField = [[UITextField alloc]initWithFrame:CGRectMake(newPassWordLabel.width, 0, self.view.width - 10 - newPassWordLabel.width, 45)];
    newPassWordField.backgroundColor = [UIColor whiteColor];
    newPassWordField.delegate = self;
    newPassWordField.textColor = DCTextFieldColor;
    newPassWordField.placeholder = NSLocalizedString(@"CAPTION_NEW_PASSWORD", nil);
    newPassWordField.secureTextEntry = YES;
    newPassWordField.clearButtonMode = UITextFieldViewModeAlways;
    newPassWordField.font = [UIFont systemFontOfSize:14];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newPassWdFieldDidchange) name:UITextFieldTextDidChangeNotification object:nil];
    [newPassWordView addSubview:newPassWordField];
    
    
    UIView *againNewPassView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(newPassWordView.frame) + 15, self.view.width - 10, 45)];
    againNewPassView.backgroundColor = [UIColor whiteColor];
    againNewPassView.layer.cornerRadius = 7;
    againNewPassView.layer.masksToBounds = YES;
    [self.view addSubview:againNewPassView];
    UILabel *againNewPassLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 0, newPassWordLabel.width, 45)];
    againNewPassLabel.backgroundColor = [UIColor whiteColor];
    againNewPassLabel.textColor = DCTextColor;
    againNewPassLabel.font = [UIFont systemFontOfSize:14];
    againNewPassLabel.text = NSLocalizedString(@"REPEAT_PASSWORD", nil);
    againNewPassLabel.textAlignment = NSTextAlignmentCenter;
    [againNewPassView addSubview:againNewPassLabel];
    
    againNewPassField = [[UITextField alloc]initWithFrame:CGRectMake(againNewPassLabel.width, 0, self.view.width - 10 - againNewPassLabel.width, 45)];
    againNewPassField.backgroundColor = [UIColor whiteColor];
    againNewPassField.delegate = self;
    againNewPassField.textColor = DCTextFieldColor;
    againNewPassField.placeholder = NSLocalizedString(@"CAPTION_REPEAT_PASSWORD", nil);
    againNewPassField.secureTextEntry = YES;
    againNewPassField.font = [UIFont systemFontOfSize:14];
    againNewPassField.clearButtonMode = UITextFieldViewModeAlways;
    [againNewPassView addSubview:againNewPassField];
    
    UILabel *showBtn = [[UILabel alloc]init];
    showBtn.width = self.view.width / 4;
//    showBtn.backgroundColor = [UIColor redColor];
    showBtn.height = 30;
    showBtn.y = CGRectGetMaxY(againNewPassView.frame) + 25;
    showBtn.x = self.view.width - showBtn.width * 2;
    showBtn.textAlignment = NSTextAlignmentRight;
    showBtn.text = NSLocalizedString(@"SHOW_PASSWORD", nil);
    showBtn.font = [UIFont systemFontOfSize:13];
    showBtn.textColor = DCTextColor;
    [self.view addSubview:showBtn];
    
    showImgView = [[UIImageView alloc]init];
    showImgView.image = [UIImage imageNamed:@"u1040_normal.png"];
    showImgView.width = showBtn.width - 25;
    showImgView.height = showBtn.height;
    showImgView.x = CGRectGetMaxX(showBtn.frame) + margin;
    showImgView.y = showBtn.y;
    [self.view addSubview:showImgView];
    
    firstView = [[UIImageView alloc]init];
    firstView.image = [UIImage imageNamed:@"u1107_normal.png"];
    firstView.width = showBtn.width - 40;
    firstView.height = showImgView.height;
    firstView.x = showImgView.width - firstView.width;
    firstView.y = 0;
    [showImgView addSubview:firstView];
    
    
    UIButton *clickBtn = [[UIButton alloc]init];
//    clickBtn.backgroundColor = [UIColor yellowColor];
    clickBtn.width = showBtn.width + showImgView.width;
    clickBtn.x = self.view.width - clickBtn.width;
    clickBtn.y = showBtn.y;
    clickBtn.height = 30;
    [clickBtn addTarget:self action:@selector(showBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    UIButton *changePasswordBtn = [[UIButton alloc]init];
    changePasswordBtn.width = self.view.width - margin *2;
    changePasswordBtn.height = 40;
    changePasswordBtn.y = CGRectGetMaxY(showBtn.frame) + 30;
    changePasswordBtn.x = margin;
    changePasswordBtn.layer.cornerRadius = 8;
    [changePasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePasswordBtn setTitle:NSLocalizedString(@"CHANGE", nil) forState:UIControlStateNormal];
//    [changePasswordBtn setBackgroundImage:[UIImage imageNamed:@"u1251_normal.png"] forState:UIControlStateNormal];
    changePasswordBtn.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [changePasswordBtn addTarget:self action:@selector(changePasswordBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePasswordBtn];
}

-(void)setUpHeaderView
{
    UIView *batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    batteryView.backgroundColor = DCColor(82.0, 82.0, 82.0);
    [self.view addSubview:batteryView];
    
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, batteryView.height, self.view.width, 50)];
    navView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [self.view addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.height = navView.height - margin *2;
    backBtn.y = margin;
    backBtn.x = margin;
    backBtn.width = backBtn.height;
    //    backBtn.backgroundColor = [UIColor greenColor];
    [backBtn setImage:[UIImage imageNamed:@"顶部栏左边左箭头@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    UILabel *personalLabel = [[UILabel alloc]init];
    personalLabel.width = navView.width / 2;
    personalLabel.x = (navView.width - personalLabel.width) / 2;
    personalLabel.y = margin;
    personalLabel.height = navView.height - margin *2;
    //    personalLabel.backgroundColor = [UIColor greenColor];
    personalLabel.text = NSLocalizedString(@"CHANGE", nil);
    personalLabel.textAlignment = NSTextAlignmentCenter;
    personalLabel.textColor = [UIColor whiteColor];
    [navView addSubview:personalLabel];
    
//    UIImageView *footerView = [[UIImageView alloc]init];
//    footerView.backgroundColor = DCColor(143.0, 106.0, 51.0);
//    footerView.width = self.view.width;
//    footerView.height = 50;
//    footerView.y = self.view.height - footerView.height;
//    [self.view addSubview:footerView];
//    
//    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, (footerView.height - 40)/2, footerView.width, 20)];
//    label1.textColor = DCColor(204.0, 204.0, 204.0);
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.font = [UIFont systemFontOfSize:11];
//    label1.text = NSLocalizedString(@"MAXSCREEN_LOGOING", @"");
//    [footerView addSubview:label1];
//    
//    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), footerView.width, 20)];
//    label2.textColor = DCColor(204.0, 204.0, 204.0);
//    label2.font = [UIFont systemFontOfSize:11];
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.text = @"\u00A9 Copyright 2015 MAXSCREEN.ALL Rights Reserved.";
//    [footerView addSubview:label2];
//
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - methods
-(void)showBtnDidClick
{
    DCLog(@" changePasswordBtnDidClick");
    if (shadow) {
        shadow = NO;
        oldPasswordField.secureTextEntry = NO;
        newPassWordField.secureTextEntry = NO;
        againNewPassField.secureTextEntry = NO;
        firstView.image = [UIImage imageNamed:@"u1042_normal.png"];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            firstView.x = 0;
        }];
    }
    else{
        
        shadow = YES;
        oldPasswordField.secureTextEntry = YES;
        newPassWordField.secureTextEntry = YES;
        againNewPassField.secureTextEntry = YES;
        firstView.image = [UIImage imageNamed:@"u1107_normal.png"];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            firstView.x = showImgView.width - firstView.width;
        }];

    }
    
}

-(void)changePasswordBtnDidClick
{
    DCLog(@"changePasswordBtnDidClick");
    if (![oldPasswordField.text isEqualToString:[DCAccountTool passWD]]) {
        alertLabel1.hidden = NO;
    }
    else
    {
        alertLabel1.hidden = YES;
        
        if ([newPassWordField.text length] < 6) {
            alertLabel2.hidden = NO;
        }
        else
        {
            alertLabel2.hidden = YES;
            if ([newPassWordField.text isEqualToString:oldPasswordField.text]) {
                alertLabel3.hidden = NO;
            }
            else
            {
                alertLabel3.hidden = YES;
                if ([newPassWordField.text isEqualToString:againNewPassField.text])
                {
                    alertLabel4.hidden = YES;
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"oldpasswd"] = oldPasswordField.text;
                    params[@"newpasswd"] = newPassWordField.text;
                    params[@"suid"] = [DCDataModel shareDataModel].uid;
                    params[@"token"] = [DCResponseModel shareResponse].token;
                    
                    DCLog(@"%@+++++++++",[DCResponseModel shareResponse].token);
                    DCLog(@"%@__________",[DCDataModel shareDataModel].uid);
                    
                    [DCHttpTool postWithUrl:GetChangePasswd_URL params:params success:^(id responseObject) {
                        
                        if ([responseObject[@"error"]integerValue] == 0) {
                            
                            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_PASSWORD_CHANGED", nil)];
                            //跳转登录界面
                            DCLoginViewController *loginVC = [[DCLoginViewController alloc]init];
                            [self presentViewController:loginVC animated:YES completion:nil];
                            
                        }
                        if ([responseObject[@"error"]integerValue] == 50005) {
                            
                        }
                        
                    } failure:^(NSError *error) {
                        
                        [MBProgressHUD showError:@"error"];
                    }];
                    
                }
                else{
                    
//                    VC_ALERT(nil, @"两次密码输入不一致，请重新输入！", @"ok");
                    alertLabel4.hidden = NO;
                }
                
            }
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self changePasswordBtnDidClick];
    return YES;
}
-(void)gesture
{
    DCLog(@"gesture");
    [oldPasswordField resignFirstResponder];
    [newPassWordField resignFirstResponder];
    [againNewPassField resignFirstResponder];
}
@end
