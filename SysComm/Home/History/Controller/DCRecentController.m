//
//  DCRecentController.m
//  讯通
//
//  Created by 许大成 on 16/1/11.
//  Copyright © 2016年 许大成. All rights reserved.
//

#import "DCRecentController.h"
#import "DCUserLocalTool.h"
#import "DCRecentViewCell.h"
#import "DCRelationPersonController.h"
#import "DCNewFriendsModel.h"
#define kMargin 5
@interface DCRecentController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *navView;
    UIView *batteryView;
    UIView *zuijiImageView;
    UIButton *deleteBtn;
    NSArray *recentFriends;

}
@property(nonatomic,strong)UITableView *TableView;

@end

@implementation DCRecentController

-(NSMutableArray *)zuijinliulanModel
{
    if (!_zuijinliulanModel) {
        _zuijinliulanModel = [NSMutableArray array];
    }
    return _zuijinliulanModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpHeaderView];
    
    zuijiImageView = [[UIView alloc]init];
    zuijiImageView.backgroundColor = [UIColor whiteColor];
    zuijiImageView.alpha = 0.5;
    zuijiImageView.width = self.view.width / 2;
    zuijiImageView.x = (self.view.width - zuijiImageView.width) / 2;
    zuijiImageView.height = zuijiImageView.width + 40 +25;
    zuijiImageView.y = (self.view.height - 48 - 70 - zuijiImageView.height) / 2;
    zuijiImageView.hidden = YES;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"暂无最近查看"]];
    image.width = zuijiImageView.width;
    image.height = image.width + 10;
    [zuijiImageView addSubview:image];
    
    UILabel *zuijinLabel = [[UILabel alloc]init];
    zuijinLabel.width = zuijiImageView.width;
    zuijinLabel.height = 30;
    zuijinLabel.y = zuijiImageView.height - zuijinLabel.height -10;
    zuijinLabel.text = NSLocalizedString(@"NO_VIEWED_RECORD", nil);
    zuijinLabel.textAlignment = NSTextAlignmentCenter;
    zuijinLabel.font = [UIFont systemFontOfSize:14];
    zuijinLabel.textColor = DCTextFieldColor;
    [zuijiImageView addSubview:zuijinLabel];

    
    UITableView *TableView = [[UITableView alloc]init];
    TableView.frame = CGRectMake(0, CGRectGetMaxY(navView.frame), self.view.width, self.view.height- 48 - 70);
    TableView.backgroundColor = [UIColor whiteColor];
    TableView.showsVerticalScrollIndicator = NO;
    TableView.delegate = self;
    TableView.dataSource = self;
    TableView.rowHeight = 90;
    self.TableView = TableView;
    
    self.zuijinliulanModel = [DCUserLocalTool recentFriends];
    
    [self.TableView reloadData];
    
    [self.view addSubview:TableView];
    
    deleteBtn = [[UIButton alloc]init];
    deleteBtn.height = 30;
    [deleteBtn setTitle:NSLocalizedString(@"CLEAR_HISTORY", nil) forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [deleteBtn setTitleColor:DCTextColor forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    TableView.tableFooterView = deleteBtn;
    
    if (self.zuijinliulanModel.count == 0) {
        zuijiImageView.hidden = NO;
        [TableView addSubview:zuijiImageView];
        deleteBtn.hidden = YES;
    }
    else
    {
        zuijiImageView.hidden = YES;
        deleteBtn.hidden = NO;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.TableView reloadData];
    if (self.zuijinliulanModel.count == 0) {
        zuijiImageView.hidden = NO;
        [self.TableView addSubview:zuijiImageView];
        deleteBtn.hidden = YES;
    }
    else
    {
        zuijiImageView.hidden = YES;
        deleteBtn.hidden = NO;
    }

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
    titleLabel.text = NSLocalizedString(@"RECENT_VIEWED", nil);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
}


/**
 *  最近查看
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.zuijinliulanModel.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCRecentViewCell *cell = [DCRecentViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.zuijinliulanModel = self.zuijinliulanModel[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DCRelationPersonController *relationVC = [[DCRelationPersonController alloc]init];
    relationVC.friendModel = self.zuijinliulanModel[indexPath.row];
    DCLog(@"点击cell时用户的id----%@",relationVC.friendModel.uid);
    
    [DCHttpTool postWithUrl:GetHisList_URL params:@{
                                                    @"token":[DCResponseModel shareResponse].token,
                                                    @"suid":[DCDataModel shareDataModel].uid,
                                                    @"tuid":relationVC.friendModel.uid,
                                                    } success:^(id responseObject) {
                                                        if ([responseObject[@"error"] integerValue] == 50011) {
                                                            DCLog(@"error");
                                                            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"PERSONAL_MESSAGE", @"") preferredStyle:UIAlertControllerStyleAlert];
                                                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                                                    DCNewFriendsModel *mainModell = self.zuijinliulanModel[indexPath.row];
                                                                    [DCUserLocalTool deleteRecentFriend:mainModell];
                                                                    [self.TableView reloadData];
                                                                    [self zuijinliulanModelCount];

                                                                }];
                                                            [alertVC addAction:okAction];
                                                            [self presentViewController:alertVC animated:YES completion:nil];
                                                        }
                                                        else
                                                        {
                                                            [self presentViewController:relationVC animated:YES completion:nil];
                                                        }

                                                    } failure:^(NSError *error) {
                                                        
                                                    }];
}
/**
 *  左滑删除cell上的数据
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingStyle = UITableViewCellEditingStyleDelete;
    
    DCNewFriendsModel *mainModel = self.zuijinliulanModel[indexPath.row];
    [DCUserLocalTool deleteRecentFriend:mainModel];
    [self.TableView reloadData];
    DCLog(@"%lu_________",(unsigned long)self.zuijinliulanModel.count);
    [self zuijinliulanModelCount];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"DEL", nil);
}

-(void)deleteBtnDidClick
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"SURE_CLEAR_HISTORY", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCEL", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [DCUserLocalTool deleteRecentFriends:self.zuijinliulanModel];
        [self.TableView reloadData];
        [self zuijinliulanModelCount];
    }];
    [alertVC addAction:cancleAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)zuijinliulanModelCount
{
    if (self.zuijinliulanModel.count == 0) {
        
        self.TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        zuijiImageView.hidden = NO;
        [self.TableView addSubview:zuijiImageView];
        deleteBtn.hidden = YES;
    }
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
