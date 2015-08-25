//
//  UIBarButtonItem+Extension.m
//  包子微博
//
//  Created by 尚承教育 on 15/6/4.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)creatBarButtonItemWithNorImageName:(NSString *)norImageName higImageName:(NSString *)higImageName target:(id)target active:(SEL)action
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    
    Btn.size = Btn.currentImage.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
}

+ (UIBarButtonItem *)creatBarButtonItemWithNorImage:(UIImage *)norImage higImage:(UIImage *)higImage target:(id)target active:(SEL)action
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setImage:norImage forState:UIControlStateNormal];
    [Btn setImage:higImage forState:UIControlStateHighlighted];
    
    Btn.size = Btn.currentImage.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
}

+ (UIBarButtonItem *)backItemWith:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size = [title sizeWithAttributes:dict];
    backBtn.size = CGSizeMake(size.width + 30, 30);
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    return backItem;
}

@end
