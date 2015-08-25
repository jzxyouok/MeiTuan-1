//
//  BZGroupBuyBaseTableViewController.m
//  美团团购

//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyBaseTableViewController.h"
#import "DPAPI.h"
#import "BZDeal.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "BZGroupBuyCell.h"
#import "BZGroupBuyDetailViewController.h"
#import "MobClick.h"

@interface BZGroupBuyBaseTableViewController ()<DPRequestDelegate>

@property (strong, nonatomic) UINib *cellNib;
@property (assign, nonatomic) int page;
@end

@implementation BZGroupBuyBaseTableViewController

- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.rowHeight = 120;
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewDeals)];
    [self.tableView setHeaderRefreshingText:@"正在努力加载"];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    [self.tableView setFooterPullToRefreshText:@"正在努力加载"];
}

#pragma mark - 加载团购信息
- (void)loadNewDeals
{
    self.page = 1;
    [self loadDeals];
}

- (void)loadMoreDeals
{
    self.page ++;
    [self loadDeals];
}

- (void)loadDeals
{
    DPAPI *dpi = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"limit"] = @10;
    params[@"page"] = @(self.page);
    [self setParams:params];
    NSString *city = params[@"city"];
    if (!city.length) {
        [self.tableView headerEndRefreshing];
        return;
    }
    [dpi requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    if (self.page > 1) {
        self.page --;
    }
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"success");
//    NSLog(@"%@",result);
    if (self.page == 1) {
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray: (NSMutableArray *)[BZDeal objectArrayWithKeyValuesArray:result[@"deals"]]];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"BZGroupBuyCell";
    if (!self.cellNib) {
        self.cellNib = [UINib nibWithNibName:@"BZGroupBuyCell" bundle:nil];
        [tableView registerNib:self.cellNib forCellReuseIdentifier:str];
    }
    BZGroupBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    cell.dealModel = self.deals[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZGroupBuyCell *cell = (BZGroupBuyCell *)[tableView cellForRowAtIndexPath:indexPath];
    BZDeal *deal = self.deals[indexPath.row];
    NSLog(@"%@",deal);
    NSLog(@"%@",deal.title);
    cell.selected = NO;
    [MobClick event:@"1" attributes:@{@"buyGroup" : @"jion"}];
    BZGroupBuyDetailViewController *detailViewController = [[BZGroupBuyDetailViewController alloc]init];
    detailViewController.deal = deal;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
