//
//  BZGroupBuyHeadCategoryView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyHeadCategoryScrollView.h"
#import "BZGroupBuyHeadCategoryScrollBackBtnView.h"

@interface BZGroupBuyHeadCategoryScrollView ()
@property (strong, nonatomic) BZGroupBuyHeadCategoryScrollBackBtnView *categoryView;

@end

@implementation BZGroupBuyHeadCategoryScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.pagingEnabled = YES;
        BZGroupBuyHeadCategoryScrollBackBtnView *categoryView = [[BZGroupBuyHeadCategoryScrollBackBtnView alloc]init];
        [self addSubview:categoryView];
        self.categoryView = categoryView;

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentSize = CGSizeMake(self.width * 2, self.height);
    self.categoryView.width = self.width * 2;
    self.categoryView.height = self.height;
}

@end
