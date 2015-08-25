//
//  BZMoreController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreController.h"
#import "BZSetBaseCellDataModel.h"
#import "BZSetBaseCellGroupDataModel.h"
#import "BZSetBaseCellArrorModel.h"
#import "BZSetBaseCellSwitchModel.h"
#import "BZMoreSetMessageTipController.h"
#import "BZMoreScanViewController.h"
#import "NSString+File.h"
#import "MBProgressHUD+MJ.h"
#import "BZMoreShareSetViewController.h"
#import "BZMoreDiagnoseNetViewController.h"
#import "BZMoreAboutViewController.h"
#import "BZMoreCharacterViewController.h"
#import "BZFeedBackViewController.h"

@interface BZMoreController ()

@end

@implementation BZMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, -20, 0);
    [self setUpNavBar];
}

- (void)setUpNavBar
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"  更多" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpData];
}

- (void)setUpData
{
    BZSetBaseCellGroupDataModel *group1 = [[BZSetBaseCellGroupDataModel alloc]init];
    group1.header = @"设置";
    BZSetBaseCellDataModel *cell1_1 = [BZSetBaseCellDataModel cellWithTitle:@"消息提醒" icon:nil pushVC:[BZMoreSetMessageTipController class]];
    BZSetBaseCellDataModel *cell1_2 = [BZSetBaseCellSwitchModel cellWithTitle:@"非wifi下使用省流量模式" icon:nil key:BZUserDefaulSaveFlow];
    BZSetBaseCellDataModel *cell1_3 = [BZSetBaseCellDataModel cellWithTitle:@"分享设置" icon:nil pushVC:[BZMoreShareSetViewController class]];
    BZSetBaseCellDataModel *cell1_4 = [BZSetBaseCellDataModel cellWithTitle:@"邀请好友使用美团" icon:nil];
    
    BZSetBaseCellDataModel *cell1_5 = [BZSetBaseCellDataModel cellWithTitle:@"字号大小" icon:nil pushVC:[BZMoreCharacterViewController class]];
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:BZSettingCharacterSize]) {
        case 14:
            cell1_5.rightTitle = @"小字号";
            break;
        case 15:
            cell1_5.rightTitle = @"中字号（默认）";
            break;
        case 16:
            cell1_5.rightTitle = @"大字号";
            break;
        case 17:
            cell1_5.rightTitle = @"特大字号";
            break;
        default:
            cell1_5.rightTitle = @"中字号（默认）";
            break;
    }
    
    BZSetBaseCellDataModel *cell1_6 = [BZSetBaseCellDataModel cellWithTitle:@"清除缓存" icon:nil];
       NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachesPath);
    NSString *imageCachesPath = [cachesPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    long long imageCachesSize = [imageCachesPath fileSize];
    cell1_6.rightTitle = [NSString stringWithFormat:@"%.2fM",(imageCachesSize / (1000.0 * 1000.0))];
    __weak typeof(cell1_6) weakCell1_6 = cell1_6;
    __weak typeof(self) myVC = self;
    cell1_6.optional = ^{
        [MBProgressHUD showSuccess:@"清理成功"];
        NSFileManager *fileManager = [[NSFileManager alloc]init];
        [fileManager removeItemAtPath:imageCachesPath error:nil];
        weakCell1_6.rightTitle = @"0.0M";
        [myVC.tableView reloadData];
    };
    group1.cells = @[cell1_1,cell1_2,cell1_3,cell1_4,cell1_5,cell1_6];
    
    BZSetBaseCellGroupDataModel *group2 = [[BZSetBaseCellGroupDataModel alloc]init];
    group2.header = @"其他";
    BZSetBaseCellDataModel *cell2_1 = [BZSetBaseCellDataModel cellWithTitle:@"扫一扫" icon:nil pushVC:[BZMoreScanViewController class]];
    BZSetBaseCellDataModel *cell2_2 = [BZSetBaseCellDataModel cellWithTitle:@"意见反馈" icon:nil pushVC:[BZFeedBackViewController class]];
    BZSetBaseCellDataModel *cell2_3 = [BZSetBaseCellDataModel cellWithTitle:@"支付帮助" icon:nil];
    BZSetBaseCellDataModel *cell2_4 = [BZSetBaseCellDataModel cellWithTitle:@"检查更新" icon:nil];
    cell2_4.rightTitle = @"当前版本 v5.8.1-b281";
    BZSetBaseCellDataModel *cell2_5 = [BZSetBaseCellDataModel cellWithTitle:@"关于美团" icon:nil pushVC:[BZMoreAboutViewController class]];
    BZSetBaseCellDataModel *cell2_6 = [BZSetBaseCellDataModel cellWithTitle:@"加入我们" icon:nil]; 
    BZSetBaseCellDataModel *cell2_7 = [BZSetBaseCellDataModel cellWithTitle:@"诊断网络" icon:nil pushVC:[BZMoreDiagnoseNetViewController class]];
    group2.cells = @[cell2_1,cell2_2,cell2_3,cell2_4,cell2_5,cell2_6,cell2_7];
    self.dataArr = @[group1,group2];
    for (BZSetBaseCellGroupDataModel *group in self.dataArr) {
        for (BZSetBaseCellDataModel *cellModel in group.cells) {
            cellModel.inSetting = YES;
        }
    }
    [self.tableView reloadData];
}

@end
