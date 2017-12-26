//
//  BaseApplyForAskForGoOutViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/15.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForAskForGoOutViewController.h"
#import "BaseMineDataTableViewCell.h"
#import "BaseAlertTableView.h"
#import "BaseApplyForAskForLevelTimeTableViewCell.h"
#import "BaseApplyForAskTextFieldTableViewCell.h"
#import "BRDatePickerView.h"

@interface BaseApplyForAskForGoOutViewController ()

@end

@implementation BaseApplyForAskForGoOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建外出申请";
    [self addNavigationItemWithTitles:@[@"提交"] isLeft:NO target:self tags:nil];
    [self createUI];
}

#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    DLog(@"提交");
}
- (void)backBtnClicked
{
    kWS(weakSelf)
    [self alertWithMessage:@"是否确认退出页面" cancelTitle:@"取消" confirmTitle:@"确认" cancelBlock:^{
        
    } confirmBlock:^{
        if (weakSelf.presentingViewController) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}
#pragma mark  ************** tableview data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        BaseApplyForAskForLevelTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskForLevelTimeTableViewCell" forIndexPath:indexPath];
        cell.pickMode = UIDatePickerModeTime;
        cell.chooseBegainTime = ^(NSString *begain) {
            DLog(@"begain == %@",begain);
        };
        cell.chooseEndTime = ^(NSString *end) {
            DLog(@"end == %@",end);
        };
        return cell;
    } else if (indexPath.section == 3){
        BaseApplyForAskTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskTextFieldTableViewCell" forIndexPath:indexPath];
        
        cell.placeHoldString = @"请输入外出理由...";
        cell.textViewText = ^(NSString *text) {
            DLog(@"text view text = %@",text);
        };
        return cell;
    }
    BaseMineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineDataTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.rightLabel.textColor = [UIColor lightGrayColor];
    NSArray *messgeArray = @[@"审批流程",@"外出日期"];
    NSArray *tipArray = @[@"请选择审批流程",@"请选择外出日期"];
    cell.message = messgeArray[indexPath.section];
    cell.rightString = tipArray[indexPath.section];
    return cell;
}
#pragma mark  ************** tableveiw delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [BRDatePickerView showDatePickerWithTitle:@"时间" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
            BaseMineDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.rightString = selectValue;
        }];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 2 ? 60 : indexPath.section == 3 ? 100 :44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark  ************** create UI **************
- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineDataTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseApplyForAskForLevelTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseApplyForAskForLevelTimeTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseApplyForAskTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseApplyForAskTextFieldTableViewCell"];
}

@end
