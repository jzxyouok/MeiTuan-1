//
//  BZMineCell.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZSetBaseCellArrorModel.h"

@class BZSetBaseCellDataModel;
@interface BZSetBaseCell : UITableViewCell

@property (strong, nonatomic) BZSetBaseCellDataModel *cellData;
+ (instancetype)baseCell:(UITableView *)tableView;

@end
