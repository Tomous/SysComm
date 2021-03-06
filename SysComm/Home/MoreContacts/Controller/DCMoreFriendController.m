//
//  DCMoreFriendController.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/19.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCMoreFriendController.h"
#import "DCMoreTableViewCell.h"
#import "DCRelationPersonController.h"
#import "DCUserLocalTool.h"
#import "DCNewFriendsModel.h"
#import "DCRefreshView.h"
#import "ChineseString.h"
#import "DCNameModel.h"
#import "Pinyin.h"
#import "DCRelationModel.h"
#define margin 5
@interface DCMoreFriendController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *navView;
    UIView *batteryView;
    UIImageView * footerView;
    int currentPage;
    DCRefreshView *refreshView;
    UILabel *personalLabel;
    NSMutableArray *listArr;
    NSMutableArray *tempArr;
}

@property(nonatomic,strong)UITableView *friendTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;        //数据源

@end


@implementation DCMoreFriendController

@synthesize sectionHeadsKeys = _sectionHeadsKeys ;

@synthesize hotArrForArrays = _hotArrForArrays;

@synthesize sortedArrForArrays = _sortedArrForArrays ;

@synthesize dataArr = _dataArr;

-(NSMutableArray *)moreFriendModels
{
    if (!_moreFriendModels) {
        _moreFriendModels = [NSMutableArray array];
    }
    return _moreFriendModels;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTableView];
    
    refreshView = [[DCRefreshView alloc]init];
    refreshView.width = self.view.width;
    refreshView.height = self.view.height - 140;
    refreshView.y = 70;
    refreshView.hidden = NO;
    [self.view addSubview:refreshView];

}

#pragma mark - methods

-(void)setUpTableView
{
    self.friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 20 - 50 - 48)];
    self.friendTableView.rowHeight = 80;
    self.friendTableView.delegate = self;
    self.friendTableView.dataSource = self;
    self.friendTableView.backgroundColor = [UIColor whiteColor];
    self.friendTableView.sectionIndexColor = DCTextColor;
    self.friendTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.friendTableView];

    [self loadFriends];
    
}

