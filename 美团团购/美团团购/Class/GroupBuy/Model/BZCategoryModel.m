//
//  BZCategoryModel.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCategoryModel.h"

@implementation BZCategoryModel

- (NSString *)icon
{
    return self.small_icon;
}

- (NSString *)selIcon
{
    return self.small_highlighted_icon;
}

- (NSString *)title
{
    return self.name;
}

- (NSArray *)subDatas
{
    return self.subcategories;
}
MJCodingImplementation

@end
