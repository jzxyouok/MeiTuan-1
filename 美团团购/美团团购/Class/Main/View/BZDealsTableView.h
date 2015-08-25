//
//  BZGroupBuyBaseTableView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZDealsTableView;

@protocol BZDealsTableViewDelegate <NSObject>

- (void)dealsTableView:(BZDealsTableView *)tableView didSelectCellWithDeal:(BZDeal *)deal;

@end

@interface BZDealsTableView : UITableView
@property (strong, nonatomic) NSArray *deals;
@property (weak, nonatomic) id <BZDealsTableViewDelegate> myDelegate;

@end
