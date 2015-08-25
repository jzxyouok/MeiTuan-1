//
//  BZCollectionViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/28.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCollectionViewController.h"
#import "BZDealLocalTool.h"

@interface BZCollectionViewController ()

@end

@implementation BZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpNavBarItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.deals = [BZDealLocalTool collectDeals];
    [self.tableView reloadData];
    self.title = [NSString stringWithFormat:@"收藏（%ld）",self.deals.count];
}


- (void)setUpNavBarItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"我的" target:self action:@selector(back)];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZDeal *deal = self.deals[indexPath.row];
    [self.deals removeObject:deal];
    [BZDealLocalTool cancelCollectDeal:deal];
    [self.tableView reloadData];
    self.title = [NSString stringWithFormat:@"收藏（%ld）",self.deals.count];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
