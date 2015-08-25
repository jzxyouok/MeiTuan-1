//
//  BZChangeCityCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZChangeCityCell.h"
@interface BZChangeCityCell ()


@end


@implementation BZChangeCityCell


+ (instancetype)changeCityCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZChangeCityCell" owner:nil options:nil] lastObject];
}


- (void)addTarget:(id)target action:(SEL)action
{
    [self.changeCityBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
