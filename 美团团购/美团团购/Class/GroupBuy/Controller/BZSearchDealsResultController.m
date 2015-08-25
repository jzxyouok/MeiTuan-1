//
//  BZSearchDealsResultController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSearchDealsResultController.h"
#import "MJRefresh.h"
#import "BZCommonSearchBar.h"

@interface BZSearchDealsResultController ()<UITextFieldDelegate>

@end

@implementation BZSearchDealsResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--------");
        [self.tableView headerBeginRefreshing];
    });
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"收索" target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpSearchBar
{
    BZCommonSearchBar *searchBar = [[BZCommonSearchBar alloc]init];
    searchBar.searchTextField.delegate = self;
    searchBar.searchTextField.text = self.keyValue;
    self.navigationItem.titleView = searchBar;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setParams:(NSMutableDictionary *)params
{
    if (self.currentCityName.length) {
         params[@"city"] = self.currentCityName;
    }

    if (self.currentCityRegionName.length) {
         params[@"region"] = self.currentCityRegionName;
    }
    
    if (self.keyValue.length) {
          params[@"keyword"] = self.keyValue;
    }
}

@end
