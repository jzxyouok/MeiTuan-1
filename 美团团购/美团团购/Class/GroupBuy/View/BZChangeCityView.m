//
//  BZChangeCityView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZChangeCityView.h"
#import "BZChangeCityCell.h"
#import "BZChangeCityRegionSCrollView.h"
#import "BZCityListViewController.h"

@interface BZChangeCityView ()

@property (strong, nonatomic) UIButton *coverBtn;
@property (strong, nonatomic) BZChangeCityCell *changeCityCell;
@property (strong, nonatomic) BZChangeCityRegionSCrollView *regionScrollView;
@end


@implementation BZChangeCityView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        
        
        self.frame = [UIScreen mainScreen].bounds;
        //添加遮盖button
        UIButton *coverBtn = [[UIButton alloc]init];
        self.coverBtn = coverBtn;
        [coverBtn setBackgroundColor:[UIColor blackColor]];
        coverBtn.alpha = 0.5;
        [coverBtn addTarget:self action:@selector(clickCover) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        // 添加bottom导航条
        BZChangeCityCell *changeCityCell = [BZChangeCityCell changeCityCell];
        self.changeCityCell = changeCityCell;
        changeCityCell.backgroundColor = [UIColor whiteColor];
        UIImage *cellIconImage = [UIImage imageNamed:@"icon_dropdown_location_selected"];
        cellIconImage = [UIImage scaleFromImage:cellIconImage];
        cellIconImage = [cellIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [changeCityCell.changeCityBtn setImage:cellIconImage forState:UIControlStateNormal];
        [changeCityCell addTarget:self action:@selector(changeCity)];
        [self addSubview:changeCityCell];
        // 添加城市所含县市的列表视图
        BZChangeCityRegionSCrollView *regionScrollView = [[BZChangeCityRegionSCrollView alloc]init];
        [self addSubview:regionScrollView];
        self.regionScrollView = regionScrollView;
        
    
    }
    return self;
}

- (void)setLastCity:(BZCityModel *)lastCity
{
    _lastCity = lastCity;

    [self.changeCityCell.changeCityBtn setTitle:lastCity.name forState:UIControlStateNormal];
    self.regionScrollView.regions = self.lastCity.regions;
    
}

- (void)setLastRegion:(BZCityRegionModel *)lastRegion
{
    _lastRegion = lastRegion;
    self.regionScrollView.currentRegion = lastRegion;
}

- (void)clickCover
{
    [BZNotificationCenter postNotificationName:BZChangeCityViewDidClickCoverNotification object:nil];
    [self removeFromSuperview];
}

- (void)changeCity
{
    [BZNotificationCenter postNotificationName:BZGotoCityListViewNotification object:nil userInfo:nil];
    [self removeFromSuperview];
    
}

- (void)startChangeCity;
{
    self.coverBtn.frame = [UIScreen mainScreen].bounds;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.regionScrollView.width = self.width - 20;
    self.regionScrollView.height = 200;
    self.regionScrollView.x = 10;
    self.regionScrollView.y = 69;
    
    self.changeCityCell.height = 40;
    self.changeCityCell.width = self.width - 20;
    self.changeCityCell.x = 10;
    self.changeCityCell.y = CGRectGetMaxY(self.regionScrollView.frame);
}

@end
