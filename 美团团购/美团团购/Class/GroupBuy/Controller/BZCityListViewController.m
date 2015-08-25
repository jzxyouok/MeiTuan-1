//
//  BZChangeCityViewController.m
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZCityListViewController.h"
#import "BZCityModel.h"
#import "BZCityGroupModel.h"
#import "BZGroupbuyController.h"
#import "BZResutlCitiesController.h"

@interface BZCityListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) NSArray *cityGroups;
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (strong, nonatomic) BZResutlCitiesController *resultCitiesController;
@end

@implementation BZCityListViewController

- (BZResutlCitiesController *)resultCitiesController
{
    if (!_resultCitiesController) {
       BZResutlCitiesController *resultCitiesController = [[BZResutlCitiesController alloc]init];
        [self addChildViewController:resultCitiesController];
        [self.view addSubview:resultCitiesController.view];
        [resultCitiesController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [resultCitiesController.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:10];
        _resultCitiesController = resultCitiesController;

    }
    return _resultCitiesController;
}

- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [BZCityGroupModel objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}


- (IBAction)clickCoverBtn {
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizeImageWithName:@"bg_navigationBar_white@2x"] forBarMetrics:UIBarMetricsDefault];
    self.searchBar.backgroundImage = [UIImage resizeImageWithName:@"bg_search_button_hotword"];
    self.tabelView.sectionIndexColor = [UIColor blackColor];
    self.tabelView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tabelView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
//    self.searchBar.tintColor = BZColor(32, 190, 179);
}
#pragma mark - <UISerachBarDelegate>
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.resultCitiesController.cityListViewController = self;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.resultCitiesController.view.hidden = NO;
        self.resultCitiesController.searchText = searchText;
    }
    else
    {
        self.resultCitiesController.view.hidden = YES;
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BZCityGroupModel *cityModel = self.cityGroups[section];
    return cityModel.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    BZCityGroupModel *cityModel = self.cityGroups[indexPath.section];
    cell.textLabel.text = cityModel.cities[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BZCityGroupModel *cityModel  = self.cityGroups[section];
    return cityModel.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    BZCityGroupModel *cityGroupModel = self.cityGroups[indexPath.section];
    NSArray *citiesData = [BZLocationDataTool allCities];
   BZCityModel *city = [[citiesData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",cityGroupModel.cities[indexPath.row]]] firstObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:BZChangeCityNotification object:nil userInfo:@{BZSelectCity : city}];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
