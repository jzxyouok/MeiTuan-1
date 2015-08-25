//
//  BZDealAnnotation.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/27.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZDealAnnotation.h"
#import "BZDealAnnotation.h"

@implementation BZDealAnnotation

- (BOOL)isEqual:(BZDealAnnotation *)object
{
    return ([self.title isEqualToString: object.title] && [self.subtitle isEqualToString: object.subtitle ]);
}

@end
