//
//  BZCityModel.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCityModel.h"
#import "BZCityRegionModel.h"
#import "MJExtension.h"

@interface BZCityModel ()<NSCoding>

@end


@implementation BZCityModel
- (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [BZCityRegionModel class]};
}

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

@end
