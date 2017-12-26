//
//  BaseScheduleAddEventViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseScheduleAddEventViewController.h"
#import "BaseScheduleAddEventTitleTableViewCell.h"
#import "BaseApplyForAskTextFieldTableViewCell.h"
#import "BaseApplyForAskForLevelTimeTableViewCell.h"
#import "BaseScheduleAddEventAddMessageTableViewCell.h"
#import "BaseAlertTableView.h"
#import "BasePOIMapViewController.h"

@interface BaseScheduleAddEventViewController ()

@end

@implementation BaseScheduleAddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建日程";
    [self addNavigationItemWithTitles:@[@"提交"] isLeft:NO target:self tags:nil];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    DLog(@"新建日程提交");
}

#pragma mark  ************** tableView data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BaseScheduleAddEventTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseScheduleAddEventTitleTableViewCell" forIndexPath:indexPath];
        cell.contentText = ^(NSString *text) {
            DLog(@"text == %@",text);
        };
        return cell;
    } else if (indexPath.section == 1) {
        BaseApplyForAskForLevelTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskForLevelTimeTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 5) {
        BaseApplyForAskTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskTextFieldTableViewCell" forIndexPath:indexPath];
        cell.textViewText = ^(NSString *text) {
            DLog(@"text == %@",text);
        };
        return cell;
    }
    BaseScheduleAddEventAddMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseScheduleAddEventAddMessageTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark  ************** tableView delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
    } else if (indexPath.section == 3) {
        [[BaseAlertTableView sharedBaseAlertTableView] showAlertView:@[@"无",@"准时提醒",@"5分钟前",@"15分钟前",@"30分钟前",@"1小时前",@"2小时前"]];
        [BaseAlertTableView sharedBaseAlertTableView].chooseData = ^(NSString *message) {
            DLog(@"message == %@",message);
            BaseScheduleAddEventAddMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.messageLabel.text = message;
            cell.messageLabel.textColor = [UIColor blackColor];
        };
    } else if (indexPath.section == 4) {
        BasePOIMapViewController *POIMap = [[BasePOIMapViewController alloc]init];
        POIMap.chooseAddress = ^(NSString *address) {
            BaseScheduleAddEventAddMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.messageLabel.text = address;
            cell.messageLabel.textColor = [UIColor blackColor];
        };
        [self.navigationController pushViewController:POIMap animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 60;
    } else if (indexPath.section == 5) {
        return 100;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark  ************** create UI **************
- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseScheduleAddEventTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseScheduleAddEventTitleTableViewCell"];//textField
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseApplyForAskTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseApplyForAskTextFieldTableViewCell"];//textView
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseApplyForAskForLevelTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseApplyForAskForLevelTimeTableViewCell"];//时间
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseScheduleAddEventAddMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseScheduleAddEventAddMessageTableViewCell"];//相关信息
}

@end
