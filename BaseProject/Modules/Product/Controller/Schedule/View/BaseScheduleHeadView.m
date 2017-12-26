//
//  BaseScheduleHeadView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseScheduleHeadView.h"

@interface BaseScheduleHeadView ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end
@implementation BaseScheduleHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    BSViewsBorder(self.backView, 10, 0, [UIColor clearColor]);
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
    self.dateFormatter = [[NSDateFormatter alloc] init];
//    [self.dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    [self configureDayLabel];
    [self configureTimeLabel];
    [self configureWeekLabel];
}
//配置时间
- (void)configureTimeLabel
{
    [self.dateFormatter setDateFormat:@"yyyy/MM"];
    NSString *time = [self.dateFormatter stringFromDate:_currentDate];
    self.timeLabel.text = time;
}
//配置日期
- (void)configureDayLabel
{
    [self.dateFormatter setDateFormat:@"dd"];
    NSString *time = [self.dateFormatter stringFromDate:_currentDate];
    self.dayLabel.text = [NSString stringWithFormat:@"%@/",time];
}
//配置星期几
- (void)configureWeekLabel
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:_currentDate];
    NSString *string = comps.weekday == 1 ? @"日" :  comps.weekday == 2 ? @"一" : comps.weekday == 3 ? @"二" : comps.weekday == 4  ? @"三" : comps.weekday == 5  ? @"四" : comps.weekday == 6  ? @"五" : comps.weekday == 7  ? @"六" : @"";
    self.weekLabel.text = [NSString stringWithFormat:@"星期%@",string];
}
@end
