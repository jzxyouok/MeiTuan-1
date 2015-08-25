//
//  BZGroupBuyDetailCellCommentCell.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZGroupBuyDetailDataModel.h"

@interface BZGroupBuyDetailCommentCell : UITableViewCell

@property (strong, nonatomic) BZGroupBuyDetailDataModel *data;

- (void)showInfo:(BZGroupBuyDetailDataModel *)data;
@end
