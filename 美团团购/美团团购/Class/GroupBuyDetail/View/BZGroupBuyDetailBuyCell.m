//
//  BZGroupBuyDetailBuyCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailBuyCell.h"
#import "BZGroupBuyCellListPriceLabel.h"

@interface BZGroupBuyDetailBuyCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet BZGroupBuyCellListPriceLabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end



@implementation BZGroupBuyDetailBuyCell

- (void)awakeFromNib {
    self.bgImageView.image = [UIImage resizeImageWithName:@"bg_tabbar"];
}

+ (instancetype)buyCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyDetailBuyCell" owner:nil options:nil] lastObject];
}

- (void)setDeal:(BZDeal *)deal
{
    _deal = deal;
    NSMutableString *currentPrice = (NSMutableString *)[deal.current_price stringValue];
    NSUInteger dotLoc = [currentPrice rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        
        if (currentPrice.length - dotLoc > 2) {     // 超过2位小数
            currentPrice = (NSMutableString *)[currentPrice substringToIndex:dotLoc + 2];
        }
    }
    self.priceLabel.text = currentPrice;
    self.listPriceLabel.text = [[deal.list_price stringValue] stringByAppendingString:@"元"];
//    [self.buyBtn setTitle:[NSString stringWithFormat:@"%d元",100] forState:UIControlStateNormal];
}

@end