//-(void)loadFriends
//{
//    
//    _dataArr = [[ NSMutableArray alloc ] init ];
//    
//    _sortedArrForArrays = [[ NSMutableArray alloc ] init ];
//    
//    _sectionHeadsKeys = [[ NSMutableArray alloc ] init ];      //initialize a array to hold keys like A,B,C ...
//    
//    _hotArrForArrays = [[NSMutableArray alloc] init];
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"suid"] = [DCDataModel shareDataModel].uid;
//    params[@"token"] = [DCResponseModel shareResponse].token;
//    
//    [DCHttpTool postWithUrl:GetAllFriend_URL params:params success:^(id responseObject) {
//        if ([responseObject[@"error"]integerValue] == 0) {
//            
//            NSArray *allArr = [DCNewFriendsModel objectArrayWithKeyValuesArray:responseObject[@"response"]];
//            
//            for (DCNewFriendsModel *new in allArr) {
//                personalLabel.text = new.group_job[@"group"];
//            }
//            
//            if (allArr.count != 0) {
//                [refreshView removeFromSuperview];//有数据时小菊花消失
//            }
//            
//            [self.moreFriendModels addObjectsFromArray:allArr];
//            
//            self.dataSource = responseObject[@"response"];
//            _dataArr = [[NSMutableArray alloc]initWithArray:responseObject[@"response"]];
//
//            self.sortedArrForArrays = [self getChineseStringArr:_dataArr];
//
//            [self.friendTableView reloadData];
//    }
//        
//    } failure:^(NSError *error) {
//        
//        [MBProgressHUD showError:@"获取用户信息失败"];
//    }];
//    
//
//}
-(void)loadFriends
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"suid"] = [DCDataModel shareDataModel].uid;
    params[@"token"] = [DCResponseModel shareResponse].token;
    
    [DCHttpTool postWithUrl:GetAllFriend_URL params:params success:^(id responseObject) {
        
        if ([responseObject[@"response"] count] > 0) {
            NSArray *allArr = [DCNewFriendsModel objectArrayWithKeyValuesArray:responseObject[@"response"]];
            
            for (DCNewFriendsModel *new in allArr) {
                personalLabel.text = new.group_job[@"group"];
            }
            
            if (allArr.count != 0) {
                [refreshView removeFromSuperview];//有数据时小菊花消失
            }
            
            tempArr = [NSMutableArray array];
            for (DCNameModel *name in allArr) {
                
                NSMutableString *pinyinStr = [[NSMutableString alloc]initWithString:name.relname];
                if (CFStringTransform((__bridge CFMutableStringRef)pinyinStr, 0, kCFStringTransformMandarinLatin, NO)) {
                    //先转换成有声调的拼音
                }
                if (CFStringTransform((__bridge CFMutableStringRef)pinyinStr, 0, kCFStringTransformStripDiacritics, NO)) {
                    //                DCLog(@"pinyin:+ 2---- %@", pinyinStr);//转换成没有声调的拼音
                    NSString *daxie = [pinyinStr capitalizedString];//转换成大写
                    NSString *ABC = [daxie substringToIndex:1];//取出大写的首字母
                    [tempArr addObject:ABC];
                    
                    //过滤掉重复的首字母
                    listArr = [[NSMutableArray alloc]init];
                    for (NSString *str in tempArr) {
                        if (![listArr containsObject:str]) {
                            [listArr addObject:str];
                        }
                    }
                }
            }
            //        DCLog(@"过滤前的数组是－－%@",tempArr);
            //        DCLog(@"过滤后的数组是－－%@",listArr);
            
            NSMutableArray *arrC = [NSMutableArray array];
            for (int i = 0; i < listArr.count; i ++) {
                NSString *strA = [listArr objectAtIndex:i];
                
                NSMutableArray *arrA = [NSMutableArray array];
                NSMutableDictionary *dicA = [NSMutableDictionary dictionary];
                for (int j = 0; j < tempArr.count; j ++) {
                    NSString *strB = [tempArr objectAtIndex:j];
                    if ([strA isEqualToString:strB]) {
                        [arrA addObject:strB];
                    }
                }
                [dicA setValue:arrA forKey:strA];
                [arrC addObject:dicA];
            }
            //        DCLog(@"整合后的数组是－－－%@",arrC);
            
            [self.moreFriendModels addObjectsFromArray:allArr];
            
            [self.friendTableView reloadData];

        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"获取用户信息失败"];
    }];
    
    
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  设置tableView右边的索引
 */
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
//    return self.sectionHeadsKeys;
    if (self.moreFriendModels.count > 25) {
//        NSMutableArray *abc = [[NSMutableArray alloc]init];
//        for (char c = 'A'; c <= 'Z'; c ++) {
//            [abc addObject:[NSString stringWithFormat:@"%c",c]];
//        }
        return listArr;
    }else
    {
        return 0;
    }
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [self.sectionHeadsKeys count];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moreFriendModels.count;
//    NSArray *arr = [self.sortedArrForArrays objectAtIndex:section];
//    return arr.count;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_sectionHeadsKeys objectAtIndex:section];
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCMoreTableViewCell *cell = [DCMoreTableViewCell cellWithTableView:tableView];
    
    cell.moreFriendModel = self.moreFriendModels[indexPath.row];
    //sortedArrForArrays 存放 cell 值的动态数组 , 首先将数组中得值赋给一个静态数组
//    
//    if ([ self.sortedArrForArrays count ] > indexPath. section )
//    {
//        NSArray *arr = [ self . sortedArrForArrays objectAtIndex :indexPath. section ];
//        
//        if ([arr count ] > indexPath. row )
//        {
//            // 之后 , 将数组的元素取出 , 赋值给数据模型
//            ChineseString *str = ( ChineseString *) [arr objectAtIndex :indexPath. row ];
//            // 给 cell 赋给相应地值 , 从数据模型处获得
//            cell . text = str. string ;
//            cell.textColor = DCTextColor;
//            
//        }
//        
//        else {
//            
//            NSLog ( @"arr out of range" );
//            
//        }
//        
//    }
//    
//    else
//        
//    {
//        
//        NSLog ( @"sortedArrForArrays out of range" );
//        
//    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DCRelationPersonController *relationVC = [[DCRelationPersonController alloc]init];
    relationVC.friendModel = self.moreFriendModels[indexPath.row];

//    NSArray *arr = [self.sortedArrForArrays objectAtIndex :indexPath.section];
//    
//    ChineseString *str = ( ChineseString *)[arr objectAtIndex:indexPath.row];
//    for (int i = 0; i < self.dataSource.count; i ++) {
//        
//        if ([str.string isEqualToString:self.dataSource[i][@"relname"]] ) {
//            
//            NSLog(@"%@的uid是====%@",self.dataSource[i][@"relname"],self.dataSource[i][@"uid"]);
//            [DCRelationModel shareRelations].uid = self.dataSource[i][@"uid"];

