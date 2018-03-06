//
//  DCPersonalController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/13.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCPersonalController.h"
#import "DCPasswordChangeController.h"
#import "DCAlertView.h"
#import "DCLoginViewController.h"
#import "DCDataModel.h"
#import "DCResponseModel.h"
#import "DCPersonalModel.h"
#import "DCDataModel.h"
#import "UIImageView+WebCache.h"
#import "DCAccountTool.h"
#import "DCPersonalHeaderView.h"

#define kPersonalImagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kPersonalImage.data"]

#define margin 5

@interface DCPersonalController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    UIView *navView;
    UITextField *phoneNumberTextField;
    UIButton *phoneNumBtn1;
    UIButton *phoneNumBtn2;
    UIButton *phoneNumBtn3;
    
    UITextField *weiChatNumberTextField;
    UIButton *weiChatNumBtn1;
    UIButton *weiChatNumBtn2;
    UIButton *weiChatNumBtn3;
    
    UITextField *QQNumberTextField;
    UIButton *QQNumBtn1;
    UIButton *QQNumBtn2;
    UIButton *QQNumBtn3;
    
    UILabel *alertLabel;
    UIButton *coverBtn;
    UIView *settingView;
    UIView *coverView;
    DCAlertView *alertView;
    UIImageView *alertImg;
    UIView *yanzhengView;
    UIButton *yanzhengBtn;
    UIButton *sendCodeBtn;
    dispatch_source_t _timer;
    UIView *animationView;
    UIImageView *phoneImageView;
    UIView *lineView1;
    UIImageView *duigouImg;
    UILabel *telephoneNumLabel;
    UILabel *telephoneNumLabel2;
    UITextField *inputField;
    UILabel *label;
    UIImageView *img;
    DCPersonalModel *person;
    DCPersonalHeaderView *headerView;
    DCAlertLabel *promptLabel;
}

@end

@implementation DCPersonalController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(phoneNumberDidChange:) name:@"PHONENUMBERTEXT" object:nil];
    //点击头像接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personalBtnDidClick) name:@"PersonalBtnDidClick" object:nil];
    
    [self setUpNavigation];

    [self setUpNumberView];
    
    self.view.userInteractionEnabled = YES;
    
    [self loadPersonalMessage];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - setUpMainView
-(void)setUpNavigation
{
    UIView *batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    batteryView.backgroundColor = DCColor(82.0, 82.0, 82.0);
    [self.view addSubview:batteryView];
    
    //导航条
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, batteryView.height, self.view.width, 50)];
    navView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [self.view addSubview:navView];
    
    
    UILabel *personalLabel = [[UILabel alloc]init];
    personalLabel.width = navView.width / 2;
    personalLabel.x = (navView.width - personalLabel.width) / 2;
    personalLabel.y = margin;
    personalLabel.height = navView.height - margin *2;
    personalLabel.text = NSLocalizedString(@"PROFILE", nil);
    personalLabel.textAlignment = NSTextAlignmentCenter;
    personalLabel.textColor = [UIColor whiteColor];
    [navView addSubview:personalLabel];
    
    UIButton *settingBtn = [[UIButton alloc]init];
    settingBtn.height = personalLabel.height;
    settingBtn.width = settingBtn.height;
    settingBtn.x = navView.width - settingBtn.width - margin;
    settingBtn.y = margin;
    [settingBtn setImage:[UIImage imageNamed:@"顶部操作栏左边菜单按钮@3x.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:settingBtn];
    

    //用户头像布局
    headerView = [[DCPersonalHeaderView alloc]init];
    headerView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    headerView.width = self.view.width;
    headerView.height = (self.view.height - batteryView.height - navView.height - 50) / 2;
    headerView.y = CGRectGetMaxY(navView.frame) + 1;
    
    [self.view addSubview:headerView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewGesture)];
    [headerView addGestureRecognizer:gestureRecognizer];
    

}
/**
 *  电话，微信，QQ页面布局
 */
