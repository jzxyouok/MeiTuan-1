//
//  BZMoreSetMessageTipController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/30.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreSetMessageTipController.h"
#import "BZMoreTimeTipViewController.h"
#import "BZLocalNotificationTool.h"

@interface BZMoreSetMessageTipController ()

@end

@implementation BZMoreSetMessageTipController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"消息提醒" target:self action:@selector(back)];
    [BZNotificationCenter addObserver:self selector:@selector(switchDidChange:) name:BZSetBaseCellSwitchValueDidChangeNotification object:nil];
    [self setUpDataArr];
}

- (void)switchDidChange:(NSNotification *)noti
{
    NSString *key = noti.userInfo[BZSetBaseCellSwitchValueDidChangeKey];
    if ([key isEqualToString:BZMessageTipOn]) {
        [self setUpDataArr];
        [self.tableView reloadData];

        if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {                        [BZLocalNotificationTool sendLocalNorificationToolSinceNow];
           }
        else
        {
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpDataArr];
    [self.tableView reloadData];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 不要轻易修改key值
 */
- (void)setUpDataArr
{
    BZSetBaseCellGroupDataModel *group1 = [[BZSetBaseCellGroupDataModel alloc]init];
    BZSetBaseCellDataModel *group1_1 = [BZSetBaseCellSwitchModel cellWithTitle:@"每日推荐提醒" icon:nil key:@"每日推荐提醒"];
    BZSetBaseCellDataModel *group1_2 = [BZSetBaseCellDataModel cellWithTitle:@"提醒时间" icon:nil pushVC:[BZMoreTimeTipViewController class]];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:BZMoreSetTimeTipAuto]) {
        group1_2.rightTitle = @"自动";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"aa hh:mm";
        NSDate *date = [NSKeyedUnarchiver unarchiveObjectWithData:[ud dataForKey:BZMoreSetTimeTipDate]];
        NSString *timeStr = [dateFormatter stringFromDate:date];
        group1_2.rightTitle = timeStr;
    }
    BZSetBaseCellDataModel *group1_3 = [BZSetBaseCellSwitchModel cellWithTitle:@"活动相关的通知" icon:nil  key:@"动相关的通知"];
    BOOL timeTipOn = [[NSUserDefaults standardUserDefaults] boolForKey:BZMessageTipOn];
    if (timeTipOn) {
        group1.cells = @[group1_1,group1_2,group1_3];
    }
    else{
        group1.cells = @[group1_1,group1_3];
    }
    self.dataArr = @[group1];
}
@end
