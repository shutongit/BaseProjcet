//
//  BaseRootViewController.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
//#import "UIViewController+AlertViewAndActionSheet.h"

/**
 基类
 */
@interface BaseRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否是返回按钮 默认为YES
 */
@property (nonatomic, assign) BOOL isBackButton;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 是否隐藏导航栏下面的一条线，默认YES
 */
@property (nonatomic, assign) BOOL isHideBarbackground;
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;


/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 跳转登录
 */
- (void)goLogin;
- (void)goLoginWithPush;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  需要登录
 */
- (void)showShouldLoginPoint;

/**
 *  加载动画
 */
- (void)showLoadingAnimation;

/**
 *  停止加载动画
 */
- (void)stopLoadingAnimation;

/**
 刷新数据
 */
-(void)headerRereshing;

/**
 加载更多数据
 */
-(void)footerRereshing;

/**
 文字按钮点击事件

 @param aSender aSender description
 */
- (void)titleButtonAction:(UIButton *)aSender;

/**
 图片按钮点击事件

 @param aSender aSender description
 */
- (void)imageButtonAction:(UIButton *)aSender;


/**
 导航栏添加文本按钮
 
 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target tags:(NSArray *)tags;

/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target tags:(NSArray *)tags;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

//取消网络请求
- (void)cancelRequest;

/**
 提示框

 @param message message description
 @param cancelTitle cancelTitle description
 @param confirmTitle confirmTitle description
 @param cancelBlock cancelBlock description
 @param confirmBlock confirmBlock description
 */
- (void)alertWithMessage:(NSString *)message
             cancelTitle:(NSString *)cancelTitle
            confirmTitle:(NSString *)confirmTitle
             cancelBlock:(void (^)())cancelBlock
            confirmBlock:(void (^)())confirmBlock;

@end
