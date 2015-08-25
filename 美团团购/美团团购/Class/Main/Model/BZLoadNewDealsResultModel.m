//
//  BZLoadNewDealsResultModel.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLoadNewDealsResultModel.h"
#import "MJExtension.h"
#import "BZDeal.h"

@implementation BZLoadNewDealsResultModel
- (NSDictionary *)objectClassInArray
{
    return @{@"deals" : [BZDeal class]};
}
@end
