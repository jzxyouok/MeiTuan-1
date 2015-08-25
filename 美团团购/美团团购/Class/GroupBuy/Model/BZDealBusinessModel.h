//
//  BZDealBusinessModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZDealBusinessModel : NSObject
@property (copy, nonatomic) NSString *city;
@property (assign, nonatomic) int ID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *url;

/** latitude	float	纬度坐标 */
@property (assign, nonatomic) float latitude;

/**longitude	float	经度坐标 */
@property (assign, nonatomic) float longitude;

@end
