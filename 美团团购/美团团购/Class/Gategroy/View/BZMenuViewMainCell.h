//
//  BZMenuViewMainCell.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZMenuView.h"

@interface BZMenuViewMainCell : UITableViewCell

@property (weak, nonatomic) id<BZMenuViewData> data;
+ (instancetype)mainCell:(UITableView *)tableView;

@end
