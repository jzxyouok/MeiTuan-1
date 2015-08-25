//
//  BZMapViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/20.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMapViewController.h"
#import "BZCommonSearchBar.h"
#import <MapKit/MapKit.h>
#import "BZDealBusinessModel.h"
#import "BZDealAnnotation.h"
#import "DPAPI.h"
#import "BZDeal.h"
#import "BZCategoryModel.h"
#import "BZDealBusinessModel.h"
#import "BZLocationDataTool.h"
#import "BZMapViewAnnotationBtn.h"
#import "BZGroupBuyDetailViewController.h"
#import "BZMenuView.h"
#import "BZCategoryModel.h"
#import "BZSaveMessageTool.h"
#import "BZCityModel.h"

@interface BZMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,DPRequestDelegate,BZMenuViewDataSource,BZMenuViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *biger;
@property (weak, nonatomic) IBOutlet UIButton *small;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy, nonatomic) NSString *currentCity;
@property (copy, nonatomic) NSString *currentCategory;
@property (strong, nonatomic) UIButton *categroyBtn;
@property (assign, nonatomic,getter=isInLoadData) BOOL inLoadData;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) BZMenuView *categroyMenu;
@property (strong, nonatomic) DPRequest *lastRequest;
@property (strong, nonatomic) BZCommonSearchBar *searchBar;
@property (copy, nonatomic) NSString *keyword;


@end

@implementation BZMapViewController

- (BZMenuView *)categroyMenu
{
    if (!_categroyMenu) {
        
        BZMenuView *categroyMenu = [BZMenuView menuView];
        self.categroyMenu = categroyMenu;
        categroyMenu.delegate = self;
        categroyMenu.dataSource = self;
        categroyMenu.width = self.view.width;
        categroyMenu.height = self.view.height;
        categroyMenu.hidden = YES;
        [self.view addSubview:categroyMenu];
    }
    return _categroyMenu;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpMapView];
}

- (void)setUpNavBar
{
    BZCommonSearchBar *searchBar = [[BZCommonSearchBar alloc]init];
    searchBar.searchTextField.returnKeyType = UIReturnKeySearch;
    searchBar.searchTextField.delegate = self;
    searchBar.showWhiteBg = YES;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    UIButton *categoryBtn = [[UIButton alloc]init];
    self.categroyBtn = categoryBtn;
    [categoryBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGSize btnSize = [NSString sizeWithString:@"全部分类" fontSize:14 maxWidth:100 maxHeight:35];
    categoryBtn.size = btnSize;
    [categoryBtn addTarget:self action:@selector(clickCategoryBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:categoryBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"团购" target:self action:@selector(back)];
}

- (void)setUpMapView
{
    self.mapView.mapType = MKMapTypeStandard;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations firstObject];
    
    if (location) {
        [self.locationManager stopUpdatingLocation];
    }
    
    [self showCurrentLocation:location];
    
    CLLocationCoordinate2D center = location.coordinate;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    
    [self.mapView setRegion:MKCoordinateRegionMake(center, span)];
    
    return NSLog(@"-------%f-----------%f",location.coordinate.longitude,location.coordinate.latitude);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self showCurrentLocation:userLocation.location];
}

