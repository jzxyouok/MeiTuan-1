//
//  BZLocationDataTool.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/18.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLocationDataTool.h"
#import "BZCityModel.h"
#import "BZCategoryModel.h"
#import "BZSortModel.h"
#import "BZDeal.h"
static NSArray *_allCities;
static NSArray *_allGateGory;
static NSArray *_allSorts;

@implementation BZLocationDataTool

+ (NSArray *)allCities
{
    if (!_allCities) {
        _allCities = [BZCityModel  objectArrayWithFilename:@"cities.plist"];
    }
    return _allCities;
}

+ (NSArray *)allCateGory
{
    if (!_allGateGory) {
        _allGateGory = [BZCategoryModel objectArrayWithFilename:@"categories.plist"];
    }
    return _allGateGory;
}

+ (NSArray *)allSorts
{
    if (!_allSorts) {
        _allSorts = [BZSortModel objectArrayWithFilename:@"sorts.plist"];
    }
    return _allSorts;
}

+ (BZCategoryModel *)getCategroyFromDeal:(BZDeal *)deal
{
    NSArray *categorys = [self allCateGory];
    for (BZCategoryModel *categroy in categorys) {
        if ([categroy.name isEqualToString:[deal.categories firstObject]])return categroy;
        if ([categroy.subcategories containsObject:[deal.categories firstObject]]) return categroy;
    }
    return nil;
}

@end
