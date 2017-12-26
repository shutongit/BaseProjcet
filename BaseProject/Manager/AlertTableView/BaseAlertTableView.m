//
//  BaseAlertTableView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/12.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseAlertTableView.h"
#import "BaseAlertTableViewCell.h"


@interface BaseAlertTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end
@implementation BaseAlertTableView
SINGLETON_FOR_CLASS(BaseAlertTableView)
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)showAlertView:(NSArray *)dataSource
{
    self.dataSource = [dataSource copy];
    CGFloat height = 44 * self.dataSource.count;
    self.tableView.height = MIN(height, KScreenHeight / 2);
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [kAppWindow addSubview:self];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
#pragma mark  ************** tableview data **************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseAlertTableViewCell" forIndexPath:indexPath];
    cell.messageLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark  ************** tableview delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chooseData) {
        _chooseData(self.dataSource[indexPath.row]);
    }
    [self removeFromSuperview];
}
#pragma mark  ************** setter /getter **************
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake((KScreenWidth - 200) / 2, (KScreenHeight - 300) / 2, 200, 300) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        BSViewsBorder(_tableView, 10, 0, [UIColor clearColor]);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"BaseAlertTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseAlertTableViewCell"];
        [self addSubview:_tableView];
    }
    return _tableView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
