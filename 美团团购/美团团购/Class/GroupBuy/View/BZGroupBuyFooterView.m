//
//  BZGroupBuyFooterView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/18.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyFooterView.h"

@interface BZGroupBuyFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *moreTitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *footerBtn;

@end


@implementation BZGroupBuyFooterView

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyFooterView" owner:nil options:nil] lastObject];
}
- (IBAction)clickMoreBtn:(id)sender {
    [BZNotificationCenter postNotificationName:BZGotoCategroyViewNotification object:nil userInfo:@{BZSelectCategory : @"美食"}];
}

@end
