//
//  BaseBaseApplyForCollectionReusableView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/13.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseBaseApplyForReusableModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface BaseBaseApplyForCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) void (^clickApplyFor)(NSInteger index);
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) BaseBaseApplyForReusableModel *model;

@end


