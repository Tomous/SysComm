//
//  DCLoginViewController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCLoginViewController.h"
#import "DCLoginView.h"
#import "DCRetrievePasswordController.h"
//#import "DCPersonPlistController.h"
#import "DCResponseModel.h"
#import "DCDataModel.h"
#import "DCGroupModel.h"
#import "DCRefreshView.h"
#import "DCPersonalController.h"
#import "DCControllerTool.h"
#import "DCTabBarViewController.h"
@interface DCLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)DCRefreshView *refreshView;
@end

@implementation DCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLoginView];
    
    //找回密码接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassWordBtnDidClick) name:@"DCloginBtnNotificationCenter" object:nil];
    //点击登录按钮接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginBtnDidClick) name:@"DCloginBtnDidClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ddd) name:@"dddd" object:nil];
        
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setUpLoginView
{
    _loginView = [[DCLoginView alloc]init];
    _loginView.width = self.view.width;
    _loginView.height = self.view.height;
    [self.view addSubview:_loginView];

}

#pragma mark - methods

-(void)ddd
{
    
    if ([_loginView.userTextField.text isEqualToString:@""] || [_loginView.passWordTextField.text isEqualToString:@""] || [_loginView.inputTextField.text isEqualToString:@""]) {
        
        _loginView.loginBtn.enabled = NO;
        _loginView.loginBtn.backgroundColor = DCColor(235.0, 235.0, 235.0);
    }
    else
    {
        _loginView.loginBtn.enabled = YES;
        _loginView.loginBtn.backgroundColor = DCColor(204.0, 255.0, 255.0);
    }
}
//判断email格式
-(BOOL)isValidateEmail:(NSString *)email

{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

-(void)LoginBtnDidClick
{
    DCLog(@"LoginBtnDidClick");
    //正则表达式
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9])|(1)[0-9][0-9])\\d{8}$";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pre evaluateWithObject:_loginView.userTextField.text];
    
    if (isMatch || [self isValidateEmail:_loginView.userTextField.text]) {
        
        _loginView.pointLabel2.hidden = YES;
        _loginView.pointImg.hidden = YES;
        if ([_loginView.passWordTextField.text length] <= 6) {
         
            [self pointLabel3];
        }
        else
        {
            _loginView.pointLabel3.hidden = YES;
            _loginView.pointImg.hidden = YES;

            //判断手机号，密码，验证码是否正确
            if ([_loginView.inputTextField.text isEqualToString:_loginView.codeView.changeString] || [_loginView.inputTextField.text isEqualToString:[_loginView.codeView.changeString lowercaseString]]) {
                
                // 验证码输入正确
                _loginView.pointLabel.hidden = YES;
                _loginView.pointImg.hidden = YES;
                _loginView.inputImageView.hidden = YES;
                
                [self loadPersonalMessage];
            }
            else{
                
                // 验证码输入错误
                [self pointLabel1];
                
                //刷新验证码
                [_loginView.codeView checkCodeBtnDidClick];
                _loginView.inputTextField.text = nil;
                _loginView.inputImageView.hidden = NO;
            }
        }

    }
    else
    {
        [self pointLabel2];
    }
}

-(void)loadPersonalMessage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = _loginView.userTextField.text;
    params[@"password"] = _loginView.passWordTextField.text;
    
    
    [DCHttpTool postWithUrl:GetLogin_URL params:params success:^(id responseObject) {
        
        CGFloat errorNum = [responseObject[@"error"] integerValue];
        
        if (errorNum == 50011) {
            //您已离职
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"You have left", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDestructive handler:nil];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
           
        }else if (errorNum == 50004 || errorNum == 50006 ) {
        // VC_ALERT(@"提示", @"账号密码错误，请重新输入！",@"确定");
//            [MBProgressHUD showError:NSLocalizedString(@"ERROR_ACCOUNT_INCORRECT", nil)];
            [self pointLabel4];
            
        }else if (errorNum == 0) {
            /**
             验证成功跳转，判断是否是第一次使用，1：跳转到修改密码VC  0：跳转通讯录VC
             */
            DCResponseModel *responseModel = [DCResponseModel objectWithKeyValues:responseObject[@"response"]];
            
            [DCResponseModel shareResponse].token = responseModel.token;
            
            DCDataModel *dataModel = [DCDataModel objectWithKeyValues:responseObject[@"response"][@"data"]];
            [DCDataModel shareDataModel].uid = dataModel.uid;
            [DCDataModel shareDataModel].mobile = dataModel.mobile;
            [DCDataModel shareDataModel].weixin = dataModel.weixin;
            [DCDataModel shareDataModel].qq = dataModel.qq;
            [DCDataModel shareDataModel].photos = dataModel.photos;
            [DCDataModel shareDataModel].relname = dataModel.relname;
            [DCDataModel shareDataModel].sex = dataModel.sex;
            [DCDataModel shareDataModel].group = dataModel.group_job[@"group"];
            
            DCLog(@"我的部门是－－－%@",dataModel.group_job[@"group"]);
            
            [DCResponseModel shareResponse].access_expired = responseModel.access_expired;
            
//            DCPersonPlistController *DCPersonPlistVC = [[DCPersonPlistController alloc]init];
            DCTabBarViewController *tabBarVC = [[DCTabBarViewController alloc]init];
            // 1 存储token和用户uid
            [DCAccountTool saveToken:responseModel.token];
            [DCAccountTool saveSuid:dataModel.uid];
            
            //存储用户账号
            [DCAccountTool saveUser:_loginView.userTextField.text];
            //储存用户密码
            [DCAccountTool savePassWD:_loginView.passWordTextField.text];
            //储存用户名
            [DCAccountTool saveUserName:dataModel.relname];
            
            [self presentViewController:tabBarVC animated:YES completion:nil];
            
        }
        
    } failure:^(NSError *error) {
        
        DCLog(@"请求失败 %@---",error);
//        [MBProgressHUD showError:NSLocalizedString(@"ERROR_LOGIN_TIMEOUT", nil)];
        
    }];

}
/**
 *  找回密码界面
 */
-(void)PassWordBtnDidClick
{
    DCRetrievePasswordController *retrievePasswordVC = [[DCRetrievePasswordController alloc]init];
    [self presentViewController:retrievePasswordVC animated:YES completion:nil];
}

-(void)pointLabel1
{
    _loginView.pointLabel.hidden = NO;
    _loginView.pointLabel2.hidden = YES;
    _loginView.pointLabel3.hidden = YES;
    _loginView.pointLabel4.hidden = YES;
    _loginView.pointImg.hidden = NO;
}
-(void)pointLabel2
{
    _loginView.pointLabel.hidden = YES;
    _loginView.pointLabel2.hidden = NO;
    _loginView.pointLabel3.hidden = YES;
    _loginView.pointLabel4.hidden = YES;
    _loginView.pointImg.hidden = NO;
}
-(void)pointLabel3
{
    _loginView.pointLabel.hidden = YES;
    _loginView.pointLabel2.hidden = YES;
    _loginView.pointLabel3.hidden = NO;
    _loginView.pointLabel4.hidden = YES;
    _loginView.pointImg.hidden = NO;
}

-(void)pointLabel4
{
    _loginView.pointLabel.hidden = YES;
    _loginView.pointLabel2.hidden = YES;
    _loginView.pointLabel3.hidden = YES;
    _loginView.pointLabel4.hidden = NO;
    _loginView.pointImg.hidden = NO;

}

@end
