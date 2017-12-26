//
//  BaseMineManagerViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/12.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineManagerViewController.h"
#import "BaseMineTableViewCell.h"
#import "BaseMineAttendanceViewController.h"

@interface BaseMineManagerViewController ()

@end

@implementation BaseMineManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理员专区";
    [self createUI];
    [self loadData];
}
- (void)loadData
{
    [self.dataSource addObjectsFromArray:@[@"企业认证",@"组织架构",@"考勤设置",@"权限设置"]];
    [self.tableView reloadData];
}
#pragma mark  ************** tableView datasource **************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.messageLabel.text = self.dataSource[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:@"userface"];
    return cell;
}
#pragma mark  ************** tableview delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row  == 2) {
        BaseMineAttendanceViewController *attendance = [[BaseMineAttendanceViewController alloc]init];
        [self.navigationController pushViewController:attendance animated:YES];
    }
}

#pragma mark  ************** create UI **************
- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineTableViewCell"];
}
@end
