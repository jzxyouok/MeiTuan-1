//
//  UIBarButtonItem+Extension.h
//  包子微博
//
//  Created by 尚承教育 on 15/6/4.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)creatBarButtonItemWithNorImageName:(NSString *)norImageName higImageName:(NSString *)higImageName target:(id)target active:(SEL)action;
+ (UIBarButtonItem *)creatBarButtonItemWithNorImage:(UIImage *)norImage higImage:(UIImage *)higImage target:(id)target active:(SEL)action;

+ (UIBarButtonItem *)backItemWith:(NSString *)title target:(id)target action:(SEL)action;
@end
