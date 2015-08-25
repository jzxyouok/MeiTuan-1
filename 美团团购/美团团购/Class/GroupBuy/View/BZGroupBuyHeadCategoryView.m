//
//  BZGroupBuyHeadCategoryView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/18.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyHeadCategoryView.h"
#import "BZGroupBuyHeadCategoryScrollView.h"

@interface BZGroupBuyHeadCategoryView ()<UIScrollViewDelegate>
@property (strong, nonatomic) BZGroupBuyHeadCategoryScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@end


@implementation BZGroupBuyHeadCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        BZGroupBuyHeadCategoryScrollView *scrollView = [[BZGroupBuyHeadCategoryScrollView alloc]init];
        [self addSubview:scrollView];
        scrollView.delegate = self;
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        self.pageControl.numberOfPages = 2;
        self.pageControl.pageIndicatorTintColor = BZColor(220, 220, 220);
        self.pageControl.currentPageIndicatorTintColor = BZTabBarBtnTitleColor;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.width = self.width;
    self.scrollView.height = self.height;
    
    self.pageControl.centerX = BZScreenW / 2;
    self.pageControl.centerY = self.height - 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / BZScreenW + 0.5;
}

@end
