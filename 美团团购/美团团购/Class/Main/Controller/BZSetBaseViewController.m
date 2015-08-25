//
//  BZSetBaseViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSetBaseViewController.h"
#import "BZSetBaseCell.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellGroupDataModel.h"

@interface BZSetBaseViewController ()

@end

@implementation BZSetBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self =[super initWithStyle:UITableViewStyleGrouped]) {
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BZSetBaseCellGroupDataModel *groupModel = self.dataArr[section];
    return groupModel.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZSetBaseCellGroupDataModel *groupModel = self.dataArr[indexPath.section];
    BZSetBaseCellDataModel *cellModel = groupModel.cells[indexPath.row];
    BZSetBaseCell *cell = [BZSetBaseCell baseCell:tableView];
    cell.cellData = cellModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    BZSetBaseCellGroupDataModel *groupDataModel = self.dataArr[indexPath.section];
    BZSetBaseCellDataModel *cellDataModel = groupDataModel.cells[indexPath.row];
    if (cellDataModel.optional) {
        cellDataModel.optional();
    }
    if (cellDataModel.pushVC) {
        [self.navigationController pushViewController:[[cellDataModel.pushVC alloc] init]animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BZSetBaseCellGroupDataModel *group = self.dataArr[section];
    return group.header;
}

@end
