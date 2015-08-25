//
//  BZSaveMessageTool.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZCityModel.h"
#import "BZCityRegionModel.h"

@interface BZSaveMessageTool : NSObject

+ (void)saveLastSelCity:(BZCityModel *)city;
+ (void)saveLastSelregion:(BZCityRegionModel *)region;
+ (BZCityModel *)getLastSelCity;
+ (BZCityRegionModel *)getLastSelRegion;

@end
