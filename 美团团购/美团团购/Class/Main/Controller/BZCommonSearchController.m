//
//  BZCommonSearchController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCommonSearchController.h"
#import "BZCommonSearchBar.h"
#import "BZCommonSearchControllerSearchTipView.h"
#import "BZSearchResultBtn.h"
#import "BZSearchDealsResultController.h"

@interface BZCommonSearchController ()<UITextFieldDelegate,BZCommonSearchControllerSearchTipViewDelegate>
@property (strong, nonatomic) UIView *searchTipView;
@property (strong, nonatomic) UITextField *searchTextField;
@property (strong, nonatomic) BZSearchResultBtn *searchBtn;
@property (strong, nonatomic) BZCommonSearchControllerSearchTipView *tipView;
@end

@implementation BZCommonSearchController

- (BZSearchResultBtn *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [[BZSearchResultBtn alloc]init];
        _searchBtn.width = self.view.width;
        _searchBtn.height = 44;
        _searchBtn.y = 64;
        _searchBtn.backgroundColor = [UIColor whiteColor];
        [self.searchTipView addSubview:_searchBtn];
    }
    return _searchBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    [self setUpTitleView];
}
- (void)setUpNavBar
{
    BZCommonSearchBar *commonSearchBar = [[BZCommonSearchBar alloc]init];
    commonSearchBar.bgImageName = @"bg_search_field";
    commonSearchBar.searchTextField.delegate = self;
    self.navigationItem.titleView = commonSearchBar;
    self.searchTextField = commonSearchBar.searchTextField;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextChange:) name:UITextFieldTextDidChangeNotification object:commonSearchBar.searchTextField];
    
    
    UIImage *leftImage = [UIImage scaleFromImage:[UIImage imageNamed:@"btn_backItem"]];
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收索" style:UIBarButtonItemStyleDone target:self action:@selector(beginSearch)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizeImageWithName:@"bg_navigationBar_white@2x"] forBarMetrics:UIBarMetricsDefault];
}

- (void)setUpTitleView
{
    UIView *searchTipView = [[UIView alloc]init];
    searchTipView.frame = self.view.bounds;
    [self.view addSubview:searchTipView];
    self.searchTipView = searchTipView;
    searchTipView.backgroundColor = BZBgColor;
    [self setUpBtnView];
}

- (void)setUpBtnView
{
    BZCommonSearchControllerSearchTipView *tipView = [[BZCommonSearchControllerSearchTipView alloc]init];
    tipView.delegate = self;
    tipView.width = self.searchTipView.width - 20;
    tipView.x = 10;
    tipView.y = 74;
    tipView.height = 120;
    self.tipView = tipView;
    [self.searchTipView addSubview:tipView];
}

- (void)searchTipViewClickBtnWithTitle:(NSString *)btnTitle
{
    self.searchTextField.text = btnTitle;
    [self beginSearch];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)beginSearch
{
    [self.searchTextField resignFirstResponder];
    BZSearchDealsResultController *searDealsResultController = [[BZSearchDealsResultController alloc]init];
    searDealsResultController.keyValue = self.searchTextField.text;
    searDealsResultController.currentCityName = self.currentCityName;
    searDealsResultController.currentCityRegionName =self.currentCityRegionName;
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:searDealsResultController];
    [self.navigationController pushViewController:searDealsResultController animated:YES];
    
}

- (void)searchTextChange:(NSNotification *)noti
{
    if (self.searchTextField.text.length) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.searchBtn.myTitle = self.searchTextField.text;
        self.searchBtn.hidden = NO;
        self.tipView.hidden = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.searchBtn.hidden = YES;
        self.tipView.hidden = NO;
    }
}


@end
