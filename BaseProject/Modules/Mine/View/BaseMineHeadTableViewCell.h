//
//  BaseHeadTableViewCell.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/7.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMineHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
