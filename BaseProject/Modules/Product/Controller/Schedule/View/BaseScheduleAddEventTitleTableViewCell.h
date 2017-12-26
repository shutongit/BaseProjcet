//
//  BaseScheduleAddEventTitleTableViewCell.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScheduleAddEventTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) void(^contentText)(NSString *text);
@end
