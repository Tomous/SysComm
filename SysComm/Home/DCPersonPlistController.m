//
//  DCPersonPlistController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/11.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCPersonPlistController.h"
#import "DCPersonalController.h"
#import "DCRelationPersonController.h"
#import "DCMoreFriendController.h"
#import "DCFirstViewCell.h"
#import "DCResponseModel.h"
#import "DCUserLocalTool.h"
#import "DCRecentViewCell.h"
#import "DCUserLocalTool.h"
#import "DCRelationPersonController.h"
#import "DCSearchViewController.h"
#import "DCRefreshView.h"
#import "DCAccountTool.h"
#import "DCPersonalModel.h"
#import "DCRelationModel.h"
#define kMargin 5
@interface DCPersonPlistController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIView *navView;
    UIView *batteryView;
    UITableView *TableView;
    DCMoreFriendController *moreFriend;
    UIButton *moreBtn;
    NSArray *modelArr;
    UIImageView *zuijiImageView;
    UIButton *deleteBtn;
    NSDictionary *dic;
    DCPersonalModel *person;
}
@property(nonatomic,strong)DCRefreshView *refreshView;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation DCPersonPlistController

-(NSMutableArray *)friendModel
{
    if (!_friendModel) {
        _friendModel = [NSMutableArray array];
    }
    return _friendModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self getUpNewFriensMessage];
    
//    [self setUpHeaderView];

    self.zuijinliulanModel = [DCUserLocalTool recentFriends];
    
//    /**
//     第一个控制器
//     */
//    CGFloat kHeight = self.view.height - 120 - 70 - 20 - 40 * 3;
//    int cols = 3;
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(((self.view.width - 10) - (cols +1) * 5) / cols, (kHeight - 20) / 2 + 10);
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 20, self.view.width - 10, kHeight + 10) collectionViewLayout:layout];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[DCFirstViewCell class] forCellWithReuseIdentifier:@"friendModel"];
//    [self.view addSubview:self.collectionView];
//    
//    
//    moreBtn = [[UIButton alloc]init];
//    moreBtn.width = self.view.width / 3;
//    moreBtn.height = 40;
//    moreBtn.x = moreBtn.width;
//    moreBtn.y = CGRectGetMaxY(self.collectionView.frame) + moreBtn.height + 20;
//    moreBtn.layer.cornerRadius = 6;
//    moreBtn.layer.masksToBounds = YES;
//    moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [moreBtn setTitle:NSLocalizedString(@"MORE", nil) forState:UIControlStateNormal];
//    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    moreBtn.backgroundColor = DCColor(33.0, 184.0, 188.0);
//    [moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    DCLog(@"more的值是－－%@++++++++++",dic[@"more"]);
//    if ([dic[@"more"] integerValue] == 1) {
//        moreBtn.hidden = NO;
//    }
//    else
//    {
//        moreBtn.hidden = YES;
//    }
//    [self.view addSubview:moreBtn];
//    
//    
//    /**
//     没有数据是 小菊花刷新
//     */
//    DCRefreshView *refreshView = [[DCRefreshView alloc]init];
//    refreshView.width = self.view.width;
//    refreshView.height = self.view.height - 190;
//    self.refreshView = refreshView;
//    refreshView.hidden = YES;
//    [self.collectionView addSubview:refreshView];
    
}

