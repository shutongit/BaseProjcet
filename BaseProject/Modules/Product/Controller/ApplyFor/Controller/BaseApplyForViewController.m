//
//  BaseApplyForViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/13.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForViewController.h"
#import "BaseApplyForCollectionViewCell.h"
#import "BaseBaseApplyForCollectionReusableView.h"
#import "BaseApplyForAskForLevelViewController.h"
#import "BaseApplyForAskForGoOutViewController.h"
#import "BaseApplyForAskForWorkOverTimeViewController.h"
#import "BaseApplyForAskForAbnormalViewController.h"

@interface BaseApplyForViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *headTitleArray;
@end

@implementation BaseApplyForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交申请";
    self.isHideBarbackground = NO;
    [self cerateUI];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  ************** touch event **************
//下拉方法
- (void)tapAction:(UITapGestureRecognizer *)ges
{
    BaseBaseApplyForReusableModel *model = self.headTitleArray[ges.view.tag];
    if (!model.isSelected) {
        model.isSelected = YES;
    } else {
        model.isSelected = NO;
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:ges.view.tag]];
}
#pragma mark  ************** collection data **************
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BaseBaseApplyForReusableModel *model = self.headTitleArray[section];
    if (!model.isSelected) {
        return [self.dataSource[section] count];
    } else {
        return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseApplyForCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseApplyForCollectionViewCell" forIndexPath:indexPath];
    BaseBaseApplyForReusableModel *model = self.headTitleArray[indexPath.section];
    if (!model.isSelected) {
        [cell.contentButton setTitle:self.dataSource[indexPath.section][indexPath.row] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        BaseBaseApplyForCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseBaseApplyForCollectionReusableView" forIndexPath:indexPath];
        view.tag = indexPath.section;
        view.model = self.headTitleArray[indexPath.section];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        
        return view;
    }
    return nil;
}
#pragma mark  ************** collection delegate **************
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
          BaseApplyForAskForLevelViewController *askForLevel = [[BaseApplyForAskForLevelViewController alloc]init];
            [self.navigationController pushViewController:askForLevel animated:YES];
        } else if (indexPath.row == 1) {
            BaseApplyForAskForGoOutViewController *goOut = [[BaseApplyForAskForGoOutViewController alloc]init];
            [self.navigationController pushViewController:goOut animated:YES];
        } else if (indexPath.row == 2) {
            BaseApplyForAskForWorkOverTimeViewController *workOverTime = [[BaseApplyForAskForWorkOverTimeViewController alloc]init];
            [self.navigationController pushViewController:workOverTime animated:YES];
        } else if (indexPath.row == 3) {
            BaseApplyForAskForAbnormalViewController *abnormal = [[BaseApplyForAskForAbnormalViewController alloc]init];
            [self.navigationController pushViewController:abnormal animated:YES];
        }
    }
    
}
#pragma mark  ************** collectionFlowlayout **************
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KScreenWidth, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth / 3)-1, 60);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 0, 1);
}

#pragma mark  ************** load data **************
- (void)loadData
{
    [self.dataSource addObjectsFromArray:@[@[@"请假申请",@"外出申请",@"加班申请",@"考勤异常",@"出差申请",@"调休申请"],
                                           @[@"财务报销",@"现金预支",@"付款申请",@"开票申请"],
                                           @[@"招聘申请",@"转正申请",@"岗位调动",@"薪资调整",@"离职申请"],
                                           @[@"用章申请",@"招待申请",@"名片申请",@"活动申请",@"证件借用",@""],
                                           @[@"合同申请"]]];
    NSArray * array = @[@{@"name" : @"考勤申请"},
                        @{@"name" : @"财务申请"},
                        @{@"name" : @"人事申请"},
                        @{@"name" : @"行政申请"},
                        @{@"name" : @"其他申请"}];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseBaseApplyForReusableModel *model = [BaseBaseApplyForReusableModel mj_objectWithKeyValues:obj];
        [self.headTitleArray addObject:model];
    }];
    
    
    [self.collectionView reloadData];
}
#pragma mark  ************** create UI **************
- (void)cerateUI
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseApplyForCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BaseApplyForCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseBaseApplyForCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseBaseApplyForCollectionReusableView"];
}

#pragma mark  ************** setter / getter **************
- (NSMutableArray *)headTitleArray
{
    if (!_headTitleArray) {
        _headTitleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _headTitleArray;
}
@end
