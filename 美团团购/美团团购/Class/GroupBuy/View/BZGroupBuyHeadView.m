//
//  BZGroupBuyHeadView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyHeadView.h"
#import "BZGroupBuyHeadCategoryView.h"
#import "BZGroupBuyHeadNewView.h"

#define BZGroupBuyViewMargin 10

@interface BZGroupBuyHeadView ()
@property (strong, nonatomic) BZGroupBuyHeadCategoryView *headCategoryView;
@property (strong, nonatomic) BZGroupBuyHeadNewView *headNewView;
@end


@implementation BZGroupBuyHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = 190;
//        self.image = [UIImage resizeImageWithName:@"bg_common"];
        self.userInteractionEnabled = YES;
        BZGroupBuyHeadCategoryView *headCategoryView = [[BZGroupBuyHeadCategoryView alloc]init];
        [self addSubview:headCategoryView];
//        headCategoryView.backgroundColor = [UIColor redColor];
        self.headCategoryView = headCategoryView;
        
        BZGroupBuyHeadNewView *headNewView = [[BZGroupBuyHeadNewView alloc]init];
//        [self addSubview:headNewView];
        headNewView.backgroundColor = [UIColor blueColor];
        self.headNewView = headNewView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headCategoryView.width = self.width;
    self.headCategoryView.height = 180;
    
    self.headNewView.width = self.width;
    self.headNewView.height = 180;
    self.headNewView.y = self.headCategoryView.height + BZGroupBuyViewMargin;
    
}

@end
