//
//  BZGroupBuyDetailHeaderView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZGroupBuyDetailDataModel.h"
#import "BZDeal.h"

@interface BZGroupBuyDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (strong, nonatomic) BZDeal *deal;
+ (instancetype)headerView;

@end
