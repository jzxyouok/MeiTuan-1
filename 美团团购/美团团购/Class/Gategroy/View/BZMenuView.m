//
//  BZEnumView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMenuView.h"
#import "BZMenuViewMainCell.h"
#import "BZMenuViewSubCell.h"

@interface BZMenuView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainView;
@property (weak, nonatomic) IBOutlet UITableView *subView;
@property (assign, nonatomic) int selRowInMainView;
@end


@implementation BZMenuView

+ (instancetype)menuView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZMenuView" owner:nil options:nil] lastObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainView) {
       return [self.dataSource numberOfRowInMainView:self];
    }
    else
    {
        return [[self.dataSource menuView:self dataForRowInMainView:self.selRowInMainView] subDatas].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainView) {
        BZMenuViewMainCell *mainCell = [BZMenuViewMainCell mainCell:tableView];
        mainCell.data = [self.dataSource menuView:self dataForRowInMainView:(int)indexPath.row];
        return mainCell;
    }
    else
    {
        BZMenuViewSubCell *subCell = [BZMenuViewSubCell subCell:tableView];
        subCell.textLabel.text = [[self.dataSource menuView:self dataForRowInMainView:self.selRowInMainView] subDatas][indexPath.row];
        return subCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainView) {
        self.selRowInMainView = (int)indexPath.row;
        [self.subView reloadData];
        if ([[self.dataSource menuView:self dataForRowInMainView:(int)indexPath.row] subDatas].count == 0) {
            [self.delegate menuView:self clickRowInMainView:(int)indexPath.row];
        }
    }
    else
    {
        [self.delegate menuView:self clickRowInSubView:(int)indexPath.row andSelMainViewRow:self.selRowInMainView];
    }
}
- (IBAction)clickCover:(id)sender {
    self.hidden = YES;
}


@end
