//
//  DCSearchResultCell.m
//  maxscreen－1.0
//
//  Created by maxscrenn on 15/11/30.
//  Copyright © 2015年 maxscrenn. All rights reserved.
//

#import "DCSearchResultCell.h"
#import "DCSearchResultModel.h"
@interface DCSearchResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;

@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@end
@implementation DCSearchResultCell

- (void)awakeFromNib {

}

-(void)setResultModel:(DCSearchResultModel *)resultModel
{
    _resultModel = resultModel;
    
    [self.userImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",resultModel.photos]]];
    self.userLabel.text = resultModel.relname;
    self.sexImage.contentMode = UIViewContentModeScaleAspectFit;
    if (resultModel.sex == 0) {
        self.sexImage.image = [UIImage imageNamed:@"联系同事－实心性别女图标@2x.png"];
    }
    else
    {
        self.sexImage.image = [UIImage imageNamed:@"联系同事－实心性别男图标@2x.png"];
    }
    self.groupLabel.text = self.resultModel.group_job[@"group"];
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"cell";
    DCSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCSearchResultCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


@end
