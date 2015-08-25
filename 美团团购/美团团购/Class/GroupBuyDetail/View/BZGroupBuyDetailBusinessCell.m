//
//  BZGroupBuyDetailBusinessCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailBusinessCell.h"
#import "BZGroupBuyDetailDataModel.h"

@interface BZGroupBuyDetailBusinessCell ()
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessAddressLabel;


@end


@implementation BZGroupBuyDetailBusinessCell

- (void)awakeFromNib {
    
}

- (void)showInfo:(BZGroupBuyDetailDataModel *)data
{
    NSMutableString *name = (NSMutableString *)data.business.name;
    if ([name containsString:@"(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)"])
    {
      NSRange range = [name rangeOfString:@"(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)"];
       self.businessNameLabel.text = [name substringToIndex:range.location];
    }
//    if (dotLoc != NSNotFound)
//    {
//        self.businessNameLabel.text = [name substringToIndex:dotLoc];
//    }
//    else
//    {
//        self.businessNameLabel.text = name;
//    }

    self.businessNameLabel.text = data.business.name;
    self.businessAddressLabel.text = data.business.address;
    self.businessDistanceLabel.text = data.business.telephone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BZGroupBuyDetailBusinessCell" owner:nil options:nil ] lastObject];
    return self;
}




@end
