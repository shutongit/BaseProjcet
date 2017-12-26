//
//  BaseMineAttendanceViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/13.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineAttendanceViewController.h"
#import "BaseMineDataTableViewCell.h"
#import "BasePOIMapViewController.h"
#import "BRPickerView.h"
#import "BaseAlertTableView.h"

@interface BaseMineAttendanceViewController ()

@end

@implementation BaseMineAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤设置";
    [self addNavigationItemWithTitles:@[@"完成"] isLeft:NO target:self tags:nil];
    [self createUI];
    [self loadData];
}
#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    DLog(@"考勤设置完成");
}

#pragma mark  ************** tableview data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseMineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineDataTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.message = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}
#pragma mark  ************** tableView delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     BaseMineDataTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            NSString *message = @"上班时间";
            if (indexPath.row == 1) {
                message = @"下班时间";
            }
            [BRDatePickerView showDatePickerWithTitle:message dateType:UIDatePickerModeTime defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                cell.rightString = selectValue;
            }];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            BasePOIMapViewController *poiMap = [[BasePOIMapViewController alloc]init];
            
            poiMap.chooseAddress = ^(NSString *address) {
                cell.rightString = address;
            };
            [self.navigationController pushViewController:poiMap animated:YES];
 
        } else {
            [[BaseAlertTableView sharedBaseAlertTableView] showAlertView:@[@"100",@"200",@"300",@"500",@"1000"]];
            [BaseAlertTableView sharedBaseAlertTableView].chooseData = ^(NSString *message) {
                cell.rightString = message;
            };
        }
            }
//
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark  ************** load data **************
- (void)loadData
{
    [self.dataSource addObjectsFromArray:@[@[@"上班时间",@"下班时间"],@[@"考勤地点",@"有效范围（米）"]]];
    [self.tableView reloadData];
}
#pragma mark  ************** create UI **************
- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineDataTableViewCell"];
}

@end
