//
//  BaseAlertTableView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/12.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAlertTableView : UIView
SINGLETON_FOR_HEADER(BaseAlertTableView)

@property (nonatomic, copy) void (^chooseData)(NSString *message);

/**
 显示AlertTabelView

 @param dataSource 数据源
 */
- (void)showAlertView:(NSArray *)dataSource;
@end
