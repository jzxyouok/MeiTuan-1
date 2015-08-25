//
//  BZChangeCityRegionSCrollView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZChangeCityRegionSCrollView.h"
#import "BZCityRegionModel.h"
@interface BZChangeCityRegionSCrollView ()
@property (strong, nonatomic) UIButton *lastBtn;
@end


@implementation BZChangeCityRegionSCrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BZBgColor;
        
    }
    return self;
}


- (void)setRegions:(NSArray *)regions
{
    _regions = regions;
    
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    for (int i = 0; i < regions.count; i ++) {
        BZCityRegionModel *region = regions[i];
        [self addBtnWithTitle:region.name];
    }
    [self setNeedsLayout];
}

- (void)setCurrentRegion:(BZCityRegionModel *)currentRegion
{
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        if ([btn.titleLabel.text isEqualToString:currentRegion.name]) {
            btn.selected = YES;
        }
    }
}

- (void)addBtnWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
}


- (void)layoutSubviews
{
    CGFloat margion = 10;
    CGFloat edgeMargion = 5;
    int maxCol = 3;
    CGFloat btnW = (self.width - margion * 2 - edgeMargion * 2) / maxCol;
    CGFloat btnH = 30;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    [super layoutSubviews];
    for (int i =0 ; i< self.regions.count; i ++) {
        UIButton *btn  = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        
        btnX = edgeMargion + col * (margion + btnW);
        btnY = margion + row * (margion + btnH);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImageWithName:@"bg_dealcell"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImageWithName:@"bg_login_textfield_hl"] forState:UIControlStateSelected];
        [btn setTitleColor:BZTabBarBtnTitleColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(selectRegion:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *lastBtn = [self.subviews lastObject];
    self.contentSize = CGSizeMake(self.width, CGRectGetMaxY(lastBtn.frame) + margion);
}

- (void)selectRegion:(UIButton *)btn
{
    btn.selected = YES;
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    BZCityRegionModel *region = self.regions[btn.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:BZChangeCityRigionNotification object:btn userInfo:@{BZSelectCityRegion : region}];

}
@end
