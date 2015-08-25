//
//  BZGroupbuyController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupbuyController.h"
#import "BZGroupBuyHeadView.h"
#import "BZGroupBuyCell.h"
#import "BZGroupBuyFooterView.h"
#import "BZCommonSearchBar.h"
#import "BZCommonSearchController.h"
#import "BZChangeCityBtn.h"
#import "BZChangeCityView.h"
#import "BZCityListViewController.h"
#import "BZMapViewController.h"
#import "BZCityModel.h"
#import "BZCityRegionModel.h"
#import "MJRefresh.h"
#import "BZSaveMessageTool.h"
#import "BZCategroyViewController.h"


@interface BZGroupbuyController ()<UITextFieldDelegate,BZMapViewControllerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) BZChangeCityView *changeCityView;
@property (strong, nonatomic) BZCityModel *currentCity;
@property (strong, nonatomic) BZCityListViewController *cityListViewController;
@property (strong, nonatomic) BZCityRegionModel *currentRegion;
@property (strong, nonatomic) BZChangeCityBtn *changeCityBtn;
@end

@implementation BZGroupbuyController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeadView];
    [self setUpFooterView];
    [self setUpNavBar];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadLastSelCityAndRegion];
    [self loadNoti];
    [self locateCurrentCity];
}

- (void)loadNoti
{
    // 跳转到选择城市列表
    [BZNotificationCenter addObserver:self selector:@selector(gotoCityListViewController) name:BZGotoCityListViewNotification object:nil];
    // 更改item显示的城市地区
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLeftTitle:) name:BZChangeCityRigionNotification object:nil];
    
    // 改变城市
    [BZNotificationCenter addObserver:self selector:@selector(changCurrentCity:) name:BZChangeCityNotification object:nil];
    
    // 跳转到分类控制器
    [BZNotificationCenter addObserver:self selector:@selector(gotoCategoryViewController:) name:BZGotoCategroyViewNotification object:nil];
    
    [BZNotificationCenter addObserver:self selector:@selector(changeCityBtnArrow) name:BZChangeCityViewDidClickCoverNotification object:nil];
}

- (void)loadLastSelCityAndRegion
{
    self.currentCity = [BZSaveMessageTool getLastSelCity];
    self.currentRegion = [BZSaveMessageTool getLastSelRegion];
    
    if (self.currentCity == nil) {
        [self locateCurrentCity];
    }
    
    BZChangeCityBtn *changeCityBtn = (BZChangeCityBtn *)self.navigationItem.leftBarButtonItem.customView;
    [changeCityBtn setTitle:[NSString stringWithFormat:@"%@-%@",self.currentCity.name,self.currentRegion.name] forState:UIControlStateNormal];
    
    [self.tableView headerBeginRefreshing];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizeImageWithName:@"bg_navigationBar"] forBarMetrics:UIBarMetricsDefault];
}

#pragma  mark - 初始化控件

- (void)setUpNavBar
{
    
    BZCommonSearchBar *searchBar = [[BZCommonSearchBar alloc]init];
    searchBar.searchTextField.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    
    UIImage *rightItemImage = [UIImage scaleFromImage:[UIImage imageNamed:@"icon_homepage_map_old"]];
    CGRect rect = CGRectMake(15, 8, 30, 20);
    rightItemImage = [rightItemImage getSubImage:rect];
    rightItemImage = [rightItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightItemImage style:UIBarButtonItemStyleDone target:self action:@selector(map)];
    
    BZChangeCityBtn *changeCityBtn = [[BZChangeCityBtn alloc]init];
    self.changeCityBtn = changeCityBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:changeCityBtn];
    [changeCityBtn addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
   
}

- (void)setUpHeadView
{
    BZGroupBuyHeadView *headView = [[BZGroupBuyHeadView alloc]init];
    headView.width = self.view.width;
    self.tableView.tableHeaderView = headView;
}

- (void)setUpFooterView
{
    BZGroupBuyFooterView *footerView = [BZGroupBuyFooterView footerView];
    self.tableView.tableFooterView = footerView;
}

#pragma mark -  接受通知实现方法

