//
//  BZGroupBuyCategoryBtn.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyCategoryBtn.h"

@interface BZGroupBuyCategoryBtn ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end


@implementation BZGroupBuyCategoryBtn

+ (instancetype)categroyBtn;
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyCategoryBtn" owner:nil options:nil] lastObject];
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
}


- (void)addTarget:(id)target action:(SEL)action
{
    [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