-(void)setUpNumberView
{
    //用户手机号码
    phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin * 3, CGRectGetMaxY(headerView.frame) + margin, 20, 45 - margin *2)];
    phoneImageView.contentMode = UIViewContentModeCenter;
    phoneImageView.image = [UIImage imageNamed:@"手机@2x.png"];
    [self.view addSubview:phoneImageView];
    
    phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImageView.frame) + margin *2, CGRectGetMaxY(headerView.frame) + margin, self.view.width - phoneImageView.width - 70, phoneImageView.height)];
    phoneNumberTextField.enabled = NO;
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTextField.delegate = self;
    phoneNumberTextField.textColor = DCTextFieldColor;
    [self.view addSubview:phoneNumberTextField];
    
    /**
     手机号后面的button
     */
    phoneNumBtn1 = [[UIButton alloc]init];
    phoneNumBtn1.backgroundColor = [UIColor whiteColor];
    phoneNumBtn1.width = phoneNumberTextField.height;
    phoneNumBtn1.height = phoneNumBtn1.width;
    phoneNumBtn1.x = self.view.width - phoneNumBtn1.width;
    phoneNumBtn1.y = phoneNumberTextField.y;
    [phoneNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－没点击之前浅绿笔"] forState:UIControlStateNormal];
    [phoneNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－点击之后深绿笔"] forState:UIControlStateHighlighted];
    [phoneNumBtn1 addTarget:self action:@selector(phoneNumBtnOneDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumBtn1];

    phoneNumBtn2 = [[UIButton alloc]initWithFrame:phoneNumBtn1.frame];
    phoneNumBtn2.backgroundColor = [UIColor whiteColor];
    phoneNumBtn2.hidden = YES;
    phoneNumBtn2.enabled = NO;
    [phoneNumBtn2 setImage:[UIImage imageNamed:@"个人资料-编辑之前的灰对勾-拷贝@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:phoneNumBtn2];
    
    phoneNumBtn3 = [[UIButton alloc]initWithFrame:phoneNumBtn1.frame];
    phoneNumBtn3.backgroundColor = [UIColor whiteColor];
    phoneNumBtn3.hidden = YES;
    [phoneNumBtn3 setImage:[UIImage imageNamed:@"个人资料-编辑之后的红对勾@3x.png"] forState:UIControlStateNormal];
    [phoneNumBtn3 addTarget:self action:@selector(phoneNumBtn3DidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumBtn3];

    //   提示框
    alertImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"登录错误提示.png"]];
    alertImg.hidden = YES;
    alertImg.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberTextField.frame), 20, 0);
    [self.view addSubview:alertImg];
    
    alertLabel = [[UILabel alloc]init];
    alertLabel.backgroundColor = [UIColor whiteColor];
    alertLabel.alpha = 0.8;
    alertLabel.numberOfLines = 0;
    alertLabel.textAlignment = NSTextAlignmentLeft;
    alertLabel.textColor = [UIColor redColor];
    alertLabel.hidden = YES;
    NSString *str = NSLocalizedString(@"ERROR_CELL_NUM_FORMAT_INCORRECT", nil);
    alertLabel.text = str;
    CGSize maxSize = CGSizeMake(self.view.width - 30, 80);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    alertLabel.frame = CGRectMake(20 + 25, alertImg.y, size.width, size.height);
    [self.view addSubview:alertLabel];
    
    
   
    //用户微信号
    animationView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneImageView.frame) +2, self.view.width, 110)];
    animationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:animationView];
    
    lineView1 = [[UIView alloc]initWithFrame:CGRectMake(margin, 0, animationView.width - margin, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    lineView1.alpha = 0.5;
    [animationView addSubview:lineView1];

    /**
      weiChat
     */
    UIImageView *weiChatView = [[UIImageView alloc]initWithFrame:CGRectMake(margin * 3, 1, 20, 45 - margin *2)];
    weiChatView.contentMode = UIViewContentModeCenter;
    weiChatView.image = [UIImage imageNamed:@"微信@2x.png"];
    [animationView addSubview:weiChatView];

    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(weiChatView.frame) +2, self.view.width, 1)];
    lineView2.alpha = 0.5;
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [animationView addSubview:lineView2];

    weiChatNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weiChatView.frame) + margin *2, weiChatView.y, self.view.width - weiChatView.width - 70, 45 - margin *2)];
    weiChatNumberTextField.enabled = NO;
    weiChatNumberTextField.textColor = DCTextFieldColor;
    [animationView addSubview:weiChatNumberTextField];
    
    /**
     微信号后面的button
     */
    weiChatNumBtn1 = [[UIButton alloc]init];
    weiChatNumBtn1.width = weiChatNumberTextField.height;
    weiChatNumBtn1.height = weiChatNumBtn1.width;
    weiChatNumBtn1.x = self.view.width - weiChatNumBtn1.width;
    weiChatNumBtn1.y = weiChatNumberTextField.y;
    [weiChatNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－没点击之前浅绿笔"] forState:UIControlStateNormal];
    [weiChatNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－点击之后深绿笔"] forState:UIControlStateSelected];
    [weiChatNumBtn1 addTarget:self action:@selector(weiChatNumBtn1DidClick) forControlEvents:UIControlEventTouchUpInside];
    [animationView addSubview:weiChatNumBtn1];
    
    weiChatNumBtn2 = [[UIButton alloc]initWithFrame:weiChatNumBtn1.frame];
    weiChatNumBtn2.hidden = YES;
    [weiChatNumBtn2 setImage:[UIImage imageNamed:@"个人资料-编辑之前的灰对勾-拷贝@2x.png"] forState:UIControlStateNormal];
    weiChatNumBtn2.enabled = NO;
    [animationView addSubview:weiChatNumBtn2];
    
    weiChatNumBtn3 = [[UIButton alloc]initWithFrame:weiChatNumBtn1.frame];
    weiChatNumBtn3.hidden = YES;
    [weiChatNumBtn3 setImage:[UIImage imageNamed:@"个人资料-编辑之后的红对勾@3x.png"] forState:UIControlStateNormal];
    [weiChatNumBtn3 addTarget:self action:@selector(weiChatNumBtn3DidClick) forControlEvents:UIControlEventTouchUpInside];
    [animationView addSubview:weiChatNumBtn3];
    
    //QQ号
    UIImageView *QQNumberView = [[UIImageView alloc]initWithFrame:CGRectMake(margin * 3, CGRectGetMaxY(lineView2.frame) + margin, 20, 45 - margin *2)];
    QQNumberView.contentMode = UIViewContentModeCenter;
    QQNumberView.image = [UIImage imageNamed:@"QQ@2x.png"];
    [animationView addSubview:QQNumberView];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(QQNumberView.frame) +2, self.view.width, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    lineView3.alpha = 0.5;
    [animationView addSubview:lineView3];

    
    QQNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(QQNumberView.frame)+ margin *2, QQNumberView.y, self.view.width - QQNumberView.width - 70, 45 - margin *2)];
    QQNumberTextField.enabled = NO;
    QQNumberTextField.delegate = self;
    QQNumberTextField.textColor = DCTextFieldColor;
