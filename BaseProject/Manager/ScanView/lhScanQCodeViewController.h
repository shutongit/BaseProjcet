//
//  lhScanQCodeViewController.h
//  lhScanQCodeTest
//
//  Created by bosheng on 15/10/20.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "BaseRootViewController.h"

@interface lhScanQCodeViewController : BaseRootViewController

@property(nonatomic,copy)void (^scancodeString)(NSString *str);

@end
