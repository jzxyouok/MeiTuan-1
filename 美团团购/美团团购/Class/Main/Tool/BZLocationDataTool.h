//
//  BZLocationDataTool.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/18.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BZCategoryModel,BZDeal;
@interface BZLocationDataTool : NSObject
+ (NSArray *)allCities;
+ (NSArray *)allCateGory;
+ (NSArray *)allSorts;
+ (BZCategoryModel *)getCategroyFromDeal:(BZDeal *)deal;
@end