//    QQNumberTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [animationView addSubview:QQNumberTextField];
    
    /**
     qq后面的button
     */
    QQNumBtn1 = [[UIButton alloc]init];
    QQNumBtn1.backgroundColor = [UIColor whiteColor];
    QQNumBtn1.width = QQNumberTextField.height;
    QQNumBtn1.height = QQNumBtn1.width;
    QQNumBtn1.x = self.view.width - QQNumBtn1.width;
    QQNumBtn1.y = QQNumberTextField.y;
    [QQNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－没点击之前浅绿笔"] forState:UIControlStateNormal];
    [QQNumBtn1 setImage:[UIImage imageNamed:@"讯通个人资料－点击之后深绿笔"] forState:UIControlStateHighlighted];
    [QQNumBtn1 addTarget:self action:@selector(QQNumBtn1DidClick) forControlEvents:UIControlEventTouchUpInside];
    [animationView addSubview:QQNumBtn1];
    
    QQNumBtn2 = [[UIButton alloc]initWithFrame:QQNumBtn1.frame];
    QQNumBtn2.backgroundColor = [UIColor whiteColor];
    QQNumBtn2.hidden = YES;
    QQNumBtn2.enabled = NO;
    [QQNumBtn2 setImage:[UIImage imageNamed:@"个人资料-编辑之前的灰对勾-拷贝@2x.png"] forState:UIControlStateNormal];
    [animationView addSubview:QQNumBtn2];
    
    QQNumBtn3 = [[UIButton alloc]initWithFrame:QQNumBtn1.frame];
    QQNumBtn3.backgroundColor = [UIColor whiteColor];
    QQNumBtn3.hidden = YES;
    [QQNumBtn3 setImage:[UIImage imageNamed:@"个人资料-编辑之后的红对勾@3x.png"] forState:UIControlStateNormal];
    [QQNumBtn3 addTarget:self action:@selector(QQNumBtn3DidClick) forControlEvents:UIControlEventTouchUpInside];
    [animationView addSubview:QQNumBtn3];
    

}

#pragma mark - methods
-(void)loadPersonalMessage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    
    [DCHttpTool postWithUrl:GetMyMessage_URL params:params success:^(id responseObject) {
        
        DCLog(@"个人资料里面请求的数据为---%@",responseObject[@"response"]);
        person = [DCPersonalModel objectWithKeyValues:responseObject[@"response"]];
        headerView.nameLabel.text = person.relname;
        headerView.groupLabel.text = person.group_job[@"group"][@"1"][@"gname"];
        phoneNumberTextField.text = person.mobile;
        weiChatNumberTextField.text = person.weixin;
        QQNumberTextField.text = person.qq;
        [headerView.personalImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",person.photos]]];
        if (person.sex == 0) {
            headerView.genderImgView.image = [UIImage imageNamed:@"个人资料－实心性别女图标@2x.png"];
        }else
        {
            headerView.genderImgView.image = [UIImage imageNamed:@"个人资料－实心性别男图标@2x.png"];
        }

    } failure:^(NSError *error) {
        
    }];
}
-(void)phoneNumberDidChange:(NSNotification *)noti
{
    person.mobile = noti.userInfo[@"phoneNumberText"];
}

/**
 *  点击设置按钮
 */
