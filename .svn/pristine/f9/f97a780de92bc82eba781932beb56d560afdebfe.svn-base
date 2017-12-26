//
//  BaseCustormFlowLayout.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseCustormFlowLayoutDelegate <NSObject>

/**
 改变编辑状态

 @param inEditState inEditState description
 */
- (void)didChangeEditState:(BOOL)inEditState;

/**
 更新数据源

 @param formPath formPath description
 @param toIndexPath toIndexPath description
 */
- (void)moveItemAtIndexPath:(nonnull NSIndexPath *)formPath toIndexPath:(nonnull NSIndexPath *)toIndexPath;

@end



@interface BaseCustormFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL inEditState;
@property (nonatomic, assign, nullable) id <BaseCustormFlowLayoutDelegate>delegate;

@end
