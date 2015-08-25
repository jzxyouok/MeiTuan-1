//
//  BZGroupBuyDetailCellCommentCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailCommentCell.h"
#import "BZDeal.h"
#import "BZBusinessModel.h"

@interface BZGroupBuyDetailCommentCell ()

@end


@implementation BZGroupBuyDetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}


- (void)showInfo:(BZGroupBuyDetailDataModel *)data;
{
    _data = data;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.business.rating_s_img_url] placeholderImage:nil];
    NSMutableString *avgRating = [NSMutableString stringWithFormat:@"%f",data.business.avg_rating];
    NSUInteger dotLoc = [avgRating rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        
        if (avgRating.length - dotLoc > 2) {     // 超过2位小数
           avgRating = (NSMutableString *)[avgRating substringToIndex:dotLoc + 2];
        }
    }
    self.textLabel.text = [NSString stringWithFormat:@"%@分",avgRating];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%d人评价",data.business.review_count];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.font = [UIFont systemFontOfSize:15];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage resizeImageWithName:@"bg_tabbar"]];
}


@end
