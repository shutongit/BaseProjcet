//
//  BaseCustormFlowLayout.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseCustormFlowLayout.h"

@interface BaseCustormFlowLayout ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longGesture;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;//当前indexPath
@property (nonatomic, assign) CGPoint movePoint; //移动的中心点
@property (nonatomic, strong) UIView *moveView; //移动的视图

@end
@implementation BaseCustormFlowLayout
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureObserver];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       [self configureObserver];
    }
    return self;
}
#pragma mark  ************** 添加观察者 **************
-  (void)configureObserver
{
    [self addObserver:self forKeyPath:@"collectionView" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"collectionView"]) {
        [self setUpGestureRecognizers];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//长按手势
- (void)setUpGestureRecognizers
{
    if (self.collectionView == nil) {
        return;
    }
    _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    _longGesture.minimumPressDuration = 0.3f; //时间长短
    _longGesture.delegate = self;
    [self.collectionView addGestureRecognizer:_longGesture];
}
#pragma mark - 手势动画

- (void)longGesture:(UILongPressGestureRecognizer *)gesture
{
    if (!self.inEditState) {
        [self setInEditState:YES];
    }
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint location = [gesture locationInView:self.collectionView];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
            //如果indexPath为空，不做任何操作
            if (indexPath == nil) return;// || indexPath.section != 0
            self.currentIndexPath = indexPath;
            UICollectionViewCell *targetCell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
            //得到当前cell的映射(截图)
            self.moveView = [targetCell snapshotViewAfterScreenUpdates:YES];
            self.moveView.layer.borderWidth = 0.3;
            self.moveView.layer.borderColor = CFontColor2.CGColor;
            [self.collectionView addSubview:self.moveView];
            targetCell.hidden = YES;
            self.moveView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.moveView.center = location;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [gesture locationInView:self.collectionView];
            //更新cell的位置
            self.moveView.center = point;
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
            if (indexPath == nil)  return;
            if (indexPath.section == self.currentIndexPath.section) {// && indexPath.section == 0
                [self.collectionView moveItemAtIndexPath:self.currentIndexPath toIndexPath:indexPath];
                //使用代理方法更新数据源
                if ([self.delegate respondsToSelector:@selector(moveItemAtIndexPath:toIndexPath:)]) {
                    [self.delegate moveItemAtIndexPath:self.currentIndexPath toIndexPath:indexPath];
                }
                self.currentIndexPath = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                self.moveView.center = cell.center;
            } completion:^(BOOL finished) {
                [self.moveView removeFromSuperview];
                cell.hidden = NO;
                self.moveView = nil;
                self.currentIndexPath = nil;
                [self.collectionView reloadData];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 处于编辑状态

- (void)setInEditState:(BOOL)inEditState
{
    if (_inEditState != inEditState) {
        if (_delegate && [_delegate respondsToSelector:@selector(didChangeEditState:)]) {
            [_delegate didChangeEditState:inEditState];
        }
    }
    _inEditState = inEditState;
}

#pragma mark - 移除观察者

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"collectionView"];
}


@end