//
//  BaseMineCompanyViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/12.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineCompanyViewController.h"
#import "BaseMineDataTableViewCell.h"
#import "BaseMineCompanyDissmissTableViewCell.h"
#import "BaseAlertTableView.h"

@interface BaseMineCompanyViewController ()

@property (nonatomic, strong) NSMutableArray *companyData;
@property (nonatomic, assign) BOOL isEdit;//是否为编辑状态
@end

@implementation BaseMineCompanyViewController
//公司信息
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司信息";
    [self createUI];
    [self loadData];
}
#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    self.isEdit = !self.isEdit;
    [aSender setTitle:self.isEdit ? @"保存" : @"编辑" forState:UIControlStateNormal];
    if (self.isEdit) {
        
        if (self.dataSource.count > 0 && self.companyData.count > 0) {
            NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:1];
            [array1 addObjectsFromArray:self.dataSource[0]];
            [array2 addObjectsFromArray:self.companyData[0]];
            //            NSInteger index = [array indexOfObject:@"公司ID"];
            //            if (index != NSNotFound) {
            //                [array removeObjectAtIndex:index];
            //                [self.dataSource replaceObjectAtIndex:0 withObject:array];
            //            }
            for (int i = 0; i < [self.dataSource[0] count]; i ++) {
                NSString *string = self.dataSource[0][i];
                if ([string isEqualToString:@"公司ID"] || [string isEqualToString:@"公司二维码"]) {
                    [array1 removeObjectAtIndex:i];
                    [array2 removeObjectAtIndex:i];
                }
            }
            [self.dataSource replaceObjectAtIndex:0 withObject:array1];
            [self.companyData replaceObjectAtIndex:0 withObject:array2];
            [self.tableView reloadData];
        }
        
    } else {
        [self.dataSource removeAllObjects];
        [self.companyData removeAllObjects];
        [self loadData];
    }
}

#pragma mark  ************** tableView datasource **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isEdit ? self.dataSource.count + 1 : self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isEdit) {
        if (section == 2) {
            return 1;
        }
    }
    return [self.dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        BaseMineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineDataTableViewCell" forIndexPath:indexPath];
        cell.message = self.dataSource[indexPath.section][indexPath.row];
        if (self.isEdit) {
            if (indexPath.section == 0) {
                [cell showTextField:self.companyData[indexPath.section][indexPath.row]];
            } else {
                if (indexPath.row != 4) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [cell showChooseLabel:self.companyData[indexPath.section][indexPath.row]];
                } else {
                    [cell showTextField:self.companyData[indexPath.section][indexPath.row]];
                    
                }
            }
            cell.editContent = ^(NSString *text) {
                //可以自定义model 保存修改过的数据。从cell中获取全局的model
                DLog(@"text == %@",text);
            };
        } else {
            if (indexPath.section == 0 && indexPath.row == 2) {
                cell.imagePath = self.companyData[indexPath.section][indexPath.row];
            } else {
                cell.rightString = self.companyData[indexPath.section][indexPath.row];
            }
            
        }
        return cell;
    } else {
        BaseMineCompanyDissmissTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineCompanyDissmissTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    
}

#pragma mark  ************** tableview delegate **************
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEdit) {
        if (indexPath.section == 1 && indexPath.row != 4) {
            [[BaseAlertTableView sharedBaseAlertTableView] showAlertView:@[@"1",@"2",@"3"]];
            
        } else if (indexPath.section == 2) {
            DLog(@"解散公司");
        }
    }
}

#pragma mark  ************** create UI **************
- (void)createUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineDataTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineCompanyDissmissTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineCompanyDissmissTableViewCell"];
    
    [self addNavigationItemWithTitles:@[@"编辑"] isLeft:NO target:self tags:nil];
}

#pragma mark  ************** load data **************
- (void)loadData
{
    [self.dataSource addObjectsFromArray:@[@[@"公司名称",@"公司ID",@"公司二维码",@"联系人",@"联系人手机"],@[@"所属行业",@"公司座机",@"公司性质",@"员工数",@"公司地址"]]];
    [self.companyData addObjectsFromArray:@[@[@"上海理想",@"0001",@"userface",@"田亮",@"189189181891"],@[@"iT",@"1234568",@"民营",@"1000+",@"上海市浦东新区秀研西路"]]];
    [self.tableView reloadData];
}
#pragma mark  ************** setter / getter  **************

- (NSMutableArray *)companyData
{
    if (!_companyData) {
        _companyData = [NSMutableArray arrayWithCapacity:0];
    }
    return _companyData;
}
@end
