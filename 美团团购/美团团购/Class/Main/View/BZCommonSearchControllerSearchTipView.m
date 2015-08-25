//
//  BZCommonSearchControllerSearchTipView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCommonSearchControllerSearchTipView.h"

@implementation BZCommonSearchControllerSearchTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       UIButton *btn = [self addBtnWithTitle:@"热门收索"];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        [self addBtnWithTitle:@"自助餐"];
        [self addBtnWithTitle:@"酒店"];
        [self addBtnWithTitle:@"电影"];
        [self addBtnWithTitle:@"火锅"];
        [self addBtnWithTitle:@"烤肉"];
        [self addBtnWithTitle:@"KTV"];
        [self addBtnWithTitle:@"运动健身"];
        [self addBtnWithTitle:@"游泳"];
        [self addBtnWithTitle:@"西餐"];
        [self addBtnWithTitle:@"美容美体"];
        [self addBtnWithTitle:@"日韩料理"];
        

    }
    return self;
}


- (UIButton *)addBtnWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor whiteColor];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickBtn:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(searchTipViewClickBtnWithTitle:)]) {
        [self.delegate searchTipViewClickBtnWithTitle:btn.titleLabel.text];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.width / 4;
    CGFloat btnH = self.height / 3;
    int maxCol = 4;
    for (int i = 0;i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        btn.x = col * btn.width;
        btn.y = row * btn.height;
        btn.width = btnW;
        btn.height = btnH;
    }
}
@end
