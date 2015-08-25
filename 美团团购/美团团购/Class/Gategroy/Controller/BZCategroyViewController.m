//
//  BZCategroyViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCategroyViewController.h"
#import "BZDealsTableView.h"
#import "BZMenuView.h"
#import "BZSortModel.h"
#import "BZLocationDataTool.h"
#import "BZCategoryModel.h"
#import "BZCityModel.h"
#import "BZCityRegionModel.h"
#import "MJRefresh.h"
#import "DPAPI.h"
#import "DPRequest.h"
#import "BZDeal.h"
#import "BZGroupBuyDetailViewController.h"

#define ToolBarHeight 35
#define SortCellHeight 30

@interface BZCategroyViewController ()<BZMenuViewDataSource,BZMenuViewDelegate,DPRequestDelegate,BZDealsTableViewDelegate>

@property (strong, nonatomic) UIButton *categroyBtn;
@property (strong, nonatomic) UIButton *regionBtn;
@property (strong, nonatomic) UIButton *sortBtn;
@property (strong, nonatomic) UIView *toolBar;

@property (strong, nonatomic) BZMenuView *categroyMenu;
@property (strong, nonatomic) BZMenuView *regionMenu;
@property (strong, nonatomic) UIView *sortMenu;
@property (strong, nonatomic) UIView *lastMenu;

@property (strong, nonatomic) UIButton *lastSelSortBtn;
@property (strong, nonatomic) NSArray *regionArr;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *deals;

@property (strong, nonatomic) BZDealsTableView *dealsTableView;

@end


@implementation BZCategroyViewController

- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}


- (UIView *)lastMenu
{
    if (!_lastMenu) {
        _lastMenu = [BZMenuView menuView];
    }
    return _lastMenu;
}

- (BZMenuView *)categroyMenu
{
    if (!_categroyMenu) {
        
        BZMenuView *categroyMenu = [BZMenuView menuView];
        self.categroyMenu = categroyMenu;
        categroyMenu.delegate = self;
        categroyMenu.dataSource = self;
        categroyMenu.width = self.view.width;
        categroyMenu.y = ToolBarHeight;
        categroyMenu.height = self.view.height - ToolBarHeight;
        categroyMenu.x = 0;
        categroyMenu.hidden = YES;
        [self.view addSubview:categroyMenu];
    }
    return _categroyMenu;
}

- (BZMenuView *)regionMenu
{
    if (!_regionMenu) {
        BZMenuView *regionMenu = [BZMenuView menuView];
        self.regionMenu = regionMenu;
        regionMenu.dataSource = self;
        regionMenu.delegate = self;
        regionMenu.width = self.view.width;
        regionMenu.y = ToolBarHeight;
        regionMenu.height = self.view.height - ToolBarHeight;
        regionMenu.x = 0;
        regionMenu.hidden = YES;
        [self.view addSubview:regionMenu];
    }
    return _regionMenu;
}

