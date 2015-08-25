//
//  BZMoreShareSetViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/31.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreShareSetViewController.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellGroupDataModel.h"
#import "BZUserModel.h"
#import "BZUserTool.h"

@interface BZMoreShareSetViewController ()

@end

@implementation BZMoreShareSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BZSetBaseCellGroupDataModel *group1 = [[BZSetBaseCellGroupDataModel alloc]init];
    group1.header = @"分享设置";
    BZSetBaseCellDataModel *group1_1 = [BZSetBaseCellDataModel cellWithTitle:@"新浪微博" icon:@"UMS_sina_icon"];
    BZUserModel *user = [BZUserTool user];
    if (user) {
       group1_1.rightTitle = user.userName;
    }
    else
    {
        group1_1.rightTitle = @"未绑定";
    }
   
    group1.cells = @[group1_1];
    self.dataArr = @[group1];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"分享设置" target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
