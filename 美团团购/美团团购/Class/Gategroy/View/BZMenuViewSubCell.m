//
//  BZMenuViewSubCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMenuViewSubCell.h"

@implementation BZMenuViewSubCell

+ (instancetype)subCell:(UITableView *)tableView
{
    static NSString *ID = @"subCell";
    BZMenuViewSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BZMenuViewSubCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];

    }
    return self;
}
@end
