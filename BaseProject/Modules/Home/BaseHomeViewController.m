//
//  BaseHomeViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseHomeViewController.h"

#import "BaseHomeTableViewCell.h"
@interface BaseHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation BaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"100"];
    [self addNavigationItemWithTitles:@[@"网页"] isLeft:NO target:self tags:nil];
    [self createUI];
    [self loadData];
}

#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    BaseRootWebViewController *webView = [[BaseRootWebViewController alloc] initWithUrl:@"http://www.hao123.com"];
    [self.navigationController pushViewController:webView animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseHomeTableViewCell" forIndexPath:indexPath];
    cell.messageLabel.text = self.datasource[indexPath.row];
    return cell;
}
#pragma mark  ************** tablevie delegate **************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark  ************** load data **************
- (void)loadData
{
    [self.datasource addObjectsFromArray:@[@"审批加入公司",@"系统通知",@"关怀祝福",@"同事圈消息"]];
    [self.tableView reloadData];
}

#pragma mark  ************** create UI **************
- (void)createUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseHomeTableViewCell"];
}

#pragma mark  ************** setter / getter  **************
- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _datasource;
}

@end
