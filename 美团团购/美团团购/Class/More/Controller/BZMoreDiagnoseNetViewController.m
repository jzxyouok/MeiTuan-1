//
//  BZMoreDiagnoseNetViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/31.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreDiagnoseNetViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "BZMoreDiagnoseNetLoadingView.h"

@interface BZMoreDiagnoseNetViewController ()<BZMoreDiagnoseNetLoadingViewDelegate>
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *diagnoseBtn;
@end

@implementation BZMoreDiagnoseNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BZBgColor;
    [self setUpDiagnoseBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"诊断网络" target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpDiagnoseBtn
{
    UIButton *diagnoseBtn = [[UIButton alloc]init];
    CGFloat Margin = 10;
    diagnoseBtn.width = self.view.width - Margin * 2;
    diagnoseBtn.height = 40;
    diagnoseBtn.x = Margin;
    diagnoseBtn.y = 100;
    [diagnoseBtn setTitle:@"诊断网络" forState:UIControlStateNormal];
    [diagnoseBtn setTitle:@"正在诊断" forState:UIControlStateDisabled];
    diagnoseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    diagnoseBtn.backgroundColor = BZTabBarBtnTitleColor;
    
    
    
    [diagnoseBtn addTarget:self action:@selector(diagnoseNet) forControlEvents:UIControlEventTouchUpInside];
    [diagnoseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.diagnoseBtn = diagnoseBtn;
    [self.view addSubview:diagnoseBtn];

    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.width = diagnoseBtn.width;
    tipLabel.height = 60;
    tipLabel.x = Margin;
    tipLabel.y = CGRectGetMaxY(diagnoseBtn.frame) + Margin;
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.text = @"当你的手机网络处于可用状态而美团应用无法连接网络时，你可以尝试诊断网络！";
    tipLabel.numberOfLines = 0;
    self.tipLabel = tipLabel;
    [self.view addSubview:tipLabel];
}

- (void)diagnoseNet
{
    [self setUpLoadingView];
}

- (void)loadingViewDidStopLoading:(BZMoreDiagnoseNetLoadingView *)loadingView
{
    self.diagnoseBtn.enabled = YES;
    self.diagnoseBtn.backgroundColor = BZTabBarBtnTitleColor;
    // 监听网络
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:     // 未知网络
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [MBProgressHUD showSuccess:@"网络正常，当前网络是WIFI"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [MBProgressHUD showSuccess:@"网络正常，当前网络是移动网络"];
                break;

            default:
                break;
        }
    }];
    [manager startMonitoring];

}

- (void)setUpLoadingView
{
    BZMoreDiagnoseNetLoadingView *loadingView = [BZMoreDiagnoseNetLoadingView loadingView];
    loadingView.delegate = self;
    loadingView.width = self.view.width;
    loadingView.height = 100;
    loadingView.y = CGRectGetMaxY(self.tipLabel.frame);
    [self.view addSubview:loadingView];
    [loadingView beginLoading];
    self.diagnoseBtn.enabled = NO;
    self.diagnoseBtn.backgroundColor = [UIColor grayColor];
}

@end
