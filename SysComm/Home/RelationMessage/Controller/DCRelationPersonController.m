//
//  DCRelationPersonController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/17.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCRelationPersonController.h"
#import "DCAlertView.h"
#import <MessageUI/MessageUI.h>
#import "DCUserLocalTool.h"
#import "DCRelationModel.h"
#define margin 5

#import "DCContactView.h"
@interface DCRelationPersonController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate>
{
    UIView *navView;
    UIView *personalView;
    UIImageView *locatImg;
    UIImageView *sexImgView;
    UILabel *nameLabel;
    UILabel *groupLabel;
    UIButton *personalBtn;
    UILabel *locatLabel;
    NSMutableDictionary *params;
    
    UIImageView *footerView;
    UIView *batteryView;
    
}
@property(nonatomic,strong)DCAlertView *alertView;
@property(nonatomic,strong)UIView *coverView;
@end

@implementation DCRelationPersonController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"tuid"] = self.friendModel.uid;

    DCLog(@"详情里面用户的id----%@",self.friendModel.uid);
    
    [DCUserLocalTool saveRecentFriend:self.friendModel];
    
    [DCUserLocalTool saveUsersUID:(NSArray *)self.friendModel.uid];
    
    [self setUpMainView];
    
    [self setUpContactView];

}
/**
 *  整体布局
 */

-(void)setUpMainView
{
    batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
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
    personalLabel.width = navView.width / 2 + 50;
    personalLabel.x = (navView.width - personalLabel.width) / 2;
    personalLabel.y = margin;
    personalLabel.height = navView.height - margin *2;
    personalLabel.text = NSLocalizedString(@"CONTACT_COLL", nil);
    personalLabel.textAlignment = NSTextAlignmentCenter;
    personalLabel.textColor = [UIColor whiteColor];
    [navView addSubview:personalLabel];

    /**
           投诉
     */
/*    UIButton *settingBtn = [[UIButton alloc]init];
        settingBtn.backgroundColor = [UIColor greenColor];
    settingBtn.height = personalLabel.height;
    settingBtn.width = settingBtn.height;
    settingBtn.x = navView.width - settingBtn.width - margin;
    settingBtn.y = margin;
    [settingBtn setImage:[UIImage imageNamed:@"顶部操作栏左边菜单按钮@3x.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:settingBtn];
 
// */

    personalView = [[UIView alloc]init];
    personalView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    personalView.width = self.view.width;
    personalView.height = (self.view.height - batteryView.height - navView.height - 70) / 2;
    personalView.y = CGRectGetMaxY(navView.frame) + 1;
    [self.view addSubview:personalView];
    
    /**
     名字
     */
    nameLabel = [[UILabel alloc]init];
    nameLabel.width = personalView.width;
    nameLabel.height = personalLabel.height / 2;
    nameLabel.y = personalView.height - nameLabel.height *3 - margin;
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
//    nameLabel.text = [NSString stringWithFormat:@"%@",[DCRelationModel shareRelations].relname];
    [personalView addSubview:nameLabel];
    /**
     部门
     */
    groupLabel = [[UILabel alloc]init];
    groupLabel.width = personalView.width;
    groupLabel.height = nameLabel.height;
    groupLabel.y = CGRectGetMaxY(nameLabel.frame);
    groupLabel.font = [UIFont systemFontOfSize:14];
    groupLabel.textColor = [UIColor whiteColor];
    groupLabel.textAlignment = NSTextAlignmentCenter;
//    groupLabel.text = [NSString stringWithFormat:@"%@",self.friendModel.group_job[@"group"]];
    [personalView addSubview:groupLabel];
    
    //个人头像
    personalBtn = [[UIButton alloc]init];
    personalBtn.height = personalView.height - nameLabel.height *3 - margin *2 -10;
    personalBtn.width = personalBtn.height;
    personalBtn.x = (personalView.width - personalBtn.width) / 2;
    personalBtn.y = margin;
    personalBtn.backgroundColor = [UIColor whiteColor];
    [personalBtn setImage:[UIImage imageNamed:@"联系同事-头像大圆@3x.png"] forState:UIControlStateNormal];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, personalBtn.width, personalBtn.height)];
    [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.friendModel.photos]]];
    [personalBtn addSubview:imgView];
    personalBtn.enabled = NO;
    personalBtn.layer.cornerRadius = personalBtn.width / 2;
    personalBtn.layer.masksToBounds = personalBtn.height / 2;
    [personalView addSubview:personalBtn];
    
    // 性别
    sexImgView = [[UIImageView alloc]init];
    sexImgView.backgroundColor = [UIColor colorWithRed:256.0 green:256.0 blue:256.0 alpha:0.5];
    sexImgView.width = (personalBtn.width - margin *4) / 3;
    sexImgView.height = sexImgView.width;
    sexImgView.layer.cornerRadius = sexImgView.width / 2;
    sexImgView.x = personalView.width / 2 + margin *2;
    sexImgView.y = CGRectGetMaxY(personalBtn.frame) - sexImgView.height +margin;
    sexImgView.contentMode = UIViewContentModeCenter;
    if (self.friendModel.sex == 0) {
        sexImgView.image = [UIImage imageNamed:@"联系同事－实心性别女图标@2x.png"];
    }
    else
    {
        sexImgView.image = [UIImage imageNamed:@"联系同事－实心性别男图标@2x.png"];
    }
    [personalView addSubview:sexImgView];

