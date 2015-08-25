//
//  BZMapViewController.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/20.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BZMapViewControllerDelegate <NSObject>

- (void)mapViewDidFinshLocation:(NSString *)currentCityName;

@end

@interface BZMapViewController : UIViewController

@property (weak, nonatomic)  id <BZMapViewControllerDelegate> mapDelegate;

- (void)currentCityName;

@end
