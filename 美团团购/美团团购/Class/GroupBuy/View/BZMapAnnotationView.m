//
//  BZMapAnnotationView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/28.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMapAnnotationView.h"
#import "BZDealAnnotation.h"

@implementation BZMapAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView
{
    static NSString *ID = @"annotationView";
    BZMapAnnotationView *annotationView = (BZMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!annotationView) {
        annotationView = [[BZMapAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        annotationView.canShowCallout = NO;
    }
    return annotationView;
}

- (void)setAnnotation:(BZDealAnnotation *)annotation
{
    [super setAnnotation:annotation];
    self.image = [UIImage imageNamed:annotation.iocn];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