-(void)settingBtnDidClick
{
    DCLog(@"settingBtnDidClick");
    
    coverBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    coverBtn.backgroundColor = [UIColor lightGrayColor];
    coverBtn.alpha = 0.1;
    [coverBtn addTarget:self action:@selector(coverBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coverBtn];
    
    settingView = [[UIView alloc]init];
    settingView.backgroundColor = [UIColor whiteColor];
    
    UIButton *passWordBtn = [[UIButton alloc]init];
    passWordBtn.backgroundColor = [UIColor whiteColor];
    [passWordBtn setTitleColor:DCTextColor forState:UIControlStateNormal];
    [passWordBtn addTarget:self action:@selector(passwordBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [passWordBtn setBackgroundImage:[UIImage imageNamed:@"u1869_normal.png"] forState:UIControlStateHighlighted];
    
    
    NSString *PWDStr = NSLocalizedString(@"CHANGE_PASSWORD", nil);
    [passWordBtn setTitle:PWDStr forState:UIControlStateNormal];
    
    CGSize PWDMaxSize = CGSizeMake(200, 50);
    NSDictionary *PWDDict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    CGFloat pwdWidth = [PWDStr boundingRectWithSize:PWDMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:PWDDict context:nil].size.width;
    
    
    settingView.frame = CGRectMake(self.view.width - pwdWidth, headerView.y, pwdWidth,self.view.width / 4);
    [self.view addSubview:settingView];
    passWordBtn.frame = CGRectMake(0, 0, settingView.width, settingView.height / 2);
    passWordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [settingView addSubview:passWordBtn];
    
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = DCTextFieldColor;
    lineView.width = settingView.width - 4;
    lineView.height = 1;
    lineView.x = 2;
    lineView.alpha = 0.5;
    lineView.y = CGRectGetMaxY(passWordBtn.frame);
    [settingView addSubview:lineView];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(passWordBtn.frame) + 1, settingView.width, passWordBtn.height - 1)];
    [logoutBtn setTitle:NSLocalizedString(@"LOGOUT", nil) forState:UIControlStateNormal];
    [logoutBtn setTitleColor:DCTextColor forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutBtn setBackgroundImage:[UIImage imageNamed:@"u1869_normal.png"] forState:UIControlStateHighlighted];
    [logoutBtn addTarget:self action:@selector(logoutBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [settingView addSubview:logoutBtn];
    
}

-(void)coverBtnDidClick
{
    [coverBtn removeFromSuperview];
    [settingView removeFromSuperview];
}

/**
 *  点击电话号码后面的✏️
 */
-(void)phoneNumBtnOneDidClick
{
    if ([weiChatNumberTextField becomeFirstResponder]) {
        weiChatNumberTextField.layer.borderWidth = 0.0;
        weiChatNumberTextField.text = person.weixin;
        [self WeiChatBtnPencil];
    }
    if ([QQNumberTextField becomeFirstResponder]) {
        QQNumberTextField.layer.borderWidth = 0.0;
        QQNumberTextField.text = person.qq;
        [self QQbtnPencil];
    }
    
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumberTextField.enabled = YES;
    phoneNumberTextField.text = nil;
    [self phoneBtnGrayColor];
   
    //让textField开始编辑
    [phoneNumberTextField becomeFirstResponder];
    phoneNumberTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    phoneNumberTextField.layer.borderWidth = 0.8;
    
    //监听textField里面的内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumTextFieldChange:) name:UITextFieldTextDidChangeNotification object:phoneNumberTextField];
    
}

- (void)phoneNumTextFieldChange:(NSNotification *)noti
{
    if ([phoneNumberTextField.text length] == 11) {
        if ([phoneNumberTextField.text isEqualToString:person.mobile]) {
            DCLog(@"两次输入的手机号相同");
            [self phoneBtnGrayColor];
        }
        else
        {
            [self phoneBtnRedColor];
        }
    }
    else
    {
        [self phoneBtnGrayColor];
    }
}

/**
 *  当手机号码后面变成红色对勾后触发的方法
 */
-(void)phoneNumBtn3DidClick
{
    //正则表达式
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9])|(1)[0-9][0-9])\\d{8}$";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pre evaluateWithObject:phoneNumberTextField.text];
    
    if (isMatch) {
        
        [self setUpYanzhengView];
        [phoneNumberTextField resignFirstResponder];
        
        alertLabel.hidden = YES;
        alertImg.hidden = YES;
        [UIView animateWithDuration:1.5 animations:^{
            
            alertLabel.height = 0;
            alertImg.height = 0;
            animationView.y = CGRectGetMaxY(phoneImageView.frame) +2;
        }];
    }
    else
    {
        alertLabel.hidden = NO;
        alertImg.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{

            NSString *str = NSLocalizedString(@"ERROR_CELL_NUM_FORMAT_INCORRECT", nil);
            CGSize maxSize = CGSizeMake(self.view.width - 30, 80);
            NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
            CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;

            alertLabel.height = size.height;
            alertImg.height = 20;
            animationView.y = CGRectGetMaxY(phoneImageView.frame) + alertLabel.height;
        }];
    }
}

/**
 *  获取验证码的页面
 */
