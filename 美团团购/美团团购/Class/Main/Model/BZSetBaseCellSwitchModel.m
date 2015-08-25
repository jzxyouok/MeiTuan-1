//
//  BZSetBaseCellSwitchModel.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/30.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSetBaseCellSwitchModel.h"

@implementation BZSetBaseCellSwitchModel


+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon key:(NSString *)key
{
    BZSetBaseCellSwitchModel *cellModel = [[self alloc]init];
    cellModel.title = title;
    cellModel.icon = icon;
    cellModel.key = key;
    return cellModel;
}

@end
