//
//  BZGroupBuyDetailMessageCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/23.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailMessageCell.h"
#import "UIImage+Extension.h"
#import "BZGroupBuyDetailDataModel.h"
#import "BZRestrictions.h"

@interface BZGroupBuyDetailMessageCell ()
@property (weak, nonatomic) IBOutlet UIButton *returnGoodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;

@end


@implementation BZGroupBuyDetailMessageCell

- (void)awakeFromNib {
    
//    UIImageView *bgImageView = [[UIImageView alloc] init];
//    bgImageView.image = [UIImage resizeImageWithName:@"bg_tabbar"];
//    self.backgroundView = bgImageView;
    [self.returnGoodsBtn setImage:[UIImage  scaleFromImage:[UIImage imageNamed:@"icon_order_unrefundable"]] forState:UIControlStateNormal];
    [self.returnGoodsBtn setImage:[UIImage scaleFromImage:[UIImage imageNamed:@"icon_order_refundable"]] forState:UIControlStateSelected];
    [self.purchaseBtn setImage:[UIImage imageNamed:@"icon_deal_soldNumber"] forState:UIControlStateNormal];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyDetailMessageCell" owner:nil options:nil ] lastObject];
    return self;
}

- (void)showInfo:(BZGroupBuyDetailDataModel *)data
{
    if (data.deal.restrictions.is_refundable) {
        self.returnGoodsBtn.selected = YES;
    }
    [self.purchaseBtn setTitle:[NSString stringWithFormat:@"已售出%d",data.deal.purchase_count] forState:UIControlStateNormal];
}
@end
