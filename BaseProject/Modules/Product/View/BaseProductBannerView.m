//
//  BaseProductBannerView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/6.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseProductBannerView.h"
#import "SDCycleScrollView.h"

@interface BaseProductBannerView ()<SDCycleScrollViewDelegate>

@end
@implementation BaseProductBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self createBanner];
    }
    return self;
}
#pragma mark  ************** touch event **************
- (void)closeAction:(UIButton *)aSender
{
    if (_closeBlock) {
        _closeBlock();
    }
}
#pragma mark  ************** sdcycle delegate **************
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (_clickBanner) {
        _clickBanner(index);
    }
}

#pragma mark  ************** createUI **************
- (void)createUI
{
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn setTitleColor:CFontColor1 forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(3);
        make.right.equalTo(self.mas_right).offset(-3);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
- (void)createBanner
{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    
    NSArray *titles = @[@"新建交流",
                        @"感谢您的支持",
                        @"如果代码在使用过程中出现问题"
                        ];
    
    SDCycleScrollView *cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@""]];
    
    cycleScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollview.titlesGroup = titles;
    cycleScrollview.imageURLStringsGroup = imagesURLStrings;
    cycleScrollview.currentPageDotColor = CFontColor2; // 自定义分页控件小圆标颜色
//    [self addSubview:cycleScrollview];
    [self insertSubview:cycleScrollview atIndex:0];
}


@end
