//
//  BZBusinessController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZBusinessController.h"
#import "BZBusinessViewLeftItems.h"

@interface BZBusinessController ()

@end

@implementation BZBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    self.navigationItem.title = nil;
}

- (void)setUpNavBar
{
    BZBusinessViewLeftItems *leftItems = [BZBusinessViewLeftItems leftItems];
    leftItems.size = CGSizeMake(150, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItems];
}

@end
