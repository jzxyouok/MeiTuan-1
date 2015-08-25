//
//  BZTabBar.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZTabBar.h"

@implementation BZTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage resizeImageWithName:@"bg_tabbar"];
    }
    return self;
}


@end