- (UIView *)sortMenu
{
    if (!_sortMenu) {
        
        UIView *bgView = [[UIView alloc]init];
        bgView.width = self.view.width;
        bgView.height = self.view.height - ToolBarHeight;
        bgView.y = ToolBarHeight;
        
        NSArray *arr = [BZLocationDataTool allSorts];
        UIView *sortMenu = [[UIView alloc]init];
        sortMenu.backgroundColor = [UIColor redColor];
        sortMenu.width = self.view.width;
        sortMenu.height = arr.count * 30;
        sortMenu.y = 0;
        UIButton *sortCoverBtn = [[UIButton alloc]init];
        sortCoverBtn.width = bgView.width;
        sortCoverBtn.height = bgView.height - CGRectGetMaxY(sortMenu.frame);
        sortCoverBtn.y = CGRectGetMaxY(sortMenu.frame);
        sortCoverBtn.backgroundColor = [UIColor blackColor];
        sortCoverBtn.alpha = 0.5;
        [sortCoverBtn addTarget:self action:@selector(clickSortCoverBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:sortCoverBtn];
        
        CGFloat btnW = sortMenu.width;
        CGFloat btnH = sortMenu.height / arr.count;
        CGFloat btnY = 0;
        CGFloat btnX = 0;
        for (int i = 0; i < arr.count; i ++) {
            UIButton *btn = [[UIButton alloc]init];
            BZSortModel *sort = arr[i];
            btn.tag = i;
            btnY = btnH * i;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [btn setBackgroundImage:[UIImage resizeImageWithName:@"bg_dropdown_leftpart"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizeImageWithName:@"bg_dropdown_left_selected"] forState:UIControlStateSelected];
            [btn setTitle:sort.label forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(self.view.width / 2 + 70), 0, 0);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [sortMenu addSubview:btn];
            [btn addTarget:self action:@selector(sortMenuDidClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        [bgView addSubview:sortMenu];
        [self.view addSubview:bgView];
        _sortMenu = bgView;
    }
    return _sortMenu;
}


- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    BZCityModel *city = [[[BZLocationDataTool allCities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",cityName]] lastObject];
    self.regionArr = city.regions;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpTableView];
    [self setUpToolBar];
    [self.dealsTableView headerBeginRefreshing];
    [self setUpNavBar];
}

- (void)setUpNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:self.catagroy target:self action:@selector(back)];
}

- (void)setUpTableView
{
    BZDealsTableView *dealsTableView = [[BZDealsTableView alloc]init];
    dealsTableView.rowHeight = 120;
    dealsTableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    dealsTableView.frame = self.view.bounds;
    [dealsTableView addHeaderWithTarget:self action:@selector(loadNewDeals)];
    [dealsTableView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    self.dealsTableView = dealsTableView;
    dealsTableView.myDelegate = self;
    [self.view addSubview:dealsTableView];
}

- (void)setUpToolBar
{
    UIView *toolBar = [[UIView alloc]init];
    toolBar.backgroundColor = [UIColor redColor];
    toolBar.frame = CGRectMake(0, 0, self.view.width, ToolBarHeight);
    self.toolBar = toolBar;
 
    
    CGFloat btnW = toolBar.width / 3;
    
    UIButton *categoryBtn = [[UIButton alloc]init];
    [categoryBtn setTitle:self.catagroy forState:UIControlStateNormal];
    self.categroyBtn = categoryBtn;
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    categoryBtn.frame = CGRectMake(0, 0, btnW, toolBar.height);
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [categoryBtn setBackgroundImage:[UIImage resizeImageWithName:@"btn_buttonItem_background"] forState:UIControlStateNormal];
    [categoryBtn addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:categoryBtn];
    
    UIButton *regionBtn = [[UIButton alloc]init];
    self.regionBtn = regionBtn;
    regionBtn.frame = CGRectMake(btnW, 0, btnW, toolBar.height);
    [regionBtn setBackgroundImage:[UIImage resizeImageWithName:@"btn_buttonItem_background"] forState:UIControlStateNormal];
    [regionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [regionBtn setTitle:[NSString stringWithFormat:@"%@",self.regionName] forState:UIControlStateNormal];
    regionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [regionBtn addTarget:self action:@selector(clickRegionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:regionBtn];
    
    UIButton *sortBtn = [[UIButton alloc]init];
    self.sortBtn = sortBtn;
    sortBtn.frame = CGRectMake(btnW * 2, 0, btnW, toolBar.height);
    [sortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sortBtn setBackgroundImage:[UIImage resizeImageWithName:@"btn_buttonItem_background"] forState:UIControlStateNormal];
    [sortBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    sortBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sortBtn addTarget:self action:@selector(clickSortBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:sortBtn];
    
    [self.view addSubview:toolBar];
}

#pragma mark - 网络加载数据
#pragma mark - 加载团购信息
- (void)loadNewDeals
{
    self.page = 1;
    [self loadDeals];
}

- (void)loadMoreDeals
{
    self.page ++;
    [self loadDeals];
}

- (void)loadDeals
{
    DPAPI *dpi = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.cityName;
    params[@"limit"] = @10;
    params[@"page"] = @(self.page);
    
    if (self.catagroy && !([self.catagroy isEqualToString:@"全部分类"] || [self.catagroy isEqualToString:@"全部"])) {
        params[@"category"] = self.catagroy;
    }

    if (self.regionName && !([self.regionName isEqualToString:@"全部"])) {
        
        params[@"region"] = self.regionName;
    }
    
    if (self.lastSelSortBtn) {
        params[@"sort"] = @(self.lastSelSortBtn.tag + 1);
    }
    
    NSString *city = params[@"city"];
    
    if (!city.length) {
        [self.dealsTableView headerEndRefreshing];
        return;
    }
    [dpi requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    if (self.page > 1) {
        self.page --;
    }
    [self.dealsTableView headerEndRefreshing];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"success");
    //    NSLog(@"%@",result);
    if (self.page == 1) {
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray: (NSMutableArray *)[BZDeal objectArrayWithKeyValuesArray:result[@"deals"]]];
    self.dealsTableView.deals = self.deals;
    [self.dealsTableView reloadData];
    [self.dealsTableView headerEndRefreshing];
}



#pragma mark - 控件实现方法
- (void)clickSortCoverBtn:(UIButton *)coverBtn
{
    self.sortMenu.hidden = YES;
}

- (void)clickCategoryBtn:(UIButton *)btn
{
    if (self.lastMenu == self.categroyMenu) {
        self.categroyMenu.hidden = !self.lastMenu.hidden;
    }
    else
    {
        self.lastMenu.hidden = YES;
        self.categroyMenu.hidden = NO;
    }
    self.lastMenu = self.categroyMenu;
}
- (void)clickRegionBtn:(UIButton *)btn
{
    if (self.lastMenu == self.regionMenu) {
        self.regionMenu.hidden = !self.lastMenu.hidden;
    }
    else
    {
        self.lastMenu.hidden = YES;
        self.regionMenu.hidden = NO;
    }
    self.lastMenu = self.regionMenu;
}
- (void)clickSortBtn:(UIButton *)btn
{
    if (self.lastMenu == self.sortMenu) {
        self.sortMenu.hidden = !self.lastMenu.hidden;
    }
    else
    {
        self.lastMenu.hidden = YES;
        self.sortMenu.hidden = NO;
    }
    self.lastMenu = self.sortMenu;
}

- (void)sortMenuDidClickBtn:(UIButton *)btn
{
    self.lastSelSortBtn.selected = NO;
    btn.selected = YES;
    self.lastSelSortBtn = btn;
    self.sortMenu.hidden = YES;
    BZSortModel *sort = [BZLocationDataTool allSorts][btn.tag];
    [self.sortBtn setTitle:sort.label forState:UIControlStateNormal];
    [self.dealsTableView headerBeginRefreshing];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - BZMenuViewDelegate 协议

- (void)menuView:(BZMenuView *)emnuView clickRowInMainView:(int)mainRow
{
    if (emnuView == self.categroyMenu) {
        BZCategoryModel *category = [BZLocationDataTool allCateGory][mainRow];
        self.catagroy = category.name;
        [self.categroyBtn setTitle:category.name forState:UIControlStateNormal];
        self.categroyMenu.hidden = YES;
    }
    else
    {
        BZCityRegionModel *region = self.regionArr[mainRow];
        [self.regionBtn setTitle:region.name forState:UIControlStateNormal];
        self.regionName = region.name;
        self.regionMenu.hidden = YES;
    }
    [self.dealsTableView headerBeginRefreshing];
}

- (void)menuView:(BZMenuView *)emnuView clickRowInSubView:(int)subRow andSelMainViewRow:(int)mainRow
{
    if (emnuView == self.categroyMenu) {
        BZCategoryModel *category = [BZLocationDataTool allCateGory][mainRow];
        [self.categroyBtn setTitle:category.subcategories[subRow] forState:UIControlStateNormal];
        self.catagroy = category.name;
        self.categroyMenu.hidden = YES;
    }
    else
    {
        BZCityRegionModel *region = self.regionArr[mainRow];
        [self.regionBtn setTitle:region.subregions[subRow] forState:UIControlStateNormal];
        self.regionName = region.name;
        self.regionMenu.hidden = YES;
        
    }
    [self.dealsTableView headerBeginRefreshing];
}

#pragma mark - BZMenuDataSource 协议

- (NSInteger)numberOfRowInMainView:(BZMenuView *)enumView
{
    if (enumView == self.categroyMenu) {
        NSArray *arr = [BZLocationDataTool allCateGory];
        return arr.count;
    }
    else
    {
        return self.regionArr.count;
    }
}

- (id<BZMenuViewData>)menuView:(BZMenuView *)menuView dataForRowInMainView:(int)row
{
    if (menuView == self.categroyMenu) {
        return [BZLocationDataTool allCateGory][row];
    }
    else
    {
        return self.regionArr[row];
    }
}

#pragma mark - BZDealsTableViewDelegate 协议

- (void)dealsTableView:(BZDealsTableView *)tableView didSelectCellWithDeal:(BZDeal *)deal
{
    BZGroupBuyDetailViewController *deatilViewController = [[BZGroupBuyDetailViewController alloc]init];
    deatilViewController.deal = deal;
    [self.navigationController pushViewController:deatilViewController animated:YES];
}


@end
