//
//  BZGroupBuyCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/18.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyCell.h"
#import "UIImageView+WebCache.h"
#import "BZDeal.h"
#import "BZGroupBuyCellListPriceLabel.h"

@interface BZGroupBuyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesVolumeLabel;
@property (weak, nonatomic) IBOutlet BZGroupBuyCellListPriceLabel *listPriceLabel;

@end


@implementation BZGroupBuyCell

- (void)awakeFromNib {
    self.iconImageView.image = [UIImage imageNamed:@"icon_defaultimage_listcell_merchant"];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadIconImage)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.iconImageView addGestureRecognizer:tapRecognizer];
}

//点击iconImageView加载图片(省流量模式下才可点击)
- (void)loadIconImage
{
    if ([self equlImageToNormal]) {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dealModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_defaultimage_listcell_merchant"]];
        self.dealModel.currentImage = self.iconImageView.image;
    }
}

/** 当前imageView上的图片是否是占位图片 */
- (BOOL)equlImageToNormal
{
    return [self.iconImageView.image isEqual: [UIImage imageNamed:@"icon_defaultimage_listcell_merchant"]];
}

- (void)setDealModel:(BZDeal *)dealModel
{
    _dealModel = dealModel;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL saveFlowOn = [ud boolForKey:BZUserDefaulSaveFlow];
    // 是否开启省流量模式
    if (saveFlowOn) {
        self.iconImageView.userInteractionEnabled = YES;
        if (self.dealModel.currentImage != nil) {
            self.iconImageView.image = self.dealModel.currentImage;
        }
        else
        {
            self.iconImageView.image = [UIImage imageNamed:@"icon_defaultimage_listcell_merchant"];
            self.dealModel.currentImage = self.iconImageView.image;
        }
    }
    else
    {
        self.iconImageView.userInteractionEnabled = NO;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dealModel.image_url] placeholderImage:[UIImage imageNamed:@"icon_defaultimage_listcell_merchant"]];
            self.dealModel.currentImage = self.iconImageView.image;
    }
    self.businessNameLabel.text = dealModel.title;
    
    self.summaryLabel.text = dealModel.desc;
    
    self.distanceLabel.hidden = YES;
    
    self.priceLabel.text = [dealModel.current_price stringValue];
    
    NSUInteger dotLoc = [self.priceLabel.text rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        
        if (self.priceLabel.text.length - dotLoc > 3) {     // 超过2位小数
            self.priceLabel.text = [self.priceLabel.text substringToIndex:dotLoc + 3];
        }
    }

    
    if (dealModel.list_price == 0) {
        self.listPriceLabel.hidden = YES;
    }
    self.listPriceLabel.text = [dealModel.list_price stringValue];

    self.salesVolumeLabel.text = [NSString stringWithFormat:@"已售%d",dealModel.purchase_count];
}


@end
