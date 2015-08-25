//
//  BZBusinessModel.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZBusinessModel.h"

@implementation BZBusinessModel

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"dealsDescription" : @"deals.description", @"dealsUrl" : @"deals.url"};
}
MJCodingImplementation
@end
