//
//  JWDeal.m
//  美团HD
//
//  Created by 👄 on 15/7/6.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "BZDeal.h"
#import "BZDealBusinessModel.h"

@implementation BZDeal

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"desc" : @"description"};
}

- (NSDictionary *)objectClassInArray
{
    return @{@"businesses" : [BZDealBusinessModel class]};
}

- (BOOL)isEqual:(BZDeal *)deal
{
    return [self.deal_id isEqualToString: deal.deal_id];
}

MJCodingImplementation
@end
