//
//  BaseMessageView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/14.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

//消息提示框
@interface BaseMessageView : UIView
SINGLETON_FOR_HEADER(BaseMessageView)

@property (copy, nonatomic) void (^chooseMessage)(NSString *message);
/**
 显示消息提示框

 @param frame 位置
 @param dataSource 数据源
 */
- (void)showMessageViewFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end
