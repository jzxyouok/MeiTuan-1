//
//  BZGroupBuyDetailShareValueEditingViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/1.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailShareValueEditingViewController.h"
#import "UMSocial.h"

@interface BZGroupBuyDetailShareValueEditingViewController ()
@property (strong, nonatomic) UITextField *textField;
@end

@implementation BZGroupBuyDetailShareValueEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc]init];
    textField.width = self.view.width;
    textField.height = 35;
    textField.y = 100;
    textField.backgroundColor = [UIColor greenColor];
    self.textField = textField;
    [self.view addSubview:textField];
    
    
    UIButton *btn = [[UIButton alloc]init];
    btn.width = self.view.width;
    btn.height = 45;
    btn.x = 0;
    btn.y = 200;
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        
   
}

- (void)share
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

@end