-(void)setUpYanzhengView
{
    coverBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    coverBtn.backgroundColor = [UIColor lightGrayColor];
    coverBtn.alpha = 0.7;
    [self.view addSubview:coverBtn];
    
    yanzhengView = [[UIView alloc]init];
    yanzhengView.width = self.view.width - margin *2;
    yanzhengView.height = self.view.height / 3 + 20;
    yanzhengView.x = margin;
    yanzhengView.y = (self.view.height - yanzhengView.height) / 2;
    [self.view addSubview:yanzhengView];
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yanzhengView.width, yanzhengView.height / 4 - 20)];
    firstView.backgroundColor = [UIColor blackColor];
    [yanzhengView addSubview:firstView];
    
    UILabel *yanzhengNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 0, firstView.width / 2, firstView.height)];
    yanzhengNumLabel.textColor = [UIColor whiteColor];
    yanzhengNumLabel.text = NSLocalizedString(@"VERIFY_CELL_NUM", nil);//验证手机号码
    [firstView addSubview:yanzhengNumLabel];
    
    UIButton *exitButton = [[UIButton alloc]init];
    exitButton.height = firstView.height;
    exitButton.width = exitButton.height;
    exitButton.y = 0;
    exitButton.x = firstView.width - margin - exitButton.width;
    [exitButton setImage:[UIImage imageNamed:@"验证手机号码-红框里面的叉@3x.png"] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exitButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:exitButton];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.width = yanzhengView.width;
    secondView.height = yanzhengView.height - firstView.height;
    secondView.x = 0;
    secondView.y = CGRectGetMaxY(firstView.frame);
    secondView.backgroundColor = [UIColor whiteColor];
    [yanzhengView addSubview:secondView];
    
            duigouImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"蓝色错误提示.png"]];
    duigouImg = [[UIImageView alloc]init];
    duigouImg.image = [UIImage imageNamed:@"蓝色错误提示.png"];
    duigouImg.frame = CGRectMake(margin, margin *2 -4, firstView.height - margin * 2 - 5, firstView.height - margin * 2 - 5);
    [secondView addSubview:duigouImg];
    
    telephoneNumLabel = [[UILabel alloc]init];
    telephoneNumLabel.numberOfLines = 0;
    telephoneNumLabel.textColor = DCTextColor;
    NSString *strr = NSLocalizedString(@"PROMPT_VERIFY_CELL_NUM", nil);
    telephoneNumLabel.text = strr;
    CGSize maxSize = CGSizeMake(yanzhengView.width - 20, 75);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size = [strr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    telephoneNumLabel.frame = CGRectMake(CGRectGetMaxX(duigouImg.frame), duigouImg.y, size.width, size.height);
    [secondView addSubview:telephoneNumLabel];
    
    telephoneNumLabel2 = [[UILabel alloc]init];
    telephoneNumLabel2.hidden = YES;
    telephoneNumLabel2.numberOfLines = 0;
    telephoneNumLabel2.textColor = DCTextColor;
    NSString *strr2 = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"PROMPT_VERIFY_CODE_SEND", nil),phoneNumberTextField.text];
    telephoneNumLabel2.text = strr2;
    CGSize size4 = [strr2 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    telephoneNumLabel2.frame = CGRectMake(CGRectGetMaxX(duigouImg.frame), duigouImg.y, size4.width, size4.height);
    [secondView addSubview:telephoneNumLabel2];

    
    
    UILabel *inputYanZheng = [[UILabel alloc]init];
    inputYanZheng.x = margin;
    inputYanZheng.y = CGRectGetMaxY(telephoneNumLabel2.frame) +3;
    inputYanZheng.width = secondView.width / 3;
    inputYanZheng.height = 30;
    inputYanZheng.textColor = DCTextColor;
    inputYanZheng.textAlignment = NSTextAlignmentCenter;
    inputYanZheng.font = [UIFont systemFontOfSize:14];
    inputYanZheng.text = NSLocalizedString(@"CAPTION_VERIFY_CODE", nil);//请填写6位验证码
    [secondView addSubview:inputYanZheng];
    
    inputField = [[UITextField alloc]init];
    inputField.x = CGRectGetMaxX(inputYanZheng.frame);
    inputField.y = inputYanZheng.y;
    inputField.width = secondView.width / 3;
    inputField.height = inputYanZheng.height;
    inputField.placeholder = NSLocalizedString(@"CAPTION_VERIFY_CODE", nil);
    inputField.textColor = DCTextFieldColor;
    inputField.font = [UIFont systemFontOfSize:12];
    inputField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    inputField.layer.borderWidth = 0.8;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextFieldLength) name:UITextFieldTextDidChangeNotification object:nil];
    [secondView addSubview:inputField];
    
    sendCodeBtn = [[UIButton alloc]init];
    sendCodeBtn.width = secondView.width / 3 - margin *4;
    sendCodeBtn.x = secondView.width - sendCodeBtn.width - margin *2;
    sendCodeBtn.y = inputField.y;
    sendCodeBtn.height = inputField.height;
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendCodeBtn setTitle:NSLocalizedString(@"OBTAIN_VERIFY_CODE", nil) forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendCodeBtn.backgroundColor = DCColor(70.0, 159.0, 222.0);
    [sendCodeBtn addTarget:self action:@selector(sendCodeBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:sendCodeBtn];
    
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(inputField.frame) + 2, 20, 20)];
    img.image = [UIImage imageNamed:@"登录错误提示.png"];
    img.hidden = YES;
    [secondView addSubview:img];
    
    label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.hidden = YES;
    NSString *strr3 = NSLocalizedString(@"ERROR_RECAPTCHA_INCORRECT", nil);
    label.text = strr3;
    CGSize size2 = [strr3 boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    label.frame = CGRectMake(CGRectGetMaxX(img.frame), img.y, size2.width, size2.height);
    [secondView addSubview:label];

    
    yanzhengBtn = [[UIButton alloc]init];
    yanzhengBtn.width = secondView.width / 5;
    yanzhengBtn.height = 40;
    yanzhengBtn.x = (secondView.width - yanzhengBtn.width) / 2;
    yanzhengBtn.y = CGRectGetMaxY(label.frame) +3;
    yanzhengBtn.layer.cornerRadius = 6;
    yanzhengBtn.layer.masksToBounds = YES;
    yanzhengBtn.enabled = NO;
    [yanzhengBtn setBackgroundImage:[UIImage imageNamed:@"u194_normal.png"] forState:UIControlStateNormal];
    [yanzhengBtn setTitle:NSLocalizedString(@"VERIFY", nil) forState:UIControlStateNormal];
    [yanzhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yanzhengBtn addTarget:self action:@selector(yanzhengBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:yanzhengBtn];
    

}
/**
 * 发送验证码
 */
-(void)sendCodeBtnDidClick
{
    /**
     *   从后台获取验证码
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"mobile"] = phoneNumberTextField.text;
    
    [DCHttpTool postWithUrl:GetYanzheng_URL params:params success:^(id responseObject) {
        
        if ([responseObject[@"error"]integerValue] == 0) {

            duigouImg.image = [UIImage imageNamed:@"验证手机号码绿圈对勾"];
            telephoneNumLabel2.hidden = NO;
            telephoneNumLabel.hidden = YES;
        }
    } failure:^(NSError *error) {
        
    }];
    DCLog(@"yanzhengBtnDidClick");
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sendCodeBtn setTitle:NSLocalizedString(@"RESEND", nil) forState:UIControlStateNormal];
                [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sendCodeBtn.userInteractionEnabled = YES;
                
            });
        }
        else
        {
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                sendCodeBtn.userInteractionEnabled = NO;
                [sendCodeBtn setTitle:[NSString stringWithFormat:@"(%@)",strTime] forState:UIControlStateNormal];
                [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}

/**
 *  验证成功
 */
-(void)yanzhengBtnDidClick
{
    DCLog(@" yanzhengBtnDidClick");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"mobile"] = phoneNumberTextField.text;
    params[@"code"] = inputField.text;
    
    [DCHttpTool postWithUrl:GetUpdateMobile_URL params:params success:^(id responseObject) {
        
        if ([responseObject[@"error"] integerValue] == 0) {
            
            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_CELL_NUM_MODIFIED", nil)];
            img.hidden = YES;
            label.hidden = YES;
            
            
            if (_timer) {
                
                dispatch_source_cancel(_timer);
            }
            coverBtn.hidden = YES;
            yanzhengView.hidden = YES;
            [self phoneBtnPencil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"PHONENUMBERTEXT" object:nil userInfo:@{@"phoneNumberText":phoneNumberTextField.text}];
            phoneNumberTextField.layer.borderWidth = 0.0;
            [phoneNumberTextField resignFirstResponder];
            [inputField resignFirstResponder];
            
        }
        if ([responseObject[@"error"] integerValue] == 50003 || [responseObject[@"error"]integerValue] == 50007) {
            
//            [MBProgressHUD showError:NSLocalizedString(@"ERROR_NO_RESULT_FOUND", nil)];
            img.hidden = NO;
            label.hidden = NO;
            
        }
        if ([responseObject[@"error"] integerValue] == 50008) {

            [MBProgressHUD showError:NSLocalizedString(@"ERROR_NUM_EXIST", nil)];
        }

    } failure:^(NSError *error) {
        
    }];
}
/**
 *  开始编辑微信号
 */
-(void)weiChatNumBtn1DidClick
{
    if (alertImg.height == 20) {
        
        alertImg.hidden = YES;
        alertLabel.hidden = YES;
        alertLabel.height = 0;
        alertImg.height = 0;
        animationView.y = CGRectGetMaxY(phoneImageView.frame) +2;
    }
    if ([QQNumberTextField becomeFirstResponder]) {
        QQNumberTextField.layer.borderWidth = 0.0;
        QQNumberTextField.text = person.qq;
        [self QQbtnPencil];
    }
    if ([phoneNumberTextField becomeFirstResponder])
    {
        phoneNumberTextField.layer.borderWidth = 0.0;
        phoneNumberTextField.text = person.mobile;
        [self phoneBtnPencil];
    }
    DCLog(@"weiChatNumBtn1DidClick");
    weiChatNumberTextField.enabled = YES;
    weiChatNumberTextField.text = nil;
    //开始编辑
    [weiChatNumberTextField becomeFirstResponder];
    weiChatNumberTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    weiChatNumberTextField.layer.borderWidth = 0.8;
    
    [self WeiChatBtnGrayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiChatTextFieldChange:) name:UITextFieldTextDidChangeNotification object:weiChatNumberTextField];

}

