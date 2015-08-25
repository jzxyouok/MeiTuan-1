//
//  BZLoginUserConfigController.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/10.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLoginUserConfigController.h"
#import "BZSetBaseCell.h"
#import "BZSetBaseCellGroupDataModel.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellArrorModel.h"
#import "BZUserModel.h"
#import "BZUserTool.h"

@interface BZLoginUserConfigController ()

@end

@implementation BZLoginUserConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
}

- (void)setUpData
{
    BZSetBaseCellGroupDataModel *group1 = [[BZSetBaseCellGroupDataModel alloc]init];
    
    BZUserModel *userModel = [BZUserTool user];
    BZSetBaseCellArrorModel *group1_1 = [BZSetBaseCellArrorModel cellWithTitle:userModel.userName icon:@"" pushVC:nil];
    group1_1.rightTitle = @"修改";
    BZSetBaseCellArrorModel *group1_2 = [BZSetBaseCellArrorModel cellWithTitle:@"收货地址" icon:nil pushVC:nil];
    group1_2.rightTitle = @"修改/添加";
    group1.cells = @[group1_1, group1_2];

    BZSetBaseCellGroupDataModel *group2 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellArrorModel *group2_1 = [BZSetBaseCellArrorModel cellWithTitle:@"未绑定手机号" icon:nil pushVC:nil];
    group2_1.rightTitle = @"去绑定";
    BZSetBaseCellArrorModel *group2_2 = [BZSetBaseCellArrorModel cellWithTitle:@"安保问题" icon:nil pushVC:nil];
    group2_2.rightTitle = @"去设置";
    group2.cells = @[group2_1, group2_2];
    
    self.dataArr = @[group1,group2];
    
}

@end
