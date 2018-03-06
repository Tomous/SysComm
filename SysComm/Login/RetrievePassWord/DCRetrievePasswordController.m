//
//  DCRetrievePasswordController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCRetrievePasswordController.h"
#import "DCLoginView.h"
#import "DCLoginViewController.h"
#define margin 5
@interface DCRetrievePasswordController ()<UITextFieldDelegate>{

//    UITextField *_userNameTextField;
//    UITextField *_NumberTextField;
    UIButton *loginBtn;
    UILabel *checkLabel;
    UIImageView *inputImageView;
    UILabel *userNameLabel;
    UILabel *numberNameLabel;
    UILabel *IDCardLabel;
    DCAlertLabel *alertLabel;
}
//@property(nonatomic,strong)UITextField *_userNameTextField;
@property(nonatomic,strong)UIImageView *backImageView;
@end

@implementation DCRetrievePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loginView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesture)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)loginView
{
    self.view.backgroundColor = DCColor(82.0, 82.0, 82.0);
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
    //    backImageView.image = [UIImage imageNamed:@"u2_normal.png"];
    backImageView.backgroundColor = DCColor(34.0, 186.0, 190.0);
    [self.view addSubview:backImageView];
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.width = 78;
    logoImageView.x = (self.view.width - logoImageView.width) / 2;
    logoImageView.height = 78;
    logoImageView.y = 20;
    logoImageView.image = [UIImage imageNamed:@"用户登录logo"];
    [backImageView addSubview:logoImageView];
    
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 35, self.view.width, 40)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.text = NSLocalizedString(@"LOST_PASSWORD", nil);
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:loginLabel];

    
    NSString *strr = NSLocalizedString(@"ERROR_INFO_INCORRECT", nil);
    CGSize maxSize = CGSizeMake(self.view.width - 30, 50);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    CGSize size = [strr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    alertLabel = [[DCAlertLabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(loginLabel.frame), size.width, size.height)];
    [alertLabel setUpAlertLabelWithImageName:@"登录错误提示.png" alertTitle:strr];
    alertLabel.hidden = YES;
    [self.view addSubview:alertLabel];
    
    /**
     用户名
     */
    UIView *userNameView = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(alertLabel.frame) + 5, self.view.width - margin *2, 40)];
    userNameView.backgroundColor = [UIColor whiteColor];
    userNameView.layer.cornerRadius = 7;
    userNameView.layer.masksToBounds = YES;
    [self.view addSubview:userNameView];
    userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, userNameView.height)];
    userNameLabel.backgroundColor = [UIColor whiteColor];
    userNameLabel.textColor = DCTextColor;
    userNameLabel.font = [UIFont systemFontOfSize:16];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.text = NSLocalizedString(@"FULLNAME", nil);
    [userNameView addSubview:userNameLabel];
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(userNameLabel.width, 0, self.view.width - userNameLabel.width - margin *2, userNameView.height)];
    _userNameTextField.backgroundColor = [UIColor whiteColor];
    _userNameTextField.delegate = self;
    _userNameTextField.placeholder = NSLocalizedString(@"CAPTION_FULLNAME", nil);
    _userNameTextField.font = [UIFont systemFontOfSize:13];
    _userNameTextField.textColor = DCTextFieldColor;
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [userNameView addSubview:_userNameTextField];
    /**
     手机号
     */
    UIView *numberNameView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(userNameView.frame) + 18, self.view.width - 10, 40)];
    numberNameView.backgroundColor = [UIColor whiteColor];
    numberNameView.layer.cornerRadius = 7;
    numberNameView.layer.masksToBounds = YES;
    [self.view addSubview:numberNameView];
    numberNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, numberNameView.height)];
    numberNameLabel.backgroundColor = [UIColor whiteColor];
    numberNameLabel.text = NSLocalizedString(@"CELL_NUM", nil);
    numberNameLabel.textColor = DCTextColor;
    numberNameLabel.font = [UIFont systemFontOfSize:16];
    numberNameLabel.textAlignment = NSTextAlignmentCenter;
    [numberNameView addSubview:numberNameLabel];
    _NumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(numberNameLabel.width, 0, self.view.width - 10 - numberNameLabel.width, numberNameView.height)];
    _NumberTextField.backgroundColor = [UIColor whiteColor];
    _NumberTextField.placeholder = NSLocalizedString(@"CAPTION_CELL_NUM", nil);
    _NumberTextField.font = [UIFont systemFontOfSize:13];
    _NumberTextField.delegate = self;
    _NumberTextField.keyboardType = UIKeyboardTypePhonePad;
    _NumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    _NumberTextField.textColor = DCTextFieldColor;
    [numberNameView addSubview:_NumberTextField];
    /**
     身份证号
     */
    UIView *IDCardView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(numberNameView.frame) + 18, self.view.width - 10, 40)];
    IDCardView.backgroundColor = [UIColor whiteColor];
    IDCardView.layer.cornerRadius = 7;
    IDCardView.layer.masksToBounds = YES;
    [self.view addSubview:IDCardView];
    
    IDCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, IDCardView.height)];
    IDCardLabel.backgroundColor = [UIColor whiteColor];
    IDCardLabel.textColor = DCTextColor;
    IDCardLabel.font = [UIFont systemFontOfSize:16];
    IDCardLabel.textAlignment = NSTextAlignmentCenter;
    IDCardLabel.text = NSLocalizedString(@"IDNUM", nil);
    [IDCardView addSubview:IDCardLabel];
    
    _IDCardTextField = [[UITextField alloc]initWithFrame:CGRectMake(IDCardLabel.width, 0, self.view.width - 10 - IDCardLabel.width, IDCardView.height)];
    _IDCardTextField.backgroundColor = [UIColor whiteColor];
    _IDCardTextField.placeholder = NSLocalizedString(@"CAPTION_IDNUM", nil);
    _IDCardTextField.font = [UIFont systemFontOfSize:13];
    _IDCardTextField.delegate = self;
    _IDCardTextField.textColor = DCTextFieldColor;
    _IDCardTextField.keyboardType = UIKeyboardTypePhonePad;
    _IDCardTextField.clearButtonMode = UITextFieldViewModeAlways;
    [IDCardView addSubview:_IDCardTextField];
    /**
     验证码输入框
     */
    _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(IDCardView.frame) + 17, self.view.width / 3, 40)];
    _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    _inputTextField.backgroundColor = [UIColor whiteColor];
    inputImageView = [[UIImageView alloc]init];
    inputImageView.width = _inputTextField.width / 6;
    inputImageView.height= inputImageView.width;
    inputImageView.image = [UIImage imageNamed:@"登录错误提示.png"];
    inputImageView.hidden = YES;
    _inputTextField.rightView = inputImageView;
    _inputTextField.rightViewMode = UITextFieldViewModeAlways;
    _inputTextField.placeholder = NSLocalizedString(@"CAPTION_RECAPTCHA", nil);
    _inputTextField.textColor = DCTextFieldColor;
    _inputTextField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_inputTextField];
    
    _codeView = [[DCCodeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_inputTextField.frame) + 10, _inputTextField.y +3, self.view.width / 4, 34)];
    _codeView.backgroundColor = kRandomColor;
    [self.view addSubview:_codeView];
    
    
    UIButton *checkBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_codeView.frame) +10, _codeView.y, self.view.width / 3, 34)];
    [checkBtn2 setTitle:NSLocalizedString(@"RECAPTCHA_REFRESH", nil) forState:UIControlStateNormal];
    [checkBtn2 setTitleColor:DCTextColor forState:UIControlStateNormal];
    checkBtn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBtn2 addTarget:self action:@selector(checkBtn2DidCkick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn2];
    
    loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_inputTextField.frame) +20, self.view.width - 10, 50)];
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"u1251_normal.png"] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.backgroundColor = DCColor(204.0, 255.0, 255.0);
    [loginBtn setTitle:NSLocalizedString(@"LOGIN", nil) forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtn2DidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *backPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loginBtn.frame) + 15, self.view.width, 25)];
    [backPassWordBtn setTitle:NSLocalizedString(@"BACK", nil) forState:UIControlStateNormal];
    backPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backPassWordBtn setTitleColor:DCTextColor forState:UIControlStateNormal];
    [backPassWordBtn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backPassWordBtn];
    
    
    
}

