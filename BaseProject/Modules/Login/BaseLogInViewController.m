//
//  BaseLogInViewController.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseLogInViewController.h"

@interface BaseLogInViewController ()

@end

@implementation BaseLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor blueColor];
    
    NSArray *name = @[@"QQ登陆",@"微信登陆",@"skip>>"];
    for (int i = 0; i < name.count; i ++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 100) / 2, 100 + 70*i, 100, 50)];
        [button setTitle:name[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor lightGrayColor]];
        button.tag = 10+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

- (void)buttonAction:(UIButton *)aSender
{
    switch (aSender.tag) {
        case 10: {
            [self QQLogin];
        }
            break;
        case 11:{
            [self WXLogin];
        }
            break;
        case 12: {
            [self skipAction];
        }
        default:
            break;
    }
}

/**
 微信登录
 */
- (void)WXLogin
{
    [userManager login:UserLoginTypeWeChat completion:^(BOOL success, NSString *des) {
        if (success) {
            DLog(@"登录成功");
        } else {
            DLog(@"登录失败");
        }
    }];
}
//QQ登录
- (void)QQLogin
{
    [userManager login:UserLoginTypeQQ completion:^(BOOL success, NSString *des) {
        if (success) {
            DLog(@"登录成功");
        }else{
            DLog(@"登录失败：%@", des);
        }
    }];
}
//跳过登录
- (void)skipAction
{
   KPostNotification(KNotificationLoginStateChange, @YES);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
