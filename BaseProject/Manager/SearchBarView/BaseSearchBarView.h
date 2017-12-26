//
//  BaseSearchBarView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/8.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSearchBarView : UIView
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, assign) NSString *placeString;
@property (nonatomic, copy) void (^searchText)(NSString *text);

@end