#pragma mark methods


-(void)checkBtn2DidCkick
{

    [_codeView checkCodeBtnDidClick];

}

-(void)loginBtn2DidClick
{
    if ([_inputTextField.text isEqualToString:_codeView.changeString] || [_inputTextField.text isEqualToString:[_codeView.changeString lowercaseString]]) {
        
        alertLabel.hidden = YES;
        inputImageView.hidden = YES;

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"name"] = _userNameTextField.text;
        params[@"mobile"] = _NumberTextField.text;
        params[@"card"] = _IDCardTextField.text;
    
        [DCHttpTool postWithUrl:GetFindPasswd_URL params:params success:^(id responseObject) {
            if ([responseObject[@"error"]integerValue] == 0) {
                
//                [MBProgressHUD showError:@"您的密码已重置，请查看短信！"];
                
                DCLoginViewController *loginVC = [[DCLoginViewController alloc]init];

                [self presentViewController:loginVC animated:YES completion:nil];
            }
            else
            {
                
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"error"];
        }];
        
    }
    else{
        
        alertLabel.hidden = NO;
        [self checkBtn2DidCkick];
        _inputTextField.text = nil;
        inputImageView.hidden = NO;
        
    }
    
}

-(void)backBtnDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardAppear:(NSNotification *)noti
{
    [UIView animateWithDuration:2.5 animations:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = -100;
        self.view.frame = frame;
    }];
    
}
-(void)keyboardHide:(NSNotification *)noti
{
    [UIView animateWithDuration:2.5 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
}

-(void)gesture
{
    DCLog(@"gesture");
    
    [_inputTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    [_NumberTextField resignFirstResponder];
    [_IDCardTextField resignFirstResponder];
}

@end