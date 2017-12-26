//
//  BaseMineViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineViewController.h"
#import "BaseButtonView.h"
#import "TitleScrollView.h"
#import "BaseAppManager.h"
#import "UIAlertView+Extension.h"
#import "BaseMineHeadTableViewCell.h"
#import "BaseMineModel.h"
#import "BaseMineDataViewController.h"
#import "BaseMineCompanyViewController.h"
#import "lhScanQCodeViewController.h"
#import "BaseMineManagerViewController.h"
@interface BaseMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideBarbackground = NO;
    [self createUI];
    [self loadData];
    
    [userManager saveUserInfo:@{@"userId" : @"003",
                                @"idcard" : @"13166266570",
                                @"photo" : @"",
                                @"nickname" : @"shutong",
                                @"birthday" : @"1992-12-19",
                                @"sex" : @"0",
                                @"signature" : @"工作中",
                                @"token" : @"",
                                @"company" : @"理想",
                                @"depatment" : @"软1",
                                @"phone" : @"13166266570",
                                @"userQQ" : @"1353044148",
                                @"userWechat" : @"shut920709",
                                }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ************** load data **************
- (void)loadData
{
    NSDictionary *dic = @{@"First" : @[@{@"image":@"userface" , @"name":@"公司信息"},
                                       @{@"image":@"userface" , @"name":@"管理员专区"},
                                       @{@"image":@"userface" , @"name":@"我的点币"},
                                       @{@"image":@"userface" , @"name":@"扫一扫"},
                                       @{@"image":@"userface" , @"name":@"增值服务"},
                                       @{@"image":@"userface" , @"name":@"邀请有礼"}],
                          @"Second" : @[
                                  @{@"image":@"userface" , @"name":@"帮助文档"},
                                  @{@"image":@"userface" , @"name":@"信息反馈"},
                                  @{@"image":@"userface" , @"name":@"关于我们"}
                                  ],
                          @"Third" : @[
                                  @{@"image":@"userface" , @"name":@"设置"}]};
    [self.dataSource addObject:[BaseMineModel mj_objectWithKeyValues:dic]];
    
    [self.tableView reloadData];
}

#pragma mark  ************** tableview data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseMineModel *model = self.dataSource.firstObject;
    return section == 0 ? 1 : section == 1 ? model.First.count : section == 3 ? model.Third.count : model.Second.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BaseMineHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineHeadTableViewCell" forIndexPath:indexPath];
        
        return cell;
    } else {
        BaseMineModel *model = self.dataSource.firstObject;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if (indexPath.section == 1) {
            cell.textLabel.text = [model.First[indexPath.row] name];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[model.First[indexPath.row] image]]];
        } else if (indexPath.section == 2) {
            cell.textLabel.text = [model.Second[indexPath.row] name];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[model.Second[indexPath.row] image]]];
        } else if (indexPath.section == 3) {
            cell.textLabel.text = [model.Third[indexPath.row] name];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[model.Third[indexPath.row] image]]];
        }
        
        return cell;
    }
}

#pragma mark  ************** tableview delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BaseMineDataViewController *dataVC = [[BaseMineDataViewController alloc]init];
        [self.navigationController pushViewController:dataVC animated:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            BaseMineCompanyViewController *company = [[BaseMineCompanyViewController alloc]init];
            [self.navigationController pushViewController:company animated:YES];
        } else if (indexPath.row == 1) {
            BaseMineManagerViewController *manager = [[BaseMineManagerViewController alloc]init];
            [self.navigationController pushViewController:manager animated:YES];
        } if (indexPath.row == 2) {
            
            
        } if (indexPath.row == 3) {
            lhScanQCodeViewController *scan = [[lhScanQCodeViewController alloc]init];
            [self.navigationController pushViewController:scan animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return indexPath.section == 0 ? 80 : 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark  ************** create UI **************
- (void)createUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineHeadTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}



//- (void)createUI
//{
//    NSArray *titleArray = @[@"清理缓存",@"审批",@"考勤打卡",@"日程",@"公告"];
//    NSArray *imageArray = @[@"LCTabBarBadge",@"icon_tabbar_onsite_selected",@"icon_tabbar_mine",@"icon_tabbar_merchant_selected",@"icon_tabbar_merchant"];
//
//    BaseButtonView *buttonView = [[BaseButtonView alloc]initWithFrame:CGRectMake(0, 150, KScreenWidth, MIN(titleArray.count, imageArray.count) % 4 * 75 + 75 + 10)];
//    [buttonView configureButtonImages:imageArray titles:titleArray];
//    buttonView.clickButton = ^(NSInteger index) {
//        DLog(@"点击了 %ld",index);
//        if (index == 10) {
//            NSString *message = [NSString stringWithFormat:@"确认清理%0.2f缓存?",[BaseAppManager readCacheSize]];
//            [UIAlertView showAlertViewWithTitle:@"" message:message cancelButtonTitle:@"取消" confirmButtonTitle:@"确认" onCancel:^{
//
//            } onConfirm:^{
//                [BaseAppManager clearFile];
//            }];
//
//        }
//    };
//    [self.view addSubview:buttonView];
//}
//
//#pragma mark  ************** setter /getter  **************
//- (TitleScrollView *)titlescroll
//{
//    if (!_titlescroll) {
//
////        kWS(weakSelf);
//        _titlescroll = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, NavHeight, KScreenWidth, 44) TitleArray:@[@"任务",@"审批",@"考勤打卡",@"日程",@"公告"] selectedIndex:0 scrollEnable:NO lineEqualWidth:NO Increase:NO selectColor:CNavBgColor2 defaultColor:CFontColor1 SelectBlock:^(NSInteger index) {
//            DLog(@"点击了 -- %ld",index);
//
//        }];
//        _titlescroll.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:_titlescroll];
//    }
//    return _titlescroll;
//}
@end