-(void)getUpNewFriensMessage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;

    NSURL *url = [NSURL URLWithString:GetNewFriend_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"token=%@&suid=%@",[DCResponseModel shareResponse].token,[DCDataModel shareDataModel].uid];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSData *receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    dic = [NSJSONSerialization JSONObjectWithData:receive options:NSJSONReadingMutableContainers error:&error];
    
    DCLog(@"dic--response－error------%@",dic[@"error"]);
    
    if ([dic[@"response"] count] > 0) {
        modelArr = [DCNewFriendsModel objectArrayWithKeyValuesArray:dic[@"response"]];
        
        if (modelArr.count != 0) {
            self.refreshView.hidden = YES;//有数据时小菊花刷新消失
        }
        [self.friendModel addObjectsFromArray:modelArr];
        DCLog(@"首页的请求数据是：－－－%@",self.friendModel);
        
        /**
         第一个控制器
         */
        CGFloat kHeight = self.view.height - 120 - 70 - 20 - 40 * 3;
        int cols = 3;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(((self.view.width - 10) - (cols +1) * 5) / cols, (kHeight - 20) / 2 + 10);
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 20, self.view.width - 10, kHeight + 10) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[DCFirstViewCell class] forCellWithReuseIdentifier:@"friendModel"];
        [self.view addSubview:self.collectionView];
        
        
        moreBtn = [[UIButton alloc]init];
        moreBtn.width = self.view.width / 3;
        moreBtn.height = 40;
        moreBtn.x = moreBtn.width;
        moreBtn.y = CGRectGetMaxY(self.collectionView.frame) + moreBtn.height + 20;
        moreBtn.layer.cornerRadius = 6;
        moreBtn.layer.masksToBounds = YES;
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [moreBtn setTitle:NSLocalizedString(@"MORE", nil) forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        moreBtn.backgroundColor = DCColor(33.0, 184.0, 188.0);
        [moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        DCLog(@"more的值是－－%@++++++++++",dic[@"more"]);
        if ([dic[@"more"] integerValue] == 1) {
            moreBtn.hidden = NO;
        }
        else
        {
            moreBtn.hidden = YES;
        }
        [self.view addSubview:moreBtn];
        
        
        /**
         没有数据是 小菊花刷新
         */
        DCRefreshView *refreshView = [[DCRefreshView alloc]init];
        refreshView.width = self.view.width;
        refreshView.height = self.view.height - 190;
        self.refreshView = refreshView;
        refreshView.hidden = YES;
        [self.collectionView addSubview:refreshView];

        [self.collectionView reloadData];
    }
    else
    {
        UIImageView *imagePhoto = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"暂无部门同事"]];
        imagePhoto.alpha = 0.5;
        imagePhoto.width = (self.view.width - 100) / 2;
        imagePhoto.height = self.view.width / 2;
        imagePhoto.x = (self.view.width - imagePhoto.width) / 2;
        imagePhoto.y = (self.view.height - 120 - 70 - 20 - 40 * 3) / 2;
        [self.view addSubview:imagePhoto];
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagePhoto.frame) + 10, self.view.width, 30)];
        textLabel.text = NSLocalizedString(@"PERSONLIST_NULL_CONTACTS", @"");
        textLabel.textColor = DCTextFieldColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.alpha = 0.5;
        textLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:textLabel];
    }
    
    
    
//    [DCHttpTool postWithUrl:GetNewFriend_URL params:params success:^(id responseObject) {
//        
//        if ([responseObject[@"response"] count] > 0) {
//            
//            modelArr = [DCNewFriendsModel objectArrayWithKeyValuesArray:responseObject[@"response"]];
//            if (modelArr.count != 0) {
//                self.refreshView.hidden = YES;//有数据时小菊花刷新消失
//            }
//            [self.friendModel addObjectsFromArray:modelArr];
//            DCLog(@"首页的请求数据是：－－－%@",self.friendModel);
//            
//            [self.collectionView reloadData];
//        }        
//        
//    } failure:^(NSError *error) {
//        
//    }];
}
/**
 *   navigationView布局

 */
-(void)setUpHeaderView
{
    batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    batteryView.backgroundColor = DCColor(82.0, 82.0, 82.0);
    [self.view addSubview:batteryView];
    
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, batteryView.height, self.view.width, 50)];
    navView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [self.view addSubview:navView];
    /**
      title
     */
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.width = self.view.width / 2;
    titleLabel.height = 35;
    titleLabel.x = (self.view.width - titleLabel.width) / 2;
    titleLabel.y = kMargin;
    titleLabel.text = NSLocalizedString(@"LATEST_COLL", nil);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];

}


#pragma mark - methods
/**
 *  点击更多
 */
-(void)moreBtnDidClick
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MOREBTNDIDCLICK" object:nil];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.friendModel.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"friendModel";
    DCFirstViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    collectionCell.friendModel = self.friendModel[indexPath.row];
//    collectionCell.backgroundColor = [UIColor redColor];
    return collectionCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCRelationPersonController *relationVC = [[DCRelationPersonController alloc]init];
    relationVC.friendModel = self.friendModel[indexPath.row];
    [self presentViewController:relationVC animated:YES completion:nil];
}
@end
