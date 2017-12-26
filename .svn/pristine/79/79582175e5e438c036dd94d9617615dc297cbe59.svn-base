//
//  BaseTabBarViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseHomeViewController.h"
#import "BaseProductViewController.h"
#import "BaseMessageViewController.h"
#import "BaseMineViewController.h"
#import "BaseLogInViewController.h"
#import "BaseNavgationViewController.h"
#import "BaseMapViewController.h"

@interface BaseTabBarViewController ()<TabBarDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation BaseTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setUpTabBar];
    
    //添加子控制器
    [self setUpAllChildViewController];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self removeOriginControls];
}

#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    [self.tabBar addSubview:({
        
        BaseTabbar *tabBar = [[BaseTabbar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        tabBar.custormClik = ^{//自定义按钮
            DLog(@"我来签到了");
        };
        self.TabBar = tabBar;
    })];
    
}
#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
    
    BaseHomeViewController *homeVC = [[BaseHomeViewController alloc]init];
    [self setupChildViewController:homeVC title:@"消息" imageName:@"icon_tabbar_homepage" seleceImageName:@"icon_tabbar_homepage_selected"];
    
    BaseMessageViewController *msgVC = [[BaseMessageViewController alloc]init];
    [self setupChildViewController:msgVC title:@"联系人" imageName:@"icon_tabbar_merchant_normal" seleceImageName:@"icon_tabbar_merchant_selected"];
    
//    BaseMapViewController *mapVC = [[BaseMapViewController alloc]init];
    [self setupChildViewController:[UIViewController new] title:@"签到" imageName:@"HomeSign" seleceImageName:@"HomeSign"];
    
    BaseProductViewController *makeFriendVC = [[BaseProductViewController alloc]init];
    [self setupChildViewController:makeFriendVC title:@"应用" imageName:@"icon_tabbar_onsite" seleceImageName:@"icon_tabbar_onsite_selected"];
        
    BaseMineViewController *mineVC = [[BaseMineViewController alloc]init];
    [self setupChildViewController:mineVC title:@"我" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_selected"];
    
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    //包装导航控制器
    BaseNavgationViewController *nav = [[BaseNavgationViewController alloc]initWithRootViewController:controller];
    controller.title = title;
    [_VCS addObject:nav];
}

#pragma mark ————— 统一设置tabBarItem属性并添加到TabBar —————
- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.TabBar.badgeTitleFont         = SYSTEMFONT(11.0f);
    self.TabBar.itemTitleFont          = SYSTEMFONT(10.0f);
    self.TabBar.itemImageRatio         = self.itemImageRatio == 0 ? 0.7 : self.itemImageRatio;
    self.TabBar.itemTitleColor         = [UIColor blackColor];
    self.TabBar.selectedItemTitleColor = CNavBgColor2;
    
    self.TabBar.tabBarItemCount = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:VC];
        
        [self.TabBar addTabBarItem:VC.tabBarItem];
    }];
}

#pragma mark ————— 选中某个tab —————
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    self.TabBar.selectedItem.selected = NO;
    self.TabBar.selectedItem = self.TabBar.tabBarItems[selectedIndex];
    self.TabBar.selectedItem.selected = YES;
}

#pragma mark ————— 取出系统自带的tabbar并把里面的按钮删除掉 —————
- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}


#pragma mark - TabBarDelegate Method

- (void)tabBar:(BaseTabbar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
    
    if (to == 2) {        
        self.hidesBottomBarWhenPushed = YES;
        [self presentViewController:[[BaseMapViewController alloc]init] animated:YES completion:nil];
        return;
    }
    self.selectedIndex = to;
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
