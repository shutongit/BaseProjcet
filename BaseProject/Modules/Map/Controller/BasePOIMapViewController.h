//
//  BasePOIMapViewController.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/13.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseRootViewController.h"

@interface BasePOIMapViewController : BaseRootViewController

@property (nonatomic, copy) void (^chooseAddress)(NSString *address);
@end
