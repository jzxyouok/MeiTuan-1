//
//  BZGroupBuyBaseTableView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZDealsTableView.h"
#import "BZGroupBuyCell.h"
#import "BZDeal.h"
#import "BZGroupBuyDetailViewController.h"

@interface BZDealsTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UINib *cellNib;
@end


@implementation BZDealsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setDeals:(NSArray *)deals
{
    _deals = deals;
    [self reloadData];
}

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
    if ([self.myDelegate respondsToSelector:@selector(dealsTableView:didSelectCellWithDeal:)]) {
        [self.myDelegate dealsTableView:self didSelectCellWithDeal:deal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


@end
