//
//  BZTabBarController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZTabBarController.h"
#import "BZGroupbuyController.h"
#import "BZBusinessController.h"
#import "BZMineController.h"
#import "BZMoreController.h"
#import "BZNavigationController.h"

@interface BZTabBarController ()

@end

@implementation BZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewController];
    self.tabBar.backgroundImage = [UIImage resizeImageWithName:@"bg_tabbar"];
}

- (void)setUpChildViewController
{
    BZGroupbuyController *groupbuyVC = [[BZGroupbuyController alloc]init];
    [self addChildViewController:groupbuyVC andTitle:@"团购" andNorImage:@"icon_tabbar_homepage" andSelImage:@"icon_tabbar_homepage_selected"];
    
    BZBusinessController *businessVC = [[BZBusinessController alloc]init];
    [self addChildViewController:businessVC andTitle:@"商家" andNorImage:@"icon_tabbar_merchant_normal" andSelImage:@"icon_tabbar_merchant_selected"];
    
    
    BZMineController *mineVC = [[BZMineController alloc]init];
    [self addChildViewController:mineVC andTitle:@"我的" andNorImage:@"icon_tabbar_mine" andSelImage:@"icon_tabbar_mine_selected"];
    
    BZMoreController *moreVC = [[BZMoreController alloc]init];
    [self addChildViewController:moreVC andTitle:@"更多" andNorImage:@"icon_tabbar_misc" andSelImage:@"icon_tabbar_misc_selected"];
}

- (void)addChildViewController:(UIViewController *)viewController andTitle:(NSString *)title andNorImage:(NSString *)norImageNam andSelImage:(NSString *)selImageNam
{
    viewController.tabBarItem.title = title;
    NSDictionary *titleAttribute = @{NSForegroundColorAttributeName : BZTabBarBtnTitleColor};
    [viewController.tabBarItem setTitleTextAttributes:titleAttribute forState:UIControlStateSelected];
    UIImage *selImage = [UIImage imageNamed:selImageNam];
    selImage = [UIImage scaleFromImage:selImage];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [viewController.tabBarItem setImage:[UIImage scaleFromImage:[UIImage imageNamed:norImageNam]]];
    [viewController.tabBarItem setSelectedImage:selImage];
    BZNavigationController *nav = [[BZNavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];
}
@end
