//
//  BZCityModel.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZCityModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *pinYin;
@property (copy, nonatomic) NSString *pinYinHead;
@property (strong, nonatomic) NSArray *regions;
@end
