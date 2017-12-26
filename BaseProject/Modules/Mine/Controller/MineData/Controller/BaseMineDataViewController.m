//
//  BaseMineDataViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/11.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineDataViewController.h"
#import "BaseMineDataTableViewCell.h"
#import "UIActionSheet+BaseActionSheet.h"
#import "JMUpdataImage.h"
#import "MHDatePicker.h"

@interface BaseMineDataViewController ()

@property (nonatomic, strong) UIImage *selectImage;//选中之后的头像图片
@property (nonatomic, assign) BOOL isEdit;//是否为编辑状态
@end

@implementation BaseMineDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self createUI];
    [self createNavButton];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    self.isEdit = !self.isEdit;
    [aSender setTitle:self.isEdit ? @"保存" : @"编辑" forState:UIControlStateNormal];
    if (!self.isEdit) {
        [userManager saveUserInfo:@{@"nickname" : userManager.curUserInfo.nickname,
                                    @"company" : userManager.curUserInfo.company,
                                    @"depatment" : userManager.curUserInfo.depatment,
                                    @"phone" : userManager.curUserInfo.phone,
                                    @"userQQ" : userManager.curUserInfo.userQQ,
                                    @"userWechat" : userManager.curUserInfo.userWechat,
                                    }];
    }
    [self.tableView reloadData];
    
}

#pragma mark  ************** tableView data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : section == 1 ? 3 : 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseMineDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseMineDataTableViewCell" forIndexPath:indexPath];
    cell.messageLabel.text = self.dataSource[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (self.selectImage) {
            cell.rightImage.image = self.selectImage;
        } else {
            cell.imagePath = userManager.curUserInfo.photo;
        }
        
    } else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.nickname];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.nickname = text;
                    DLog(@"----- %@",userManager.curUserInfo.nickname);
                };
            } else {
                cell.rightString = userManager.curUserInfo.nickname;
            }
        } else if (indexPath.row == 1) {
            if (self.isEdit) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.rightString = userManager.curUserInfo.sex  == 2 ? @"女" : @"男" ;
        } else {
            if (self.isEdit) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.rightString = userManager.curUserInfo.birthday;
        }
    } else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.company];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.company = text;
                };
            } else {
                cell.rightString = userManager.curUserInfo.company;
            }
            
        } else if (indexPath.row == 1) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.depatment];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.depatment = text;
                };
            } else {
                cell.rightString = userManager.curUserInfo.depatment;
            }
            
        } else if (indexPath.row == 2) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.phone];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.phone = text;
                };
            } else {
                cell.rightString = userManager.curUserInfo.phone;
            }
            
        } else if (indexPath.row == 3) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.userQQ];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.userQQ = text;
                };
            } else {
                cell.rightString = userManager.curUserInfo.userQQ;
            }
            
        } else if (indexPath.row == 4) {
            if (self.isEdit) {
                [cell showTextField:userManager.curUserInfo.userWechat];
                cell.editContent = ^(NSString *text) {
                    userManager.curUserInfo.userWechat = text;
                };
            } else {
                cell.rightString = userManager.curUserInfo.userWechat;
            }
        }
    }
   return cell;
}

#pragma mark  ************** tableView delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isEdit) {//编辑状态才能选中
        return;
    }
    kWS(weakSelf)
    if (indexPath.section == 0) {
        JMUpdataImage *updataImage = [[JMUpdataImage alloc]init];
        [UIActionSheet showActionSheetWithTitle:@"选择图片方式" confirmTitleFirst:@"从手机相册获取" confirmTitleSecond:@"拍一张" cancelButtonTitle:@"取消" onCancel:^{
        } onFirstConfirm:^{
            [updataImage localPhoto:weakSelf];
            updataImage.callBackImage = ^(NSString *data, UIImage *image) {
                DLog(@"data = %@ \n image = %@",data,image);
                weakSelf.selectImage = image;
                [weakSelf.tableView reloadData];
            };
        } onSecondConfirm:^{
            [updataImage camera:weakSelf];
            updataImage.callBackImage = ^(NSString *data, UIImage *image) {
                DLog(@"data = %@ \n image = %@",data,image);
                weakSelf.selectImage = image;
                [weakSelf.tableView reloadData];
            };
        }];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [UIActionSheet showActionSheetWithTitle:@"选择性别" confirmTitleFirst:@"男" confirmTitleSecond:@"女" cancelButtonTitle:@"取消" onCancel:^{
            } onFirstConfirm:^{
                [userManager saveSex:1];
                [weakSelf.tableView reloadData];
            } onSecondConfirm:^{
                [userManager saveSex:2];
                [weakSelf.tableView reloadData];
            }];
        } else if (indexPath.row == 2) {
            MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
            selectDatePicker.isBeforeTime = YES;
            selectDatePicker.datePickerMode = UIDatePickerModeDate;
            [selectDatePicker setSelectDate:[NSString dateFromString:@"1992-12-19"]];//当前选中的时间
            
            [selectDatePicker didFinishSelectedDate:^(NSString *selectedDate) {
                [userManager saveBirthday:selectedDate];
                [weakSelf.tableView reloadData];
            }];
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark  ************** load data **************
- (void)loadData
{
    [self.dataSource addObjectsFromArray:@[@[@"头像"],@[@"姓名",@"性别",@"出生年月"],@[@"公司",@"部门职位",@"手机",@"QQ",@"微信号"]]];
    if ([userManager loadUserInfo]) {
        
    }
    [self.tableView reloadData];
}

#pragma mark  ************** create UI **************
- (void)createUI
{
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseMineDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseMineDataTableViewCell"];
}
- (void)createNavButton
{
    [self addNavigationItemWithTitles:@[@"编辑"] isLeft:NO target:self tags:nil];
}

#pragma mark  ************** setter /getter **************

@end
