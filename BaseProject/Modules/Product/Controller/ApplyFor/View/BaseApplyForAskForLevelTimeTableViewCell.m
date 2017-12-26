//
//  BaseApplyForAskForLevelTimeTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/14.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForAskForLevelTimeTableViewCell.h"
#import "BRPickerView.h"

@implementation BaseApplyForAskForLevelTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.pickMode = UIDatePickerModeDateAndTime;
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTap:)];
    [self.leftView addGestureRecognizer:leftTap];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTap:)];
    [self.rightView addGestureRecognizer:rightTap];
}
#pragma mark  ************** touch event **************
- (void)leftTap:(UITapGestureRecognizer *)tap
{
    kWS(weakSelf)
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:self.pickMode defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        weakSelf.leftContentLabel.text = selectValue;
        if (_chooseBegainTime) {
            _chooseBegainTime(selectValue);
        }
    }];
}
- (void)rightTap:(UITapGestureRecognizer *)tap
{
    kWS(weakSelf)
    [BRDatePickerView showDatePickerWithTitle:@"结束时间" dateType:self.pickMode defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        weakSelf.rightContentLabel.text = selectValue;
        if (_chooseEndTime) {
            _chooseEndTime(selectValue);
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
