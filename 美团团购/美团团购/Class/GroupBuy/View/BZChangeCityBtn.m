//
//  BZChangeCityBtn.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZChangeCityBtn.h"

@implementation BZChangeCityBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = 30;
        self.width= 60;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W = contentRect.size.height;
    CGFloat H = W;
    CGFloat X = contentRect.size.width - W;
    CGFloat Y = 0;
    return CGRectMake(X, Y, W, H);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat W = contentRect.size.width - contentRect.size.height;
    CGFloat H = contentRect.size.height;
    CGFloat X = 0;
    CGFloat Y = 0;
    return CGRectMake(X, Y, W, H);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize size = [NSString sizeWithString:title fontSize:15 maxWidth:100 maxHeight:30];
    self.width = size.width + self.imageView.height;
}

@end
