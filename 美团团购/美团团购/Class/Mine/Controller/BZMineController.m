//
//  BZMineController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMineController.h"
#import "BZMineViewHeaderView.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellGroupDataModel.h"
#import "BZSetBaseCell.h"
#import "BZCollectionViewController.h"
#import "BZDealLocalTool.h"
#import "BZLoginViewController.h"
#import "BZUserTool.h"
#import "UIImageView+WebCache.h"
#import "BZUserModel.h"
#import "BZLogoutController.h"

@interface BZMineController ()<BZMineViewHeaderViewDelegate>
@property (strong, nonatomic) BZMineViewHeaderView *headerView;
@end

@implementation BZMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeaderView];
    [self setUpData];
    [self setUpNavBar];
    
    self.view.backgroundColor = BZBgColor;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    
}

- (void)setUpData
{
    BZSetBaseCellGroupDataModel *group1 = [[BZSetBaseCellGroupDataModel alloc]init];
    
    BZSetBaseCellDataModel *group1_1 = [BZSetBaseCellDataModel cellWithTitle:@"团购订单" icon:@"icon_mine_myAccount_username"];
   
    BZSetBaseCellDataModel *group1_2 = [BZSetBaseCellDataModel cellWithTitle:@"预定订单" icon:@"icon_mine_myAccount_username"];
    group1_2.subTitle = @"电影选座、酒店快定、KTV预定";
    BZSetBaseCellDataModel *group1_3 = [BZSetBaseCellDataModel cellWithTitle:@"上门订单" icon:@"icon_mine_myAccount_username"];
    group1.cells = @[group1_1,group1_2,group1_3];
    
    BZSetBaseCellGroupDataModel *group2 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellDataModel *group2_1 = [BZSetBaseCellArrorModel cellWithTitle:@"我的钱包" icon:@"icon_mine_myAccount_username"];
     group2_1.rightTitle = @"账户余额:  0元";
    group2.cells = @[group2_1];


    BZSetBaseCellGroupDataModel *group3 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellDataModel *group3_1 = [BZSetBaseCellArrorModel cellWithTitle:@"我的评价" icon:@"icon_mine_myAccount_username"];
    group3_1.rightTitle = @"查看我的评价足迹";
    group3.cells = @[group3_1];

    BZSetBaseCellGroupDataModel *group4 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellDataModel *group4_1 = [BZSetBaseCellArrorModel cellWithTitle:@"每日推荐" icon:@"icon_mine_myAccount_username"];
    group4.cells = @[group4_1];


    BZSetBaseCellGroupDataModel *group5 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellDataModel *group5_1 = [BZSetBaseCellArrorModel cellWithTitle:@"积分商城" icon:@"icon_mine_myAccount_username"];
    group5_1.rightTitle = @"好礼已上线！";
    BZSetBaseCellDataModel *group5_2 = [BZSetBaseCellDataModel cellWithTitle:@"我的抽奖" icon:@"icon_mine_myAccount_username"];
    BZSetBaseCellDataModel *group5_3 = [BZSetBaseCellDataModel cellWithTitle:@"我的抵用卷" icon:@"icon_mine_myAccount_username"];
    group5.cells = @[group5_1,group5_2,group5_3];

    NSArray *dataArr = @[group1,group2,group3,group4,group5];
    self.dataArr = dataArr;
}

-(void)setUpNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"  我的" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem.enabled = NO;

}

- (void)setUpHeaderView
{
    BZMineViewHeaderView *headerView = [BZMineViewHeaderView headerView];
    self.headerView = headerView;
    headerView.delegate = self;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableHeaderView.height = 175;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BZUserModel *user = [BZUserTool user];
    [self.headerView.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.iconUrl] placeholderImage:[UIImage imageNamed:@"icon_mine_default_portrait"]];
    self.headerView.nameLabel.text = user.userName ? user.userName : @"请点击登陆";
    [self.headerView setCollectionCount:(int)[BZDealLocalTool  collectDeals].count];
}

- (void)headerViewDidClickBtn:(BZMineViewHeaderView *)headerView
{
    BZCollectionViewController *collectionViewController = [[BZCollectionViewController alloc]init];
    BZNavigationController *nav = [[BZNavigationController alloc]initWithRootViewController:collectionViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)headerViewDidLoginBtn:(BZMineViewHeaderView *)headerView
{
    if ([BZUserTool user] == nil) {
    BZLoginViewController *loginViewController = [[BZLoginViewController alloc]init];
    BZNavigationController *nav = [[BZNavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        BZLogoutController *logoutController = [[BZLogoutController alloc]init];
        
        [self.navigationController pushViewController:logoutController animated:YES];
    }

}

@end
