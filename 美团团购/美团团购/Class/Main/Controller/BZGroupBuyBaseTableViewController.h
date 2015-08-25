//
//  BZGroupBuyBaseTableViewController.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZLoadNewDealsParamsModel.h"

@interface BZGroupBuyBaseTableViewController : UITableViewController
- (void)setParams:(NSMutableDictionary *)params;
- (void)loadNewDeals;
@property (strong, nonatomic) NSMutableArray *deals;
@end
