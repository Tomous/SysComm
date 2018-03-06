//
//  DCSearchViewController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCSearchViewController.h"
#import "DCSearchResultCell.h"
#import "DCSearchResultModel.h"
#import "DCRelationPersonController.h"
#import "DCUserLocalTool.h"
#define kMargin 10

@interface DCSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *navView;
    UIView *batteryView;
    UITextField *searchField;
    UIView *headerView;
    NSArray *arrResult;
//    UITableView *resultTableView;
    UILabel *textLabel;
    UIButton *deleteBtn;
    UIImageView *backgroundImage;
}

@property(strong,nonatomic)UITableView *tableView;
@end

@implementation DCSearchViewController

-(NSMutableArray *)result
{
    if (!_result) {
        _result = [[NSMutableArray alloc]init];
    }
    return _result;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpView];
}


-(void)setUpView
{
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.view.width, 70);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];

    batteryView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    batteryView.backgroundColor = DCColor(82.0, 82.0, 82.0);
    [headerView addSubview:batteryView];
    
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, batteryView.height, self.view.width, 50)];
    navView.backgroundColor = DCColor(33.0, 184.0, 188.0);
    [headerView addSubview:navView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 30)];
    titleLabel.text = NSLocalizedString(@"SEARCH_CONTACTSE", @"");
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [navView addSubview:titleLabel];

    backgroundImage = [[UIImageView alloc]init];
    backgroundImage.width = self.view.width / 2;
    backgroundImage.height = backgroundImage.width + 25;
    backgroundImage.x = (self.view.width - backgroundImage.width) / 2;
//    backgroundImage.y = (self.view.height - 70 - 88 - backgroundImage.height) / 2;
    backgroundImage.y = (self.view.height - backgroundImage.height) / 2;
    backgroundImage.image = [UIImage imageNamed:@"_新搜索同事底图"];
    backgroundImage.alpha = 0.6;
    [self.view addSubview:backgroundImage];
    
    UIView *mainSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), self.view.width, 40)];
    mainSearchView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainSearchView];
    
    UIView *searchView = [[UIView alloc]init];
    searchView.width = navView.width - kMargin *2;
    searchView.height = navView.height - kMargin -5 - 5;
    searchView.x = kMargin;
    searchView.y = kMargin - 5;
    searchView.layer.cornerRadius = 6;
    searchView.layer.borderWidth = 0.6;
    searchView.layer.borderColor = [[UIColor whiteColor]CGColor];
    searchView.backgroundColor = [UIColor whiteColor];
    [mainSearchView addSubview:searchView];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainSearchView.frame) + 10, self.view.width, self.view.height - headerView.height - mainSearchView.height - 48)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = 80;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.hidden = YES;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    UIButton *searchBtn = [[UIButton alloc]init];
        searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setImage:[UIImage imageNamed:@"（13）点击搜索之后搜索框里的放大镜@2x.png"] forState:UIControlStateNormal];
    searchBtn.height = searchView.height;
    searchBtn.width = searchBtn.height;
    searchBtn.x = kMargin - 5;
    searchBtn.enabled = YES;
    [searchBtn addTarget:self action:@selector(searchBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    searchField = [[UITextField alloc]init];
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.width = searchView.width - searchBtn.width - kMargin;
    searchField.height = searchBtn.height;
    searchField.x = CGRectGetMaxX(searchBtn.frame);
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.placeholder = NSLocalizedString(@"CAPTION_SEARCH", nil);
    searchField.textColor = DCTextFieldColor;
    searchField.font = [UIFont systemFontOfSize:14];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.delegate = self;
    [searchView addSubview:searchField];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchView.frame) + kMargin, searchView.y, searchView.height, searchView.height)];
    [cancleBtn setImage:[UIImage imageNamed:@"登录关闭叉"] forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)cancleBtnDidClick
{
    [searchField resignFirstResponder];
    searchField.text = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    searchField.text = nil;
    [searchField resignFirstResponder];
    self.tableView.hidden = YES;
    backgroundImage.hidden = NO;
}
/**
 *  绑定键盘上的return键响应search
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchBtnDidClick];
    [searchField resignFirstResponder];
//    searchField.text = nil;
    return YES;
}

-(void)searchBtnDidClick
{
    if ([searchField.text length] != 0) {
        
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [DCResponseModel shareResponse].token;
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"qw"] = searchField.text;
    
    [DCHttpTool postWithUrl:GetSearch_URL params:params success:^(id responseObject) {
        
        arrResult = [DCSearchResultModel objectArrayWithKeyValuesArray:responseObject[@"response"]];
    
        if (arrResult.count != 0) {
            backgroundImage.hidden = YES;
            self.tableView.hidden = NO;
        }
        [self.tableView reloadData];
        DCLog(@"%lu*******",(unsigned long)arrResult.count);
        
    } failure:^(NSError *error) {
        
    }];
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCSearchResultCell *cell = [DCSearchResultCell cellWithTableView:tableView];
    cell.resultModel = arrResult[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DCRelationPersonController *relationVC = [[DCRelationPersonController alloc]init];
    relationVC.friendModel = arrResult[indexPath.row];
    [self presentViewController:relationVC animated:YES completion:nil];
    
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
