//
//  BaseScheduleCalerdarListView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseScheduleCalerdarListView.h"
#import "BaseScheduleCalerdarListTableViewCell.h"

@interface BaseScheduleCalerdarListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addEvent;//添加事件
@end
@implementation BaseScheduleCalerdarListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark  ************** touch event **************
- (void)addEventAction:(UIButton *)aSender
{
    if (_clickAddEvent) {
        _clickAddEvent();
    }
}

#pragma mark  ************** tableView data **************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseScheduleCalerdarListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseScheduleCalerdarListTableViewCell" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"FF4160"];
    } else {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0DF67B"];
    }
    return cell;
}
#pragma mark  ************** tableview delegate **************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark  ************** create UI **************
- (void)createUI
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:lineView];
    
    [self.addEvent addTarget:self action:@selector(addEventAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark  ************** setter /getter **************
- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    self.tableView.scrollEnabled = dataSource.count * 60 > self.frame.size.height;
    [self.tableView reloadData];
}
- (UIButton *)addEvent
{
    if (!_addEvent) {
        _addEvent = [UIButton buttonWithType:UIButtonTypeCustom];
        _addEvent.frame = CGRectMake(self.frame.size.width - 80, (self.frame.size.height - 60)/2, 60, 60);
        [_addEvent setImage:[UIImage imageNamed:@"HomeSign"] forState:UIControlStateNormal];
        [self addSubview:_addEvent];
    }
    return _addEvent;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, self.frame.size.width, self.frame.size.height - 1)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self insertSubview:_tableView atIndex:0];
        [_tableView registerNib:[UINib nibWithNibName:@"BaseScheduleCalerdarListTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseScheduleCalerdarListTableViewCell"];
    }
    return _tableView;
}
@end
