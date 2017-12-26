//
//  BaseMessageView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/14.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMessageView.h"

@interface BaseMessageView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
@implementation BaseMessageView

SINGLETON_FOR_CLASS(BaseMessageView)
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
    }
    return self;
}
- (void)showMessageViewFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self.backImageView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, MIN(44 * dataSource.count, 150));
    
    self.tableView.scrollEnabled = self.frame.size.height >= 150;
    self.dataSource = dataSource.mutableCopy;
    [kAppWindow addSubview:self];
    BSViewsBorder(self.backImageView, 10, 0, [UIColor clearColor]);
    BSViewsBorder(self.tableView, 10, 0, [UIColor clearColor]);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
#pragma mark  ************** tableData **************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark  ************** tableview delegate **************
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chooseMessage) {
        _chooseMessage(self.dataSource[indexPath.row]);
    }
    [self removeFromSuperview];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.backImageView.frame.size.width, self.backImageView.frame.size.height - 10)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        [self.backImageView addSubview:_tableView];
    }
    return _tableView;
}
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
//        _backImageView.backgroundColor = [UIColor lightGrayColor];
        _backImageView.userInteractionEnabled = YES;
        [self addSubview:_backImageView];
    }
    return _backImageView;
}
@end
