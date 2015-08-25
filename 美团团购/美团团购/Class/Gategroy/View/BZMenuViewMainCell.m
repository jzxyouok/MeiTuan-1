//
//  BZMenuViewMainCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMenuViewMainCell.h"

@implementation BZMenuViewMainCell

+ (instancetype)mainCell:(UITableView *)tableView
{
    static NSString *ID = @"mianCell";
    BZMenuViewMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BZMenuViewMainCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    return self;
}

- (void)setData:(id<BZMenuViewData>)data
{
    _data = data;
    if ([data subDatas].count) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([data respondsToSelector:@selector(icon)]) {
        self.imageView.image = [UIImage imageNamed:[data icon]];
    }
    if ([data respondsToSelector:@selector(selIcon)]) {
        self.imageView.highlightedImage = [UIImage imageNamed:[data selIcon]];
    }
    self.textLabel.text = [data title];
}
@end