-(void)weiChatTextFieldChange:(NSNotification *)noti
{
    if ([weiChatNumberTextField.text length] >= 3) {
        
        [self WeiChatBtnRedColor];
    }
    else
    {
        [self WeiChatBtnGrayColor];

    }
    
}
/**
 *  点击修改微信号
 */
-(void)weiChatNumBtn3DidClick
{
    NSMutableDictionary *weiChatParam = [NSMutableDictionary dictionary];
    weiChatParam[@"token"] = [DCResponseModel shareResponse].token;
    weiChatParam[@"suid"] = [DCDataModel shareDataModel].uid;
    weiChatParam[@"weixin"] = weiChatNumberTextField.text;
    
    [DCHttpTool postWithUrl:GetUpdateWeixin_URL params:weiChatParam success:^(id responseObject) {
        if ([responseObject[@"error"] integerValue] == 0) {
            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_WECHAT_NUM_MODIFIED", nil)];
            [self WeiChatBtnPencil];
            person.weixin = weiChatNumberTextField.text;
            weiChatNumberTextField.enabled = NO;
            weiChatNumberTextField.layer.borderWidth = 0.0;
        }
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  开始编辑qq号
 */
-(void)QQNumBtn1DidClick
{
    if (alertImg.height == 20) {
        alertImg.hidden = YES;
        alertLabel.hidden = YES;
        alertLabel.height = 0;
        alertImg.height = 0;
        animationView.y = CGRectGetMaxY(phoneImageView.frame) +2;
    }
    if ([weiChatNumberTextField becomeFirstResponder]) {
        weiChatNumberTextField.layer.borderWidth = 0.0;
        weiChatNumberTextField.text = person.weixin;

        [self WeiChatBtnPencil];
    }
    if ([phoneNumberTextField becomeFirstResponder]) {
        phoneNumberTextField.layer.borderWidth = 0.0;
        phoneNumberTextField.text = person.mobile;

        [self phoneBtnPencil];
    }
    QQNumberTextField.enabled = YES;
    QQNumberTextField.text = nil;
    // 开始编辑
    [QQNumberTextField becomeFirstResponder];
    QQNumberTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    QQNumberTextField.layer.borderWidth = 0.8;
    
    [self QQbtnGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQNumTextFieldChang:) name:UITextFieldTextDidChangeNotification object:QQNumberTextField];
}

-(void)QQNumTextFieldChang:(NSNotification *)noti
{
    if ([QQNumberTextField.text length] >= 3 && [QQNumberTextField.text length] <= 10) {
        [self QQbtnRedColor];
    }
    else
    {
        [self QQbtnGrayColor];
    }
}
/**
 *  修改QQ号
 */
-(void)QQNumBtn3DidClick
{
    NSMutableDictionary *QQParams = [NSMutableDictionary dictionary];
    QQParams[@"token"] = [DCResponseModel shareResponse].token;
    QQParams[@"suid"] = [DCDataModel shareDataModel].uid;
    QQParams[@"qq"] = QQNumberTextField.text;
    
    [DCHttpTool postWithUrl:GetUpdateQQ_URL params:QQParams success:^(id responseObject) {
        if ([responseObject[@"error"] integerValue] == 0) {
            [MBProgressHUD showError:NSLocalizedString(@"PRMOPT_QQ_NUM_MODIFIED", nil)];
            [self QQbtnPencil];
            person.qq = QQNumberTextField.text;
            QQNumberTextField.enabled = NO;
            QQNumberTextField.layer.borderWidth = 0.0;
            [self loadPersonalMessage];
        }
    } failure:^(NSError *error) {
        
    }];

}
/**
 *  点击跳转修改密码控制器
 */
-(void)passwordBtnDidClick
{
    [self coverBtnDidClick];
    DCPasswordChangeController *passwordVC  = [[DCPasswordChangeController alloc]init];
    [self presentViewController:passwordVC animated:YES completion:nil];
    
}
/**
 *  退出登录
 */
-(void)logoutBtnDidClick
{
    DCLog(@"logoutBtnDidClick");
    [self coverBtnDidClick];
    
    coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    coverView.backgroundColor = [UIColor lightGrayColor];
    coverView.alpha = 0.6;
    UITapGestureRecognizer *coverViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewTapGestureDidClick)];
    [coverView addGestureRecognizer:coverViewTapGesture];
    [self.view addSubview:coverView];

    alertView = [[DCAlertView alloc]init];
    alertView.width = self.view.width - margin *2;
    alertView.height = self.view.height / 4;
    alertView.x = margin;
    alertView.y = (self.view.height - alertView.height) / 2;
    
    __weak DCPersonalController *weakSelf = self;
    [alertView setTitleLabel:NSLocalizedString(@"LOGOUT", nil) alertTitle:NSLocalizedString(@"PROMPT_LOGOUT", nil) exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnTitle:NSLocalizedString(@"YES",@"") handleEnsureBlock:^{

        DCLoginViewController *loginVC = [[DCLoginViewController alloc]init];
//        [DCResponseModel shareResponse].token = nil;
//        [DCDataModel shareDataModel].uid = nil;
        [DCAccountTool deleteToken:[DCResponseModel shareResponse].token];
        [weakSelf presentViewController:loginVC animated:YES completion:nil];
        
    } handleExitBlock:^{
        
        DCLog(@"exit");
        [weakSelf tapGestureDidClick];
    }];
    
    [self.view addSubview:alertView];
    
}