//    UIView *contactView = [[UIView alloc]init];
//    contactView.backgroundColor = [UIColor whiteColor];
//    contactView.width = self.view.width;
//    contactView.height = self.view.height - footerView.height - navView.height - batteryView.height - personalView.height;
//    contactView.y = CGRectGetMaxY(personalView.frame);
//    [self.view addSubview:contactView];
//    
    /**
        定位用户位置
     */
    locatImg = [[UIImageView alloc]init];
    locatImg.width = 20;
    locatImg.height = 20;
    locatImg.y = CGRectGetMaxY(groupLabel.frame);
    locatImg.contentMode = UIViewContentModeCenter;
    locatImg.image = [UIImage imageNamed:@"联系同事－定位图标@3x.png"];
    [personalView addSubview:locatImg];
    
    locatLabel = [[UILabel alloc]init];
    locatLabel.font = [UIFont systemFontOfSize:12];
    locatLabel.textColor = [UIColor whiteColor];
    [personalView addSubview:locatLabel];
    
    /**
     *  下面6个通讯按钮
     */
//    NSArray *norImgeArr = [NSArray arrayWithObjects:@"联系同事-灰色座机图标.png",@"灰色手机图标.png",@"灰色短信图标.png",@"联系同事-灰邮件-.png",@"联系同事-灰微信.png",@"联系同事-灰qq.png", nil];
//     NSArray *norImgeArr = [NSArray arrayWithObjects:@"联系同事-灰色座机图标.png",@"灰色手机图标.png",@"灰色短信图标.png",@"联系同事-灰邮件-.png",@"联系同事-灰微信.png", nil];
//    int totalRow = 3;
//    CGFloat kHeight = contactView.height / 2 -10;
//    CGFloat kWidth = (contactView.width - margin *5) / totalRow;
//    
//    for (int i = 0; i < norImgeArr.count; i ++) {
//        int row = i / totalRow;
//        int loc = i % totalRow;
//        
//        UIButton *btn = [[UIButton alloc]init];
//        btn.tag = i;
//        btn.width = kWidth - margin * 2;
//        btn.height = kWidth;
//        [btn setImage:[UIImage imageNamed:norImgeArr[i]] forState:UIControlStateNormal];
//        btn.x = margin *3 + (margin + kWidth) * loc;
//        btn.y = margin + (margin + kHeight) * row -4;
//        btn.layer.cornerRadius = kWidth / 2;
//        btn.layer.masksToBounds = YES;
//        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
//        [contactView addSubview:btn];
//    }


}
/**
 *  创建6个按钮坐标
 */
