//
//  BZDealLocalTool.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/23.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BZDeal,BZCategoryModel;

@interface BZDealLocalTool : NSObject
+ (NSMutableArray *)recentDeals;
+ (void)saveRecentDeal:(BZDeal *)deal;
+ (void)deleteRecentDeals:(NSArray *)deals;

+ (NSMutableArray *)collectDeals;
+ (void)saveCollectDeal:(BZDeal *)deal;
+ (void)cancelCollectDeal:(BZDeal *)deal;
+ (void)cancelCollectDeals:(NSArray *)deals;

@end
