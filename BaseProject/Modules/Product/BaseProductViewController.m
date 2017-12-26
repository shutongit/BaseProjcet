//
//  BaseProductViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseProductViewController.h"
#import "BaseCustormFlowLayout.h"
#import "BaseProductCollectionViewCell.h"
#import "BaseProductHeadCollectionReusableView.h"
#import "BaseProductBannerView.h"
#import "lhScanQCodeViewController.h"
#import "BaseApplyForViewController.h"
#import "BaseScheduleViewController.h"

@interface BaseProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BaseCustormFlowLayoutDelegate>

@property (nonatomic, strong) NSArray *headTitleArr;
@property (nonatomic, strong) BaseProductBannerView *bannerView;

@end

@implementation BaseProductViewController
//应用
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    [self addNaviButton];
    [self createBannerView];
    [self createUI];
    [self loadData];
}
#pragma mark  ************** touch event **************
- (void)titleButtonAction:(UIButton *)aSender
{
    if (aSender.tag == 10) {
        DLog(@"扫一扫");
        lhScanQCodeViewController *scanVC = [[lhScanQCodeViewController alloc]init];
        [self.navigationController pushViewController:scanVC animated:YES];
    } else {
        DLog(@"应用管理");
    }
}
#pragma mark  ************** load data **************
- (void)loadData
{
    self.headTitleArr = @[@"特色功能",@"协同办公",@"销售管理"];
    NSArray *array = @[@{@"image":@"ProductDefault", @"name":@"指尖办事"},
                       @{@"image":@"ProductDefault", @"name":@"党建地图"},
                       @{@"image":@"ProductDefault", @"name":@"活动投票"},
                       @{@"image":@"ProductDefault", @"name":@"微心愿"},
                       @{@"image":@"ProductDefault", @"name":@"申请"},
                       @{@"image":@"ProductDefault", @"name":@"日程"},
                       @{@"image":@"ProductDefault", @"name":@"首页0"},
                       @{@"image":@"ProductDefault", @"name":@"首页1"},];
    [self.dataSource addObjectsFromArray:array];
    [self.collectionView reloadData];
}

//处于编辑状态
- (void)didChangeEditState:(BOOL)inEditState
{
    //    self.inEditState = inEditState;
    //    self.rightBtn.selected = inEditState;
    //    for (SYLifeManagerCell *cell in self.collectionView.visibleCells) {
    //        cell.inEditState = inEditState;
    //    }
}

//改变数据源中model的位置
- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath
{
    NSArray *array = self.dataSource[formPath.row];
    
    [self.dataSource removeObject:array];
    [self.dataSource insertObject:array atIndex:toPath.row];
    [self.collectionView reloadData];
}
#pragma mark  ************** collection data **************
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseProductCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSource[indexPath.row][@"name"];
    cell.contentImageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"image"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BaseRootWebViewController *web = [[BaseRootWebViewController alloc]init];
        if ((indexPath.row == 0)) {
            web.url = @"http://ideal.weshdj.com/idealDJPCS/wxcore/web/comment/comment.action";
            [self.navigationController pushViewController:web animated:YES];
        } else if (indexPath.row == 1) {
            web.url = @"http://ideal.weshdj.com/idealDJPCS/wxcore/web/resources/resources!education.action";
            [self.navigationController pushViewController:web animated:YES];
        } else if (indexPath.row == 2) {
            web.url = @"http://ideal.weshdj.com/idealDJPCS/wxcore/web/vote/vote.action";
            [self.navigationController pushViewController:web animated:YES];
        } else if (indexPath.row == 3) {
            web.url = @"http://ideal.weshdj.com/idealDJPCS/wxcore/web/wish/wish!ypd.action";
            [self.navigationController pushViewController:web animated:YES];
        } else if (indexPath.row == 4) {
            BaseApplyForViewController *applyfor = [[BaseApplyForViewController alloc]init];
            [self.navigationController pushViewController:applyfor animated:YES];
        } else if (indexPath.row == 5) {
            BaseScheduleViewController *schedule = [[BaseScheduleViewController alloc]init];
            [self.navigationController pushViewController:schedule animated:YES];
        }
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BaseProductHeadCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseProductHeadCollectionReusableView" forIndexPath:indexPath];
    headView.nameLabel.text = self.headTitleArr[indexPath.section];
    return headView;
}
#pragma mark  ************** collection flowlayout **************
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KScreenWidth / 4, 70);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KScreenWidth, 30);
}
#pragma mark  ************** create UI **************
//bannerview
- (void)createBannerView
{
    self.bannerView = [[BaseProductBannerView alloc]initWithFrame:CGRectMake(0, NavHeight, KScreenWidth, 150)];
    [self.view addSubview:self.bannerView];
    kWS(weakSelf)
    self.bannerView.closeBlock = ^{//关闭视图
        [UIView animateWithDuration:1 animations:^{
            weakSelf.collectionView.y = NavHeight;
            weakSelf.collectionView.height = KScreenHeight - TabHeight;
        }];
    };
    self.bannerView.clickBanner = ^(NSInteger index) {
        DLog(@"点击了第%ld个banner",index);
    };
}
//collectionView
- (void)createUI
{
    BaseCustormFlowLayout *flowLayout = [[BaseCustormFlowLayout alloc]init];
    flowLayout.delegate = self;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self changeCollectionFrameWithHeight:150+NavHeight];
    self.collectionView.mj_header = nil;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BaseProductCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseProductHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseProductHeadCollectionReusableView"];
}
//添加导航栏按钮
- (void)addNaviButton
{
    [self addNavigationItemWithTitles:@[@"扫一扫"] isLeft:YES target:self tags:@[@10]];
    [self addNavigationItemWithTitles:@[@"应用管理"] isLeft:NO target:self tags:@[@11]];
}

- (void)changeCollectionFrameWithHeight:(CGFloat)height
{
    self.collectionView.y = height;
    self.collectionView.height = KScreenHeight - TabHeight - height;
}
#pragma mark  ************** setter / getter **************

@end