-(void)setUpContactView
{
    DCContactView *contactview = [[DCContactView alloc]init];
    contactview.backgroundColor = [UIColor whiteColor];
    contactview.width = self.view.width;
    contactview.height = self.view.height - footerView.height - navView.height - batteryView.height - personalView.height;
    contactview.y = CGRectGetMaxY(personalView.frame);
    [self.view addSubview:contactview];
    
    contactview.btn0.tag = 0;
    [contactview.btn0 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    contactview.btn1.tag = 1;
    [contactview.btn1 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    contactview.btn2.tag = 2;
    [contactview.btn2 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    contactview.btn3.tag = 3;
    [contactview.btn3 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    contactview.btn4.tag = 4;
    [contactview.btn4 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    contactview.btn5.tag = 5;
    [contactview.btn5 addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
        
        if ([responseObject[@"error"] integerValue] == 50011) {
            DCLog(@"error");
            //用户离职后提示该用户已离职
            [MBProgressHUD showError:NSLocalizedString(@"PERSONAL_MESSAGE", @"")];
        }
        else
        {
            DCRelationModel *relation = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            DCLog(@"他的资料详情是---%@",responseObject[@"response"]);
            nameLabel.text = [NSString stringWithFormat:@"%@",relation.relname];
            groupLabel.text = [NSString stringWithFormat:@"%@",relation.group_job[@"group"]];
            //座机号
            if ([relation.telphone isEqualToString:@""]) {
                contactview.btn0.enabled = NO;
                [contactview.btn0 setImage:[UIImage imageNamed:@"联系同事－灰色座机-.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn0.enabled = YES;
                [contactview.btn0 setImage:[UIImage imageNamed:@"联系同事－彩色座机.png"] forState:UIControlStateNormal];
                [contactview.btn0 setImage:[UIImage imageNamed:@"联系同事－灰色座机-.png"] forState:UIControlStateHighlighted];

            }
            
            //手机号
            if ([relation.mobile isEqualToString:@""]) {
                contactview.btn1.enabled = NO;
                [contactview.btn1 setImage:[UIImage imageNamed:@"联系同事－灰色手机.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn1.enabled = YES;
                [contactview.btn1 setImage:[UIImage imageNamed:@"联系同事－彩色手机.png"] forState:UIControlStateNormal];
                [contactview.btn1 setImage:[UIImage imageNamed:@"联系同事－灰色手机.png"] forState:UIControlStateHighlighted];
            }
            
            //短信
            if ([relation.mobile isEqualToString:@""]) {
                contactview.btn2.enabled = NO;
                [contactview.btn2 setImage:[UIImage imageNamed:@"灰色短信图标.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn2.enabled = YES;
                [contactview.btn2 setImage:[UIImage imageNamed:@"联系同事－彩色短信图标.png"] forState:UIControlStateNormal];
                [contactview.btn2 setImage:[UIImage imageNamed:@"灰色短信图标.png"] forState:UIControlStateHighlighted];
            }
            
            //email
            if ([relation.email isEqualToString:@""]) {
                contactview.btn3.enabled = NO;
                [contactview.btn3 setImage:[UIImage imageNamed:@"联系同事-灰邮件-.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn3.enabled = YES;
                [contactview.btn3 setImage:[UIImage imageNamed:@"联系同事－彩色邮件-拷贝-2.png"] forState:UIControlStateNormal];
                [contactview.btn3 setImage:[UIImage imageNamed:@"联系同事-灰邮件-.png"] forState:UIControlStateHighlighted];
            }
            
            //微信
            if ([relation.weixin isEqualToString:@""]) {
                contactview.btn4.enabled = NO;
                [contactview.btn4 setImage:[UIImage imageNamed:@"联系同事-灰微信.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn4.enabled = YES;
                [contactview.btn4 setImage:[UIImage imageNamed:@"联系同事－真微信.png"] forState:UIControlStateNormal];
                [contactview.btn4 setImage:[UIImage imageNamed:@"联系同事-灰微信.png"] forState:UIControlStateHighlighted];
            }
            
            //QQ
            if ([relation.qq isEqualToString:@""]){
                contactview.btn5.enabled = NO;
                [contactview.btn5 setImage:[UIImage imageNamed:@"联系同事-灰qq.png"] forState:UIControlStateNormal];
            }
            else
            {
                contactview.btn5.enabled = YES;
                [contactview.btn5 setImage:[UIImage imageNamed:@"联系同事－真qq.png"] forState:UIControlStateNormal];
                [contactview.btn5 setImage:[UIImage imageNamed:@"联系同事-灰qq.png"] forState:UIControlStateHighlighted];
            }
            
            /**
             计算时间
             */
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            NSDate *date = [df dateFromString:relation.lastlogin];
            NSTimeInterval late=[date timeIntervalSince1970]*1;
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now=[dat timeIntervalSince1970]*1;
            NSString *timeString=@"";
            
            NSTimeInterval cha=now-late;
            if (cha / 3600 < 1) {
                timeString = [NSString stringWithFormat:@"%f", cha/60];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString=[NSString stringWithFormat:@"%@%@", timeString,NSLocalizedString(@"AGO_MINUTE", nil)];
            }
            if (cha/3600>1&&cha/86400<1) {
                timeString = [NSString stringWithFormat:@"%f", cha/3600];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString=[NSString stringWithFormat:@"%@%@", timeString,NSLocalizedString(@"AGO_HOUR", nil)];
            }
            if (cha/86400>1)
            {
                timeString = [NSString stringWithFormat:@"%f", cha/86400];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString=[NSString stringWithFormat:@"%@%@", timeString,NSLocalizedString(@"AGO_DAY", nil)];
            }
            if (cha/2592000 > 1) {
                timeString = [NSString stringWithFormat:@"%f", cha/2592000];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString= [NSString stringWithFormat:@"%@",NSLocalizedString(@"AGO_MONTH", nil)];
            }
            NSLog(@"timeString----%@",timeString);
            DCLog(@"最后登录的时间是－－－－%@",relation.lastlogin);
            DCLog(@"最后登录的地点是－－－－%@",relation.lastgeo);
            
            if ([relation.lastgeo isEqualToString:@""]) {
                
                NSString *stringrr = @"你在星星上";
                CGSize locatMaxSize = CGSizeMake(self.view.width, 20);
                NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
                CGSize locatSize = [stringrr boundingRectWithSize:locatMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
                locatLabel.width = locatSize.width + 20;
                locatLabel.x = (self.view.width - locatLabel.width) / 2 + 10;
                locatLabel.y = locatImg.y;
                locatLabel.height = 20;
                locatImg.x = locatLabel.x - locatImg.width;
                locatLabel.text = [NSString stringWithFormat:@"%@",stringrr];
            }
            else
            {
                NSString *stringrr = [relation.lastgeo stringByAppendingString:timeString];
                CGSize locatMaxSize = CGSizeMake(self.view.width, 20);
                NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
                CGSize locatSize = [stringrr boundingRectWithSize:locatMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
                
                locatLabel.width = locatSize.width + 20;
                locatLabel.x = (self.view.width - locatLabel.width) / 2 + 10;
                locatLabel.y = locatImg.y;
                locatLabel.height = 20;
                locatImg.x = locatLabel.x - locatImg.width;
                locatLabel.text = [NSString stringWithFormat:@"%@ [%@]",relation.lastgeo,timeString];
            }
            DCLog(@"locatLabel.text－－－－%@",locatLabel.text);
        }
        
    } failure:^(NSError *error) {
        VC_ALERT(nil, NSLocalizedString(@"ERROR_RETRIEVE_ADDR_FAILED", nil), NSLocalizedString(@"OK", nil));
    }];

}

#pragma mark - methods

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  打电话，发短信 座机  phone message email weichat QQ
 */

-(void)buttonDidClick:(UIButton *)btn
{
    UIView *coverView = [[UIView alloc]initWithFrame:self.view.bounds];
    coverView.backgroundColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerDidClick)];
    [coverView addGestureRecognizer:tapGestureRecognizer];
    coverView.alpha = 0.3;
    self.coverView = coverView;
    
    DCAlertView *alertView = [[DCAlertView alloc]init];
    alertView.width = self.view.width - margin *2;
    alertView.height = self.view.height / 4;
    alertView.x = margin;
    alertView.y = (self.view.height - alertView.height) / 2;
    self.alertView = alertView;
    __weak DCAlertView *weakAlertView = alertView;
    
    if (btn.tag == 0)//座机
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            [alertView setTitleLabel:NSLocalizedString(@"RELATION_TEL_NUM", nil) alertTitle:relations.telphone exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
                
                //截取座机号码的分机号吗
                NSString *str = relations.telphone;
                NSArray *arr = [str componentsSeparatedByString:@"-"];
                DCLog(@"arr:%@",arr[1]);
                /**
                 *  打电话
                 */
                //        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://18601977948"]];
                UIWebView *callWebView = [[UIWebView alloc]init];
                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",arr[0]]];
                [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                [self.view addSubview:callWebView];
                
            } handleExitBlock:^{
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            }];
            [self.view addSubview:coverView];
            [self.view addSubview:alertView];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (btn.tag == 1)//手机
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            [alertView setTitleLabel:NSLocalizedString(@"RELATION_CELL_NUM", nil) alertTitle:relations.mobile exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
                /**
                 *  打电话
                 */
                //    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://18601977948"]];
                UIWebView *callWebView = [[UIWebView alloc]init];
                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",relations.mobile]];
                [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                [self.view addSubview:callWebView];
                
            } handleExitBlock:^{
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            }];
            [self.view addSubview:coverView];
            [self.view addSubview:alertView];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (btn.tag == 2)//短信
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            [alertView setTitleLabel:NSLocalizedString(@"RELATION_SEND_SMS", nil) alertTitle:relations.mobile exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
                /**
                 *  发短信
                 */
                //方法一
                //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://18601977948"]];
                //方法二
                [self showMessageView:[NSArray arrayWithObject:relations.mobile] title:@"text"];
                
            } handleExitBlock:^{
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            }];
            [self.view addSubview:coverView];
            [self.view addSubview:alertView];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (btn.tag == 3)//邮件
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            
            [alertView setTitleLabel:NSLocalizedString(@"RELATION_SEND_EMAIL", nil) alertTitle:relations.email exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
                
                /**
                 *  发邮件
                 */
                [self showEmailView:[NSArray arrayWithObject:relations.email] title:@"email"];
                
            } handleExitBlock:^{
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            }];
            [self.view addSubview:coverView];
            
            [self.view addSubview:alertView];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else if (btn.tag == 4)//微信
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            
            [alertView setTitleLabel:NSLocalizedString(@"RELATION_WECHAT_NUM", nil) alertTitle:relations.weixin exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"联系同事-提示框-灰色复制.png" selImg:@"联系同事-提示框-黄色复制-.png" handleEnsureBlock:^{
                
                UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
                [pasteBoard setString:relations.weixin];
                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_WECHAT_NUM_COPIED", nil)];
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            } handleExitBlock:^{
                
                coverView.hidden = YES;
                weakAlertView.hidden = YES;
                
            }];
            [self.view addSubview:coverView];
            [self.view addSubview:alertView];
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    else if (btn.tag == 5)//QQ
    {
        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
            
            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {

                [alertView setTitleLabel:NSLocalizedString(@"RELATION_QQ_NUM", nil) alertTitle:relations.qq exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
                    //进入QQ聊天界面
                    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",relations.qq]];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    webView.delegate = self;
                    [webView loadRequest:request];
                    [self.view addSubview:webView];
                    
                } handleExitBlock:^{
                    
                    coverView.hidden = YES;
                    weakAlertView.hidden = YES;
                }];

            }
            else
            {
                [alertView setTitleLabel:NSLocalizedString(@"RELATION_QQ_NUM", nil) alertTitle:relations.qq exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"联系同事-提示框-灰色复制.png" selImg:@"联系同事-提示框-黄色复制-.png" handleEnsureBlock:^{
                    DCLog(@"dddd");
                    
                    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
                    [pasteBoard setString:relations.weixin];
                    [MBProgressHUD showError:NSLocalizedString(@"PROMPT_QQ_NUM_COPIED", nil)];
                    
                    coverView.hidden = YES;
                    weakAlertView.hidden = YES;
                    
                } handleExitBlock:^{
                    
                    coverView.hidden = YES;
                    weakAlertView.hidden = YES;
                }];

            }
            
            [self.view addSubview:coverView];
            [self.view addSubview:alertView];
            
            
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)tapGestureRecognizerDidClick
{
    
    self.coverView.hidden = YES;
    self.alertView.hidden = YES;
    

}
#pragma mark - MFMessageComposeViewController
/**
 *  发送短信
 *
 *  @param phones @“10086”
 *  @param title  @“你好”
 *  @param body   @“baby” 短信内容前面拼接的字符串
 */
-(void)showMessageView:(NSArray *)phones title:(NSString *)title
{
    if ([MFMessageComposeViewController canSendText]) {
        
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
        messageVC.recipients = phones;
        messageVC.body = [NSString stringWithFormat:@"%@%@。",NSLocalizedString(@"PREFIX_SMS",@""),[DCAccountTool getUserName]];
        messageVC.navigationBar.tintColor = [UIColor redColor];
        //在短信前面拼接的内容body
//        messageVC.body = body;
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
        [[[[messageVC viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
        
    }
    else
    {
//        VC_ALERT(@"提示信息", NSLocalizedString(@"ERROR_SMS_NOT_SUPPORTED",nil), NSLocalizedString(@"OK",nil));
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

/**
 *  发邮件
 */
-(void)showEmailView:(NSArray *)emails title:(NSString *)title
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc]init];
        emailVC.mailComposeDelegate = self;
        //设置主收件人
        [emailVC setToRecipients:[NSArray arrayWithObject:self.friendModel.email]];
        [emailVC setMessageBody:self.friendModel.email isHTML:NO];
        emailVC.navigationBar.tintColor = [UIColor redColor];
//        [emailVC setMessageBody:@"Watson!!!\n\nCome here, I need you!" isHTML:NO];
        [self presentViewController:emailVC animated:YES completion:nil];

    }
    else
    {
        VC_ALERT(nil, NSLocalizedString(@"PROMPT_EMAIL_ACCOUNT", nil), NSLocalizedString(@"OK", nil));
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_EMAIL_EDIT_CANCELED", nil)];
            break;
        case MFMailComposeResultFailed:
            [MBProgressHUD showError:NSLocalizedString(@"ERROR_SAVE_SEND_EMAIL_FAILED", nil)];
            break;
        case MFMailComposeResultSaved:
            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_EMAIL_SAVED", nil)];
            break;
        case MFMailComposeResultSent:
            [MBProgressHUD showError:NSLocalizedString(@"PROMPT_EMAIL_ADD_TO_QUEUE", nil)];
            break;
        default:
            break;
    }
}

































//-(void)btnDidClick:(UIButton *)btn
//{
//    UIView *coverView = [[UIView alloc]initWithFrame:self.view.bounds];
//    coverView.backgroundColor = [UIColor lightGrayColor];
//    coverView.alpha = 0.3;
//    
//    DCAlertView *alertView = [[DCAlertView alloc]init];
//    alertView.width = self.view.width - margin *2;
//    alertView.height = self.view.height / 4;
//    alertView.x = margin;
//    alertView.y = (self.view.height - alertView.height) / 2;
//    
//    __weak DCAlertView *weakAlertView = alertView;
//    if (btn.tag == 0)//座机
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            
//            if ([relations.telphone isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_TEL_NUM", nil)];
//                
//            }
//            else
//            {
//                [btn setImage:[UIImage imageNamed:@"联系同事-黄色座机图标-拷贝.png"] forState:UIControlStateNormal];
//                [alertView setTitleLabel:NSLocalizedString(@"TEL_NUM", nil) alertTitle:relations.telphone exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
//                    
//                    //截取座机号码的分机号吗
//                    NSString *str = relations.telphone;
//                    NSArray *arr = [str componentsSeparatedByString:@"-"];
//                    DCLog(@"arr:%@",arr[1]);
//                    /**
//                     *  打电话
//                     */
//                    //        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://18601977948"]];
//                    UIWebView *callWebView = [[UIWebView alloc]init];
//                    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",arr[0]]];
//                    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
//                    [self.view addSubview:callWebView];
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"联系同事-灰色座机图标.png"] forState:UIControlStateNormal];
//                    
//                }];
//                [self.view addSubview:coverView];
//                [self.view addSubview:alertView];
//            }
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }
//    else if (btn.tag == 1)//手机
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            if ([relations.mobile isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_CELL_NUM", nil)];
//                
//            }
//            else
//            {
//                [btn setImage:[UIImage imageNamed:@"黄色手机图标-.png"] forState:UIControlStateNormal];
//                [alertView setTitleLabel:NSLocalizedString(@"CELL_NUM", nil) alertTitle:relations.mobile exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
//                    /**
//                     *  打电话
//                     */
//                    //    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://18601977948"]];
//                    UIWebView *callWebView = [[UIWebView alloc]init];
//                    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",relations.mobile]];
//                    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
//                    [self.view addSubview:callWebView];
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    
//                    [btn setImage:[UIImage imageNamed:@"灰色手机图标.png"] forState:UIControlStateNormal];
//                    
//                }];
//                [self.view addSubview:coverView];
//                [self.view addSubview:alertView];
//            }
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }
//    else if (btn.tag == 2)//短信
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            if ([relations.mobile isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_CELL_NUM", nil)];
//                
//            }
//            else
//            {
//                [btn setImage:[UIImage imageNamed:@"黄色短信图标.png"] forState:UIControlStateNormal];
//                [alertView setTitleLabel:NSLocalizedString(@"SEND_SMS", nil) alertTitle:relations.mobile exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
//                    /**
//                     *  发短信
//                     */
//                    //方法一
//                    //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://18601977948"]];
//                    //方法二
//                    [self showMessageView:[NSArray arrayWithObject:relations.mobile] title:@"text"];
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"灰色短信图标.png"] forState:UIControlStateNormal];
//                    
//                }];
//                [self.view addSubview:coverView];
//                [self.view addSubview:alertView];
//            }
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }
//    else if (btn.tag == 3)//邮件
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            if ([relations.email isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_EMAIL_NUM", nil)];
//                
//            }
//            else
//            {
//                
//                [btn setImage:[UIImage imageNamed:@"黄邮件.png"] forState:UIControlStateNormal];
//                
//                [alertView setTitleLabel:NSLocalizedString(@"SEND_EMAIL", nil) alertTitle:relations.email exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"u2336_normal.png" selImg:@"u2393_normal.png" handleEnsureBlock:^{
//                    
//                    /**
//                     *  发邮件
//                     */
//                    [self showEmailView:[NSArray arrayWithObject:relations.email] title:@"email"];
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"联系同事-灰邮件-.png"] forState:UIControlStateNormal];
//                    
//                }];
//                [self.view addSubview:coverView];
//                
//                [self.view addSubview:alertView];
//            }
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }
//    else if (btn.tag == 4)//微信
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            
//            if ([relations.weixin isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_WECHAT_NUM", nil)];
//                
//            }
//            else
//            {
//                [btn setImage:[UIImage imageNamed:@"联系同事－真微信.png"] forState:UIControlStateNormal];
//                [alertView setTitleLabel:NSLocalizedString(@"WECHAT_NUM", nil) alertTitle:relations.weixin exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"联系同事-提示框-灰色复制.png" selImg:@"联系同事-提示框-黄色复制-.png" handleEnsureBlock:^{
//                    
//                    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
//                    [pasteBoard setString:relations.weixin];
//                    [MBProgressHUD showError:NSLocalizedString(@"PROMPT_WECHAT_NUM_COPIED", nil)];
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"联系同事-灰微信.png"] forState:UIControlStateNormal];
//                    
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"联系同事-灰微信.png"] forState:UIControlStateNormal];
//                    
//                }];
//                [self.view addSubview:coverView];
//                [self.view addSubview:alertView];
//            }
//        } failure:^(NSError *error) {
//            
//        }];
//        
//        
//    }
//    else if (btn.tag == 5)//QQ
//    {
//        [DCHttpTool postWithUrl:GetHisList_URL params:params success:^(id responseObject) {
//            
//            DCRelationModel *relations = [DCRelationModel objectWithKeyValues:responseObject[@"response"]];
//            if ([relations.qq isEqual:@""]) {
//                [MBProgressHUD showError:NSLocalizedString(@"PROMPT_LACK_QQ_NUM", nil)];
//            }
//            else
//            {
//                [btn setImage:[UIImage imageNamed:@"联系同事－真qq.png"] forState:UIControlStateNormal];
//                [alertView setTitleLabel:NSLocalizedString(@"QQ_NUM", nil) alertTitle:relations.qq exitBtnImg:@"验证手机号码-红框里面的叉@3x.png" btnImg:@"联系同事-提示框-灰色复制.png" selImg:@"联系同事-提示框-黄色复制-.png" handleEnsureBlock:^{
//                    //进入QQ聊天界面
//                    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",relations.qq]];
//                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//                    webView.delegate = self;
//                    [webView loadRequest:request];
//                    [self.view addSubview:webView];
//                    
//                } handleExitBlock:^{
//                    
//                    coverView.hidden = YES;
//                    weakAlertView.hidden = YES;
//                    [btn setImage:[UIImage imageNamed:@"联系同事-灰qq.png"] forState:UIControlStateNormal];
//                    
//                }];
//                
//                [self.view addSubview:coverView];
//                [self.view addSubview:alertView];
//            }
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }
//    
//}


@end
