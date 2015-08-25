//
//  BZCityRegionModel.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCityRegionModel.h"

@interface BZCityRegionModel ()<NSCoding>

@end


@implementation BZCityRegionModel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self encode:aCoder];
}

- (NSString *)title
{
    return self.name;
}

- (NSArray *)subDatas
{
    return self.subregions;
}


@end