- (void)gotoCityListViewController
{
    self.changeCityBtn.imageView.transform = CGAffineTransformIdentity;
    BZCityListViewController *cityListViewController = [[BZCityListViewController alloc]init];
    self.cityListViewController = cityListViewController;
//    [self presentViewController:cityListViewController animated:YES completion:nil];
    [self.navigationController pushViewController:cityListViewController animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    BZCommonSearchController *searchController = [[BZCommonSearchController alloc]init];
    searchController.currentCityName = self.currentCity.name;
    searchController.currentCityRegionName = self.currentRegion.name;
    [self.navigationController pushViewController:searchController animated:YES];
}

- (void)gotoCategoryViewController:(NSNotification *)noti
{
    BZCategroyViewController *categoryViewController = [[BZCategroyViewController alloc]init];
    categoryViewController.cityName = self.currentCity.name;
    categoryViewController.regionName = self.currentRegion.name;
    categoryViewController.catagroy = noti.userInfo[BZSelectCategory];
    [self.navigationController pushViewController:categoryViewController animated:YES];
}

- (void)changeLeftTitle:(NSNotification *)noti
{
    self.changeCityBtn.imageView.transform = CGAffineTransformIdentity;
    BZCityRegionModel *region = noti.userInfo[BZSelectCityRegion];
    if (region != nil) {
        self.currentRegion = region;
    }
    BZChangeCityBtn *changeCityBtn = (BZChangeCityBtn *)self.navigationItem.leftBarButtonItem.customView;
    [changeCityBtn setTitle:[NSString stringWithFormat:@"%@-%@",self.currentCity.name,self.currentRegion.name] forState:UIControlStateNormal];
    [self.changeCityView removeFromSuperview];
    [BZSaveMessageTool saveLastSelregion:region];
    [self.tableView headerBeginRefreshing];
    
}

- (void)changCurrentCity:(NSNotification *)noti
{
    self.currentCity = noti.userInfo[BZSelectCity];
    NSLog(@"%@",self.currentCity.name);
    [BZSaveMessageTool saveLastSelCity:self.currentCity];
    BZChangeCityBtn *btn = (BZChangeCityBtn *)self.navigationItem.leftBarButtonItem.customView;
    [btn setTitle:self.currentCity.name forState:UIControlStateNormal];
    [self.tableView headerBeginRefreshing];
}

- (void)changeCityBtnArrow
{
    self.changeCityBtn.imageView.transform = CGAffineTransformIdentity;
}

#pragma mark - item点击方法

- (void)changeCity:(BZChangeCityBtn *)btn
{
    btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    BZChangeCityView *changeCityView = [[BZChangeCityView alloc]init];
    changeCityView.lastCity = self.currentCity;
    changeCityView.lastRegion = self.currentRegion;
    self.changeCityView = changeCityView;
    [changeCityView startChangeCity];
}

- (void)map
{
    BZMapViewController *mapViewController = [[BZMapViewController alloc]init];
    [self.navigationController pushViewController:mapViewController animated:YES];
    
//    BZBaiduMapViewController *baiduMapViewController = [[BZBaiduMapViewController alloc]init];
//    [self.navigationController pushViewController:baiduMapViewController animated:YES];
}

#pragma mark - 传入城市与分类信息，显示数据

- (void)setParams:(NSMutableDictionary *)params
{
    if (self.currentCity.name) {
        params[@"city"] = self.currentCity.name;
    }
#warning 接口出现问题，region参数值是无效的
    if (self.currentRegion.name) {
        params[@"region"] = self.currentRegion.name;
    }
}

- (void)locateCurrentCity
{
    BZMapViewController *mapVC = [[BZMapViewController alloc]init];
    mapVC.mapDelegate = self;
    [mapVC currentCityName];
}

/**
 定位成功时调用此方法
 */
- (void)mapViewDidFinshLocation:(NSString *)currentCityName
{
    BZCityModel *city = [[[BZLocationDataTool allCities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@",currentCityName]] firstObject];
    self.currentCity = city;
    self.currentRegion = city.regions[0];
    UIAlertView *locationCityTipView = [[UIAlertView alloc]initWithTitle:@"是否切换到定位城市" message:[NSString stringWithFormat:@"定位到您在:%@ ",city.name] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [locationCityTipView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        [self changeLeftTitle:nil];
    }
    [alertView removeFromSuperview];
}


#pragma mark - 设置tableView组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.width = self.view.width;
    imageView.height = 44;
    imageView.image = [UIImage resizeImageWithName:@"bg_tabbar"];
    UILabel *label = [[UILabel alloc]init];
    label.x = 10;
    label.width = imageView.width;
    label.height = imageView.height;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"猜你喜欢";
    [imageView addSubview:label];
    return imageView;
}

- (double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - 重写父类方法 关闭上拉记载控件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 1;
}

@end