-(void)coverViewTapGestureDidClick
{
    DCLog(@"coverViewTapGestureDidClick");
    [self tapGestureDidClick];
}
/**
 *  获取验证码右上角的叉
 */
-(void)exitButtonDidClick
{
    if (_timer) {

        dispatch_source_cancel(_timer);
    }
    [inputField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
    phoneNumberTextField.text = person.mobile;
    [self phoneBtnPencil];
    coverBtn.hidden = YES;
    yanzhengView.hidden = YES;
    
    phoneNumberTextField.enabled = NO;
    weiChatNumberTextField.enabled = NO;
    QQNumberTextField.enabled = NO;
}
-(void)tapGestureDidClick
{
    coverView.hidden = YES;
    
    [alertView removeFromSuperview];
}
/**
 *  监听键盘弹出和隐藏
 */
-(void)keyBoardAppear:(NSNotification *)noti
{
    [UIView animateWithDuration:2.5 animations:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = -100;
        self.view.frame = frame;
    }];
    
}
-(void)keyBoardHidden:(NSNotification *)noti
{
    [UIView animateWithDuration:2.5 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    QQNumberTextField.layer.borderWidth = 0.0;
    weiChatNumberTextField.layer.borderWidth = 0.0;
    phoneNumberTextField.layer.borderWidth = 0.0;
    
    [self phoneBtnPencil];
    [self QQbtnPencil];
    [self WeiChatBtnPencil];
    
    if (alertImg.height == 20) {
        alertImg.hidden = YES;
        alertLabel.hidden = YES;
        alertLabel.height = 0;
        alertImg.height = 0;
        animationView.y = CGRectGetMaxY(phoneImageView.frame) + 2;
    }
    
}
-(void)headerViewGesture
{
    DCLog(@"headerViewGesture");
    [phoneNumberTextField resignFirstResponder];
    [weiChatNumberTextField resignFirstResponder];
    [QQNumberTextField resignFirstResponder];
    /**
     *  当错误弹框出现后，点击区域外，还原手机号，弹框消失
     */
    weiChatNumberTextField.text = person.weixin;
    weiChatNumberTextField.enabled = NO;
    [self WeiChatBtnPencil];
    
    QQNumberTextField.text = person.qq;
    QQNumberTextField.enabled = NO;
    [self QQbtnPencil];
    
    phoneNumberTextField.text = person.mobile;
    phoneNumberTextField.enabled = NO;
    [self phoneBtnPencil];
    
    if (alertImg.height == 20) {
        alertImg.hidden = YES;
        alertLabel.hidden = YES;
        alertLabel.height = 0;
        alertImg.height = 0;
        animationView.y = CGRectGetMaxY(phoneImageView.frame) + 3;
    }
}
/**
 *  打开相册
 */
-(void)personalBtnDidClick
{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: NSLocalizedString(@"USE_CAMERA", nil), NSLocalizedString(@"CHOOSE_PHOTOS", nil),nil];
    [myActionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self localPhoto];
            break;
        default:
            break;
    }
}
/**
 *  打开相册
 */
