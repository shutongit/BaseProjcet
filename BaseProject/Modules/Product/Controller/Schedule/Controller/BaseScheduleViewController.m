//
//  BaseScheduleViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseScheduleViewController.h"
#import "JTCalendar.h"
#import "BaseScheduleCalerdarListView.h"
#import "BaseScheduleAddEventViewController.h"
#import "BaseScheduleHeadView.h"

#define HeadHeight 120

@interface BaseScheduleViewController ()<JTCalendarDataSource>

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)  JTCalendarContentView *calendarContentView;
@property (strong, nonatomic) JTCalendar *calendar;
@property (assign, nonatomic) BOOL isEvent;//是否有事件
@property (strong, nonatomic) BaseScheduleCalerdarListView *calendarListView;
@property (strong, nonatomic) NSDate *selectedDate;//选中的日期
@property (strong, nonatomic) BaseScheduleHeadView *ScheduleHeadView;
@end

@implementation BaseScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日程";
    [self addNavigationItemWithTitles:@[@"今日"] isLeft:NO target:self tags:nil];
    [self configureCalender];
    [self createUI];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark  ************** touch event **************
//当前日期
- (void)titleButtonAction:(UIButton *)aSender
{
    [self.calendar setCurrentDate:[NSDate date]];
}
#pragma mark  ************** JTCalendarDataSource **************
//显示小圆点
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    BOOL isHave = (rand() % 10) == 1;
    NSString *event = isHave ? @"没有事件" : @"有事件";
    DLog(@"是否有事件 -> %d -> %@",isHave,event);
    return isHave;
}
//点击事件
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date isEvent:(BOOL)isEvent
{
    self.isEvent = isEvent;
    self.selectedDate = date;
    DLog(@"Date: %@", date);
}
#pragma mark  ************** configu calender **************
- (void)configureCalender
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    self.calendar = [JTCalendar new];
    
    //    {
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;//阴影部分
    self.calendar.calendarAppearance.ratioContentMenu = 1.;//导航栏显示几个月份
    //    }
//    self.calendarMenuView = [[JTCalendarMenuView alloc]initWithFrame:CGRectMake(0, NavHeight, KScreenWidth, NavHeight)];
//    [self.view addSubview:self.calendarMenuView];
    
    self.calendarContentView = [[JTCalendarContentView alloc]initWithFrame:CGRectMake(0, NavHeight + HeadHeight, KScreenWidth, KScreenWidth*3/4)];
    [self.view addSubview:self.calendarContentView];
//    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
}
- (void)createUI
{
    //头视图
    self.ScheduleHeadView = [[[NSBundle mainBundle]loadNibNamed:@"BaseScheduleHeadView" owner:self options:nil] firstObject];
    self.ScheduleHeadView.frame = CGRectMake(0, NavHeight, KScreenWidth, HeadHeight);
    self.ScheduleHeadView.currentDate = [NSDate date];
    [self.view addSubview:self.ScheduleHeadView];
    
    //列表视图
    self.calendarListView = [[BaseScheduleCalerdarListView alloc]initWithFrame:CGRectMake(0, KScreenWidth*3/4 + NavHeight + HeadHeight, KScreenWidth, KScreenHeight - (KScreenWidth*3/4 + NavHeight + HeadHeight))];
    self.calendarListView.dataSource = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    kWS(weakSelf)
    self.calendarListView.clickAddEvent = ^{
        DLog(@"添加事件%@",weakSelf.selectedDate);
        BaseScheduleAddEventViewController *addEvent = [[BaseScheduleAddEventViewController alloc]init];
        [weakSelf.navigationController pushViewController:addEvent animated:YES];
    };
    [self.view addSubview:self.calendarListView];
}

@end
