//
//  BZGroupBuyDetailFooterViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/23.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailFooterViewController.h"
#import "BZGroupBuyDetailDataModel.h"
#import "BZDeal.h"
#import "BZBusinessModel.h"
#import "MJRefresh.h"

@interface BZGroupBuyDetailFooterViewController ()

@end

@implementation BZGroupBuyDetailFooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewDeals];
    
    self.tableView.headerHidden = YES;
    self.tableView.footerHidden = YES;
    
    self.tableView.height = 660;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setUpHeaderView];
}


- (void)setParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.data.business.city;
     params[@"limit"] = @5;
}

- (void)setUpHeaderView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.width = self.view.width;
    headerView.height = 60;
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.text = @"  相关推荐";
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.y = 20;
    headerLabel.width = self.view.width;
    headerLabel.height = 39;
    [headerView addSubview:headerLabel];
    
    UIView *marginView = [[UIView alloc]init];
    marginView.backgroundColor = [UIColor clearColor];
    marginView.height  = 15;
    marginView.width = self.view.width;
    [headerView addSubview:marginView];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.tableView reloadData];
//    [self loadNewDeals];
//}

@end