-(void)localPhoto
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
}
/**
 *  打开照相机
 */
-(void)takePhoto
{
    DCLog(@"takePhoto");
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;// 前置摄像头
        [self presentViewController:picker animated:YES completion:nil];
        //        [self presentModalViewController:picker animated:YES];
    }else {
        NSLog(@"该设备无摄像头");
        [MBProgressHUD showError:NSLocalizedString(@"ERROR_NO_CAMERA_DETECTED", nil)];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //拿到选择的图片
    UIImage * photoImg = info[UIImagePickerControllerOriginalImage];
    
    [self performSelector:@selector(savePersonalImage:) withObject:photoImg afterDelay:0.5];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)savePersonalImage:(UIImage *)image
{
    headerView.personalImgView.image = image;
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    success = [fileManager fileExistsAtPath:kPersonalImagePath];
    
    if(success) {
        success = [fileManager removeItemAtPath:kPersonalImagePath error:&error];
    }
    
    UIImage *smallImage = [self setImage:image fillSize:CGSizeMake(1000.0f, 1000.0f)];
    [UIImageJPEGRepresentation(smallImage, 10.0f) writeToFile:kPersonalImagePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:kPersonalImagePath];//读取图片文件
    headerView.personalImgView.image = selfPhoto;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imageData = UIImageJPEGRepresentation(selfPhoto, 0.001);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"data16"] = imageData;
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"method"] = @"avatar";
    params[@"device"] = @"ios";
    
    [DCHttpTool postWithUrl:GetPersonalPhoto_URL params:params success:^(id responseObject) {
        
        DCPersonalModel *personal = [DCPersonalModel objectWithKeyValues:responseObject[@"response"]];
        
        [DCDataModel shareDataModel].photos = personal.url;
        
    } failure:^(NSError *error) {
        
    }];
}

//返回填充的缩略图
- (UIImage *) setImage: (UIImage *) image fillSize: (CGSize) viewsize
{
    CGSize size = image.size;
    
    CGFloat scalex = viewsize.width / size.width;
    CGFloat scaley = viewsize.height / size.height;
    CGFloat scale = MAX(scalex, scaley);
    
    UIGraphicsBeginImageContext(viewsize);
    
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    
    float dwidth = ((viewsize.width - width) / 2.0f);
    float dheight = ((viewsize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    [image drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

-(void)inputTextFieldLength
{
    if ([inputField.text length] == 6) {
        yanzhengBtn.enabled = YES;
    }
    else
    {
        yanzhengBtn.enabled = NO;
    }
}

-(void)QQbtnPencil
{
    QQNumBtn1.hidden = NO;
    QQNumBtn2.hidden = YES;
    QQNumBtn3.hidden = YES;
}
-(void)QQbtnRedColor
{
    QQNumBtn1.hidden = YES;
    QQNumBtn2.hidden = YES;
    QQNumBtn3.hidden = NO;
}
-(void)QQbtnGrayColor
{
    QQNumBtn1.hidden = YES;
    QQNumBtn2.hidden = NO;
    QQNumBtn3.hidden = YES;
}

-(void)phoneBtnPencil
{
    phoneNumBtn1.hidden = NO;
    phoneNumBtn2.hidden = YES;
    phoneNumBtn3.hidden = YES;
}
-(void)phoneBtnRedColor
{
    phoneNumBtn1.hidden = YES;
    phoneNumBtn2.hidden = YES;
    phoneNumBtn3.hidden = NO;
}
-(void)phoneBtnGrayColor
{
    phoneNumBtn1.hidden = YES;
    phoneNumBtn2.hidden = NO;
    phoneNumBtn3.hidden = YES;
}
-(void)WeiChatBtnPencil
{
    weiChatNumBtn1.hidden = NO;
    weiChatNumBtn2.hidden = YES;
    weiChatNumBtn3.hidden = YES;
}
-(void)WeiChatBtnRedColor
{
    weiChatNumBtn1.hidden = YES;
    weiChatNumBtn2.hidden = YES;
    weiChatNumBtn3.hidden = NO;
}
-(void)WeiChatBtnGrayColor
{
    weiChatNumBtn1.hidden = YES;
    weiChatNumBtn2.hidden = NO;
    weiChatNumBtn3.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
