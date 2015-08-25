//
//  BZSetBaseCellDataModel.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSetBaseCellDataModel.h"

@implementation BZSetBaseCellDataModel

+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon
{
    BZSetBaseCellDataModel *cellModel = [[self alloc]init];
    cellModel.title = title;
    cellModel.icon = icon;
    return cellModel;
}


+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon pushVC:(Class)pushVC
{
    BZSetBaseCellDataModel *cellModel = [[self alloc]init];
    cellModel.title = title;
    cellModel.icon = icon;
    cellModel.pushVC = pushVC;
    return cellModel;
}


@end
