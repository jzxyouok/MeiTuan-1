//
//  BZMineCell.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSetBaseCell.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellSwitchModel.h"

@interface BZSetBaseCell ()
@property (strong, nonatomic) UISwitch *cellAccessorySwithchView;
@property (strong, nonatomic) UILabel *cellAccessoryRightLabel;
@end


@implementation BZSetBaseCell


+ (instancetype)baseCell:(UITableView *)tableView
{
    static NSString *ID = @"";
    BZSetBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BZSetBaseCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.contentMode = UIViewContentModeLeft;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (UISwitch *)cellAccessorySwithchView
{
    if (!_cellAccessorySwithchView) {
        
        UISwitch *switchView = [[UISwitch alloc]init];
        [switchView addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        _cellAccessorySwithchView = switchView;
    }
    return _cellAccessorySwithchView;
}

- (void)changeValue:(UISwitch *)switchView
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BZSetBaseCellSwitchModel *switchModel = (BZSetBaseCellSwitchModel *)self.cellData;
    [ud setBool:switchView.on forKey:switchModel.key];
    [BZNotificationCenter postNotificationName:BZSetBaseCellSwitchValueDidChangeNotification object:nil userInfo:@{BZSetBaseCellSwitchValueDidChangeKey : switchModel.key}];
}

- (UILabel *)cellAccessoryRightLabel
{
    if (!_cellAccessoryRightLabel) {
        _cellAccessoryRightLabel = [[UILabel alloc]init];
        _cellAccessoryRightLabel.textColor = [UIColor lightGrayColor];
        _cellAccessoryRightLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_cellAccessoryRightLabel];
        }
    return _cellAccessoryRightLabel;
}

- (void)setCellData:(BZSetBaseCellDataModel *)cellData
{
    _cellData = cellData;
    self.textLabel.text = cellData.title;
    self.cellAccessoryRightLabel.text = nil;
    self.imageView.image = [UIImage imageNamed:cellData.icon];
    self.detailTextLabel.text = self.cellData.subTitle;
    //改变字号的大小
    NSInteger textFont = [[NSUserDefaults standardUserDefaults] integerForKey:BZSettingCharacterSize];
    if (textFont != 0) {
        self.textLabel.font = [UIFont systemFontOfSize:textFont];
    }
    
    if (self.cellData.rightTitle.length != 0) {
        NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        CGSize size = [self.cellData.rightTitle sizeWithAttributes:dict];
        self.cellAccessoryRightLabel.size = size;
        self.cellAccessoryRightLabel.x = self.width - size.width - 10;
        if (self.accessoryView == nil) {
            self.cellAccessoryRightLabel.x -= 20;
        }
        self.cellAccessoryRightLabel.y = (self.height - size.height) / 2;
        self.cellAccessoryRightLabel.text = self.cellData.rightTitle;
    }
    
    
    if ([cellData isKindOfClass:[BZSetBaseCellArrorModel class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if ([cellData isKindOfClass:[BZSetBaseCellSwitchModel class]]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        BZSetBaseCellSwitchModel *switchModel = (BZSetBaseCellSwitchModel *)self.cellData;
        self.accessoryView = self.cellAccessorySwithchView;
        UISwitch *switchView = (UISwitch *)self.accessoryView;
        switchView.on = [ud boolForKey:switchModel.key];
    }
    else
    {
        self.accessoryView = nil;
    }
}
@end
