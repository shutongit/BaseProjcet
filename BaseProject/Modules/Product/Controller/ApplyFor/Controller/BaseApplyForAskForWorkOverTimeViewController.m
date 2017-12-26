//
//  BaseApplyForAskForWorkOverTimeViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/15.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForAskForWorkOverTimeViewController.h"
#import "BaseMineDataTableViewCell.h"
#import "BaseAlertTableView.h"
#import "BaseApplyForAskForLevelTimeTableViewCell.h"
#import "BaseApplyForAskTextFieldTableViewCell.h"

@interface BaseApplyForAskForWorkOverTimeViewController ()

@end

@implementation BaseApplyForAskForWorkOverTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建加班申请";
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
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        BaseApplyForAskForLevelTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskForLevelTimeTableViewCell" forIndexPath:indexPath];
        cell.chooseBegainTime = ^(NSString *begain) {
            DLog(@"begain == %@",begain);
        };
        cell.chooseEndTime = ^(NSString *end) {
            DLog(@"end == %@",end);
        };
        return cell;
    } else if (indexPath.section == 4){
        BaseApplyForAskTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseApplyForAskTextFieldTableViewCell" forIndexPath:indexPath];
        cell.placeHoldString = @"请输入加班理由...";
        cell.textViewText = ^(NSString *text) {
            DLog(@"text view text = %@",text);
        };
        return cell;
    }
    BaseMineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineDataTableViewCell" forIndexPath:indexPath];
    
    cell.rightLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.section == 3) {
        cell.message = @"小时";
        cell.rightTextField.textAlignment = NSTextAlignmentRight;
        cell.rightTextField.placeholder = @"请输入加班小时";
        [cell showTextField:@""];
        cell.editContent = ^(NSString *text) {
            DLog(@"text == %@",text);
        };
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *messgeArray = @[@"审批流程",@"加班类型"];
        NSArray *tipArray = @[@"请选择审批流程",@"请选择加班类型"];
        cell.message = messgeArray[indexPath.section];
        cell.rightString = tipArray[indexPath.section];
    }
    
    return cell;
}
#pragma mark  ************** tableveiw delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [[BaseAlertTableView sharedBaseAlertTableView]showAlertView:@[@"平日",@"周末",@"节假日"]];
        [BaseAlertTableView sharedBaseAlertTableView].chooseData = ^(NSString *message) {
            BaseMineDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.rightLabel.textColor = [UIColor blackColor];
            cell.rightString = message;
        };
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 2 ? 60 : indexPath.section == 4 ? 100 :44;
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