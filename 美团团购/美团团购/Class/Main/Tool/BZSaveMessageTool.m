//
//  BZSaveMessageTool.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSaveMessageTool.h"
#define cityPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.data"]

#define regionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"region.data"]

@implementation BZSaveMessageTool

+ (void)saveLastSelCity:(BZCityModel *)city
{
    [NSKeyedArchiver archiveRootObject:city toFile:cityPath];
}

+ (void)saveLastSelregion:(BZCityRegionModel *)region
{
     [NSKeyedArchiver archiveRootObject:region toFile:regionPath];
}

+ (BZCityModel *)getLastSelCity
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cityPath];
}

+ (BZCityRegionModel *)getLastSelRegion
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:regionPath];
}

@end
