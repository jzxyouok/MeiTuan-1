//
//  BZMapAnnotationView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/28.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface BZMapAnnotationView : MKAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView;
@end
