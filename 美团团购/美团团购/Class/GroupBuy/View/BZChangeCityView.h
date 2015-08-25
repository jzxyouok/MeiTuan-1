//
//  BZChangeCityView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZCityModel.h"
#import "BZCityRegionModel.h"

@interface BZChangeCityView : UIView
@property (copy, nonatomic) BZCityModel  *lastCity;
@property (strong, nonatomic) BZCityRegionModel *lastRegion;
- (void)startChangeCity;
@end
