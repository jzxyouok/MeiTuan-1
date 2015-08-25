//
//  BZLogoutController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLogoutController.h"
#import "MBProgressHUD+MJ.h"
#import "BZUserTool.h"
#import "BZLoginUserConfigController.h"
#import "UMSocial.h"
#import "BZUserModel.h"

@interface BZLogoutController ()

@end

@implementation BZLogoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
  }

- (void)setUpUI
{
    self.view.backgroundColor = BZBgColor;
    
    BZLoginUserConfigController *userConfigcontroller = [[BZLoginUserConfigController alloc]init];
    [self addChildViewController:userConfigcontroller];
    UITableView *confignView = userConfigcontroller.tableView;
    confignView.showsVerticalScrollIndicator = NO;
    confignView.scrollEnabled = NO;
    confignView.frame =  CGRectMake(0, 0, self.view.width, 44 * 4 + 20 + 64);
    confignView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    confignView.sectionHeaderHeight = 10;
    confignView.sectionFooterHeight = 0;
    [self.view addSubview:confignView];
    
    UIButton *logoutBtn = [[UIButton alloc]init];
    logoutBtn.width = self.view.width - 20;
    logoutBtn.height = 45;
    logoutBtn.x = (self.view.width - logoutBtn.width) / 2;
    logoutBtn.y = CGRectGetMaxY(confignView.frame) + 20;
    logoutBtn.layer.cornerRadius = 3;
    logoutBtn.backgroundColor = [UIColor redColor];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"我的账户" target:self action:@selector(back)];


}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logout
{
    NSLog(@"------------");
    
    BZUserModel *user = [BZUserTool user];
    if ([user.platformName isEqualToString: @"sina"]) {
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            NSLog(@"response is %@",response);
        }];
    }
    [BZUserTool deleteUser];
    [MBProgressHUD showSuccess:@"退出登陆成功！"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
