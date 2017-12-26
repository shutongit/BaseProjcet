//
//  BaseRootViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseRootViewController.h"
#import "BaseLogInViewController.h"
#import "UIAlertView+Extension.h"

@interface BaseRootViewController ()
@property (nonatomic,strong) UIImageView* noDataView;

@end

@implementation BaseRootViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //是否显示返回按钮
    self.isShowLiftBack = YES;
    //隐藏nav黑色的线
    self.isHideBarbackground = YES;
    //默认导航栏样式：黑字
    self.StatusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)dealloc
{
    [self cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark  ************** touch event **************
//返回按钮事件
- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//文字按钮点击事件
- (void)titleButtonAction:(UIButton *)aSender
{
    if (self.isBackButton) {
       DLog(@"用到文字按钮点击事件的时候重写titleButtonAction方法");
    } else {
        [self backBtnClicked];
    }
    
    
}
//图片按钮点击事件
- (void)imageButtonAction:(UIButton *)aSender
{
    if (self.isBackButton) {
        DLog(@"用到图片按钮点击事件的时候重写titleButtonAction方法");
    } else {
        [self backBtnClicked];
    }
    
}

#pragma mark  ************** public method **************
//添加左／右图片按钮
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target tags:(NSArray *)tags
{
    self.isBackButton = NO;
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        if(isLeft){
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
            
        }
        [btn addTarget:target action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}
//添加左／右文字按钮
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target  tags:(NSArray *)tags
{
    self.isBackButton = NO;
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //调整按钮位置
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width= -10;
    [items addObject:spaceItem];
    
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, 30, 20);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

//以登录界面根控制器
- (void)goLogin
{
    BaseNavgationViewController *loginNavi =[[BaseNavgationViewController alloc] initWithRootViewController:[BaseLogInViewController new]];
    [self presentViewController:loginNavi animated:YES completion:nil];
}
//跳转登录
- (void)goLoginWithPush
{
    [self.navigationController pushViewController:[BaseLogInViewController new] animated:YES];
}
//需要登录
- (void)showShouldLoginPoint{
    DLog(@"用到需要登录的时候重写showShouldLoginPoint方法");
}
//加载视图
- (void)showLoadingAnimation
{
    DLog(@"用到加载视图的时候重写showLoadingAnimation方法");
}
//停止加载
- (void)stopLoadingAnimation
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    if (_collectionView) {
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }
    DLog(@"用到停止加载的时候重写stopLoadingAnimation方法");
}
//刷新数据
-(void)headerRereshing
{
    [self stopLoadingAnimation];
    DLog(@"用到刷新数据的时候重写headerRereshing方法");
}
//加载更多数据
-(void)footerRereshing
{
    [self stopLoadingAnimation];
    DLog(@"用到加载更多数据的时候重写footerRereshing方法");
}
//取消请求
- (void)cancelRequest
{
    DLog(@"用到取消请求的时候重写cancelRequest方法");
}

/**
 *  是否显示返回按钮
 */
- (void) setIsShowLiftBack:(BOOL)isShowLiftBack
{
    _isShowLiftBack = isShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        self.isBackButton = YES;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"homeBack"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = item;
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

//是否隐藏Navgation下面的一条线
- (void)setIsHideBarbackground:(BOOL)isHideBarbackground
{
    _isHideBarbackground = isHideBarbackground;
    if ([UINavigationBar appearance].translucent) {
        self.navigationController.navigationBar.subviews[0].subviews[1].hidden = isHideBarbackground;
    } else {
        self.navigationController.navigationBar.subviews[0].subviews[0].hidden = isHideBarbackground;
    }
}

#pragma mark  ************** tableview data **************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseRootViewTabelViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseRootViewTabelViewCell"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
//提示框
- (void)alertWithMessage:(NSString *)message
             cancelTitle:(NSString *)cancelTitle
            confirmTitle:(NSString *)confirmTitle
             cancelBlock:(void (^)())cancelBlock
            confirmBlock:(void (^)())confirmBlock
{
    [UIAlertView showAlertViewWithTitle:@"提示" message:message cancelButtonTitle:cancelTitle confirmButtonTitle:confirmTitle onCancel:cancelBlock onConfirm:confirmBlock];
}
#pragma mark  ************** 无数据视图 **************
-(void)showNoDataImage
{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:_noDataView];
        }
    }];
}

-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

#pragma mark  ************** setter / getter **************
/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, KScreenWidth, KScreenHeight-NavHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc]  init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //头部刷新
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//        header.automaticallyChangeAlpha = YES;
//        header.lastUpdatedTimeLabel.hidden = NO;
//        _tableView.mj_header = header;
        
        //底部刷新
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        //        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        //        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        
#ifdef kiOS11Before
        
#else
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
#endif
        
        
        _tableView.backgroundColor=CViewBgColor;
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavHeight, KScreenWidth , KScreenHeight-NavHeight) collectionViewLayout:flow];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = NO;
        _collectionView.mj_header = header;
        
        //底部刷新
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
#ifdef kiOS11Before
        
#else
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
#endif
        
        _collectionView.backgroundColor=CViewBgColor;
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
#pragma mark ************** View method **************
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    // 默认进去类型
    return   UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
