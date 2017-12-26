//
//  BaseScheduleHeadView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScheduleHeadView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;

@property (strong, nonatomic) NSDate *currentDate;
@end
