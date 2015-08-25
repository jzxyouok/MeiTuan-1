//
//  BZDealAnnotation.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/27.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class BZDeal;
@interface BZDealAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (copy, nonatomic) NSString *iocn;

@property (strong, nonatomic) BZDeal *deal;
@end
