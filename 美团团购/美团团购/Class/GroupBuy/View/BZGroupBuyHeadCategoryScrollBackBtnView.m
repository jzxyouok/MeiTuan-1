//
//  BZGroupBuyHeadCategoryView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyHeadCategoryScrollBackBtnView.h"
#import "BZGroupBuyCategoryBtn.h"
#define maxCol 8
#define maxRow 2

@implementation BZGroupBuyHeadCategoryScrollBackBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
     [self addBtnWithImage:@"icon_homepage_foodCategory" andTitle:@"美食"];
      BZGroupBuyCategoryBtn *btn =  [self addBtnWithImage:@"icon_homepage_movieCategory" andTitle:@"电影"];
               [self addBtnWithImage:@"icon_homepage_hotelCategory" andTitle:@"酒店"];
        [self addBtnWithImage:@"icon_homepage_KTVCategory" andTitle:@"KTV"];
        [self addBtnWithImage:@"icon_homepage_beautyCategory" andTitle:@"丽人"];
        [self addBtnWithImage:@"icon_homepage_shoppingCategory" andTitle:@"购物"];
        [self addBtnWithImage:@"icon_homepage_fastfoodCategory" andTitle:@"小吃快餐"];
        [self addBtnWithImage:@"icon_homepage_lifeServiceCategory" andTitle:@"生活服务"];
        [self addBtnWithImage:@"icon_homepage_dailyNewDealCategory" andTitle:@"今日新单"];
        [self addBtnWithImage:@"icon_homepage_aroundjourneyCategory" andTitle:@"周边游"];
        [self addBtnWithImage:@"icon_homepage_CouponCategory" andTitle:@"代金卷"];
        [self addBtnWithImage:@"icon_homepage_entertainmentCategory" andTitle:@"娱乐休闲"];
        [self addBtnWithImage:@"icon_homepage_foottreatCategory" andTitle:@"足疗按摩"];
        [self addBtnWithImage:@"icon_homepage_travellingCategory" andTitle:@"旅游"];
        [self addBtnWithImage:@"icon_homepage_cakeCategory" andTitle:@"蛋糕点心"];
        [self addBtnWithImage:@"icon_homepage_moreCategory" andTitle:@"全部分类"];
        
    }
    return self;
}

- (void)clickBtn:(BZGroupBuyCategoryBtn *)btn
{
    BZGroupBuyCategoryBtn *categoryBtn = (BZGroupBuyCategoryBtn *)btn.superview;
    [BZNotificationCenter postNotificationName:BZGotoCategroyViewNotification object:nil userInfo:@{BZSelectCategory : categoryBtn.titleLabel.text}];
}

- (BZGroupBuyCategoryBtn *)addBtnWithImage:(NSString *)imageNam andTitle:(NSString *)title
{
    BZGroupBuyCategoryBtn *btn = [BZGroupBuyCategoryBtn categroyBtn];
    btn.iconImage = [UIImage  scaleFromImage:[UIImage imageNamed:imageNam]];
    btn.titleLabel.text = title;
    [btn addTarget:self action:@selector(clickBtn:)];
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width / maxCol;
    CGFloat height = (self.height - 20) / maxRow;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < self.subviews.count; i ++) {
        BZGroupBuyCategoryBtn *btn = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        
        x = col * width;
        y = row * height;
        btn.frame = CGRectMake(x, y, width, height);
    }
}

@end