- (void)showCurrentLocation:(CLLocation *)location
{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil) {
            
            CLPlacemark *placeMark = [placemarks firstObject];
            
            NSLog(@"%@",placeMark.country);
            
            self.locationLabel.text = placeMark.locality;
            
            NSString *city = placeMark.locality;
            
            NSRange range = [placeMark.locality rangeOfString:@"市"];
            
            if (range.location != NSNotFound) {
                
                city = [placeMark.locality substringToIndex:range.location];
            }
            self.currentCity = city;
            // 发请求
            [self mapView:self.mapView regionDidChangeAnimated:YES];
            
        }
    }];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (self.currentCity == nil || self.isInLoadData) return;
    // 发请求
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 城市
    params[@"city"] = self.currentCity;
    // 类别
    if (self.currentCategory) {
        params[@"category"] = self.currentCategory;
    }
    if (self.keyword) {
        params[@"keyword"] = self.keyword;
    }
    // 经纬度
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    params[@"radius"] = @(5000);
    DPRequest *request = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    if (self.lastRequest != request) {
        self.lastRequest = nil;
    }
    self.lastRequest = request;
    self.inLoadData = YES;
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    self.inLoadData = NO;
    NSLog(@"error");
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *deals = [BZDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (BZDeal *deal in deals) {
        for (BZDealBusinessModel *business in deal.businesses) {
            //            NSLog(@"%@",business);
            BZDealAnnotation *annotation = [[BZDealAnnotation alloc]init];
            annotation.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
            annotation.title = business.name;
            annotation.subtitle = deal.title;
            annotation.deal = deal;
            BZCategoryModel *category = [BZLocationDataTool getCategroyFromDeal:deal];
            annotation.iocn = category.map_icon;
            if ([self.mapView.annotations containsObject:annotation]) continue;
            [self.mapView addAnnotation:annotation];
        }
    }
    self.inLoadData = NO;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(BZDealAnnotation *)annotation
{
    if (![annotation isKindOfClass:[BZDealAnnotation class]])return nil;
    
    static NSString *ID = @"annotationView";
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    BZMapViewAnnotationBtn *btn = nil;
    
    if (!annotationView) {
        
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        
        annotationView.canShowCallout = YES;
        
        btn = [BZMapViewAnnotationBtn buttonWithType:UIButtonTypeDetailDisclosure];
        
        [btn addTarget:self action:@selector(clickCallOutRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = btn;
    }
    else
    {
        btn = (BZMapViewAnnotationBtn *)[annotationView rightCalloutAccessoryView];
    }
    annotationView.image = [UIImage imageNamed:annotation.iocn];
    annotationView.annotation = annotation;
    btn.deal = annotation.deal;
    return annotationView;
}

/**
 外部调用获取用户当前城市名
 */
- (void)currentCityName
{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self locationCurrentCity];
    });
}
- (void)locationCurrentCity
{
    NSLog(@"---------");

        if (self.currentCity.length != 0)
        {
            if ([self.mapDelegate respondsToSelector:@selector(mapViewDidFinshLocation:)])
            {
                [self.mapDelegate mapViewDidFinshLocation:self.currentCity];
            }
        }
}

/**
 点击大头针
 */
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

/**
 放大地图
 */
- (IBAction)biger:(id)sender
{
    CLLocationCoordinate2D coordinate = self.mapView.region.center;
    MKCoordinateSpan span = self.mapView.region.span;
    MKCoordinateSpan newSpan = MKCoordinateSpanMake(span.latitudeDelta / 2, span.longitudeDelta / 2);
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(coordinate, newSpan);
    [self.mapView setRegion:newRegion];
}

/**
 缩小地图
 */
- (IBAction)small:(id)sender
{
    CLLocationCoordinate2D coordinate = self.mapView.region.center;
    MKCoordinateSpan span = self.mapView.region.span;
    MKCoordinateSpan newSpan = MKCoordinateSpanMake(span.latitudeDelta * 2, span.longitudeDelta * 2);
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(coordinate, newSpan);
    [self.mapView setRegion:newRegion];
}

- (IBAction)regionGroupBuy:(id)sender
{
    
}

/**
 回到用户的位置
 */
- (IBAction)backUserLocation:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate];
    }];
}

- (void)clickCallOutRightBtn:(BZMapViewAnnotationBtn *)btn
{
    BZGroupBuyDetailViewController *detailViewController = [[BZGroupBuyDetailViewController alloc]init];
    detailViewController.deal = btn.deal;
    BZNavigationController *nav = [[BZNavigationController alloc]initWithRootViewController:detailViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)clickCategoryBtn
{
    self.categroyMenu.hidden = !self.categroyMenu.hidden;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.keyword = textField.text;
    [self mapView:self.mapView regionDidChangeAnimated:YES];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - BZMenuViewDelegate 协议

- (void)menuView:(BZMenuView *)emnuView clickRowInMainView:(int)mainRow
{
    BZCategoryModel *category = [BZLocationDataTool allCateGory][mainRow];
    self.currentCategory = category.name;
    [self.categroyBtn setTitle:category.name forState:UIControlStateNormal];
    self.categroyMenu.hidden = YES;
    [self mapView:self.mapView regionDidChangeAnimated:YES];
}

- (void)menuView:(BZMenuView *)emnuView clickRowInSubView:(int)subRow andSelMainViewRow:(int)mainRow
{
    BZCategoryModel *category = [BZLocationDataTool allCateGory][mainRow];
    [self.categroyBtn setTitle:category.subcategories[subRow] forState:UIControlStateNormal];
    self.currentCategory = category.name;
    self.categroyMenu.hidden = YES;
    [self mapView:self.mapView regionDidChangeAnimated:YES];
}

#pragma mark - BZMenuDataSource 协议

- (NSInteger)numberOfRowInMainView:(BZMenuView *)enumView
{
    NSArray *arr = [BZLocationDataTool allCateGory];
    return arr.count;
}

- (id<BZMenuViewData>)menuView:(BZMenuView *)menuView dataForRowInMainView:(int)row
{
    return [BZLocationDataTool allCateGory][row];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar.searchTextField resignFirstResponder];
}

@end