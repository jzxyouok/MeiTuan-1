//
//  BZGroupBuyDetailTextCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailTextCell.h"

@implementation BZGroupBuyDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.text = @"查看图文详情";
        [self.textLabel setTextColor:BZTabBarBtnTitleColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


@end