//            [self presentViewController:relationVC animated:YES completion:nil];
//
//        }
//    }

    [self presentViewController:relationVC animated:YES completion:nil];
}



// 固定代码 , 每次使用只需要将数据模型替换就好 , 这个方法是获取首字母 , 将填充给 cell 的值按照首字母排序

-(NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    // 创建一个临时的变动数组
    
    NSMutableArray *chineseStringsArray = [ NSMutableArray array];
    
    for ( int i = 0 ; i < [arrToSort count ]; i++)
    {
        // 创建一个临时的数据模型对象
        
        ChineseString *chineseString=[[ ChineseString alloc ] init ];
        
        // 给模型赋值
        chineseString. string =[ NSString stringWithString :arrToSort[i][@"relname"]];
        
        if (chineseString. string == nil )
        {
            chineseString. string = @"" ;
        }
    
        if (![chineseString. string isEqualToString : @"" ])
        {
            //join( 链接 ) the pinYin (letter 字母 )  链接到首字母
            
            NSString *pinYinResult = [ NSString string ];
            
            // 按照数据模型中 row 的个数循环
            
            for ( int j = 0 ;j < chineseString. string . length ; j++)
            {
                NSString *singlePinyinLetter = [[ NSString stringWithFormat : @"%c" ,
                                                 
                                                 pinyinFirstLetter ([chineseString. string characterAtIndex :j])] uppercaseString ];
                
                pinYinResult = [pinYinResult stringByAppendingString :singlePinyinLetter];
                
            }
            
            chineseString. pinYin = pinYinResult;
            
        } else {
            
            chineseString. pinYin = @"" ;
        }
        [chineseStringsArray addObject :chineseString];
  
    }
    
    //sort( 排序 ) the ChineseStringArr by pinYin( 首字母 )
    
    NSArray *sortDescriptors = [ NSArray arrayWithObject :[ NSSortDescriptor sortDescriptorWithKey : @"pinYin" ascending : YES ]];
    
    [chineseStringsArray sortUsingDescriptors :sortDescriptors];

    NSMutableArray *arrayForArrays = [ NSMutableArray array ];
    
    BOOL checkValueAtIndex= NO ;  //flag to check
 
    NSMutableArray *TempArrForGrouping = nil ;
    
    for ( int index = 0 ; index < [chineseStringsArray count ]; index++)
    {
        ChineseString *chineseStr = ( ChineseString *)[chineseStringsArray objectAtIndex :index];
        
        NSMutableString *strchar= [ NSMutableString stringWithString :chineseStr. pinYin ];
        
        NSString *sr= [strchar substringToIndex : 1 ];
 
        //sr containing here the first character of each string  ( 这里包含的每个字符串的第一个字符 )
        //here I'm checking whether the character already in the selection header keys or not  ( 检查字符是否已经选择头键 )
        
        if (![ _sectionHeadsKeys containsObject :[sr uppercaseString ]])
        {
            [ _sectionHeadsKeys addObject :[sr uppercaseString ]];
            
            TempArrForGrouping = [[ NSMutableArray alloc ] initWithObjects :nil];
            
            checkValueAtIndex = NO ;
        }
        if ([ _sectionHeadsKeys containsObject :[sr uppercaseString ]])
        {
            [TempArrForGrouping addObject :[chineseStringsArray objectAtIndex :index]];
            
            if (checkValueAtIndex == NO )
            {
                [arrayForArrays addObject :TempArrForGrouping];
                
                checkValueAtIndex = YES ;
            }
        }
    }
    [_sectionHeadsKeys insertObject:@"" atIndex:0];
    
    NSMutableArray *Arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.hotArrForArrays.count; i ++) {
        // 创建一个临时的数据模型对象
        ChineseString *chineseStringHot=[[ ChineseString alloc ] init ];
        // 给模型赋值
        
        chineseStringHot. string =[ NSString stringWithString :self.hotArrForArrays[i][@"relname"]];
        [Arr addObject:chineseStringHot];
    }
    [arrayForArrays insertObject:Arr atIndex:0];
    
    return arrayForArrays;
    
}

@end
