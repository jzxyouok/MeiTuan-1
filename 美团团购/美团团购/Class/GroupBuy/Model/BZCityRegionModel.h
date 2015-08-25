//
//  BZCityRegionModel.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZMenuView.h"
@interface BZCityRegionModel : NSObject<BZMenuViewData>

@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *subregions;

@end
