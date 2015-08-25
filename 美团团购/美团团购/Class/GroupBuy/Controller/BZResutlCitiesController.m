//
//  BZResutlCitiesController.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZResutlCitiesController.h"
#import "BZCityModel.h"
#import "BZCityRegionModel.h"

@interface BZResutlCitiesController ()
@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NSArray *resultCities;
@end

@implementation BZResutlCitiesController

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [BZCityModel objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText lowercaseString];
    self.resultCities = [self.cities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@",searchText,searchText,searchText]];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    BZCityModel *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    BZCityModel *city = self.resultCities[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:BZChangeCityNotification object:nil userInfo:@{BZSelectCity : city}];
    [self.cityListViewController.navigationController popViewControllerAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%ld个收索结果",self.resultCities.count];
}
     
@end
