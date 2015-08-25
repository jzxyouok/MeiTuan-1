//
//  BZCommonSearchBar.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCommonSearchBar.h"

@interface BZCommonSearchBar ()
@end


@implementation BZCommonSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.width = 200;
        self.height = 30;
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"background_home_searchBar"];
        
        UIImageView *iconImageView = [[UIImageView alloc]init];
        self.iconImageView = iconImageView;
        iconImageView.image = [UIImage scaleFromImage:[UIImage imageNamed:@"icon_homepage_search"]];
        iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:iconImageView];
        
        UITextField *searchTextField = [[UITextField alloc]init];
        self.searchTextField = searchTextField;
        searchTextField.placeholder = @"输入商家、分类或商圈";
        searchTextField.font = [UIFont systemFontOfSize:14];
        [self addSubview:searchTextField];
    }
    return self;
}


- (void)setBgImageName:(NSString *)bgImageName
{
    self.image = [UIImage resizeImageWithName:bgImageName];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.width = self.height;
    self.iconImageView.height = self.iconImageView.width;
    
    self.searchTextField.width = self.width - self.iconImageView.width - 10;
    self.searchTextField.height = self.height - 10;
    self.searchTextField.centerY = self.height / 2;
    self.searchTextField.x = CGRectGetMaxX(self.iconImageView.frame) + 5;
}

- (void)setShowWhiteBg:(BOOL)showWhiteBg
{
    _showWhiteBg = showWhiteBg;
    if (showWhiteBg) {
    [self setBgImageName:@"bg_search_field"];
    }
}


@end
