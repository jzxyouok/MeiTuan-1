//
//  BZResutlCitiesController.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZCityListViewController.h"

@interface BZResutlCitiesController : UITableViewController

@property (copy, nonatomic) NSString *searchText;
@property (strong, nonatomic) BZCityListViewController *cityListViewController;

@end
