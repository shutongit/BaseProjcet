//
//  BaseSearchBarView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/8.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseSearchBarView.h"

@interface BaseSearchBarView ()<UISearchBarDelegate>


@end
@implementation BaseSearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:self.bounds];
        self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.searchBar.backgroundImage = [[UIImage alloc]init];
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchbar_background"] forState:UIControlStateNormal];// 设置搜索框中文本框的背景
        // 设置没有输入时的提示占位符
        [self.searchBar setPlaceholder:@"搜索"];
        //[self.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        // 显示Cancel按钮
        self.searchBar.showsCancelButton = NO;
        
        // 设置代理
        self.searchBar.delegate = self;
        
        [self addSubview:self.searchBar];
    }
    return self;
}


#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES];
}
// UISearchBarDelegate定义的方法，用户单击取消按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO];
    NSLog(@"----searchBarCancelButtonClicked------");
    // 取消搜索状态
    [self.searchBar resignFirstResponder];
}

// UISearchBarDelegate定义的方法，当搜索文本框内文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    NSLog(@"----textDidChange------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:self.searchBar.text];
}

// UISearchBarDelegate定义的方法，用户单击虚拟键盘上Search按键时激发该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 放弃作为第一个响应者，关闭键盘
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO];
    if(self.searchBar.text.length == 0) {
        return;
    }
    if (_searchText) {
        _searchText(self.searchBar.text);
    }
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:self.searchBar.text];
    
    
}

- (void) filterBySubstring:(NSString*) subStr
{
    NSLog(@"----filterBySubstring------");
    // 设置为搜索状态
    //    isSearch = YES;
    // 定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"SELF CONTAINS[c] %@" , subStr];
    // 使用谓词过滤NSArray
    //    searchData = [tableData filteredArrayUsingPredicate:pred];
    // 让表格控件重新加载数据
    //    [tableView reloadData];
}

#pragma mark  ************** setter / getter **************
- (void)setPlaceString:(NSString *)placeString
{
    _placeString = placeString;
    [self.searchBar setPlaceholder:placeString];
}
@end
