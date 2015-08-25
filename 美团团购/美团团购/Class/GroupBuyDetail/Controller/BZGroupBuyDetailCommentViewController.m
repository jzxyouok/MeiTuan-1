//
//  BZGroupBuyDetailCommentViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailCommentViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface BZGroupBuyDetailCommentViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIActivityIndicatorView *active;

@end

@implementation BZGroupBuyDetailCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
    self.title = @"评价详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:@"icon_back" higImageName:@"icon_back_highlighted" target:self active:@selector(back)];
}

- (void)setUpWebView
{
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = self.view.center;
    self.active = active;
    self.active.hidden = NO;
    [self.view addSubview:active];
    [self.active startAnimating];
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.commentUrl]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.active stopAnimating];
    self.active.hidden = YES;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
