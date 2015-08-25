//
//  BZGroupBuyDetailHeaderView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailHeaderView.h"
#import "UIImageView+WebCache.h"
@interface BZGroupBuyDetailHeaderView ()



@end


@implementation BZGroupBuyDetailHeaderView

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyDetailHeaderView" owner:nil options:nil] lastObject];
}

- (void)setDeal:(BZDeal *)deal
{
    _deal = deal;
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url]];
    self.titleLabel.text = deal.title;
    self.subTitleLabel.text = deal.desc;
}

@end
