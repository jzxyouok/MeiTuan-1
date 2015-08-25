//
//  BZEnumView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/25.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZMenuView;

@protocol BZMenuViewData <NSObject>

- (NSString *)title;
- (NSArray *)subDatas;

@optional

- (NSString *)icon;
- (NSString *)selIcon;

@end

@protocol BZMenuViewDataSource <NSObject>

- (NSInteger)numberOfRowInMainView:(BZMenuView *)enumView;

- (id<BZMenuViewData>)menuView:(BZMenuView *)menuView dataForRowInMainView:(int)row;

@end


@protocol BZMenuViewDelegate <NSObject>

- (void)menuView:(BZMenuView *)emnuView clickRowInMainView:(int)mainRow;

- (void)menuView:(BZMenuView *)emnuView clickRowInSubView:(int)subRow andSelMainViewRow:(int)mainRow;

@end

@interface BZMenuView : UIView

+ (instancetype)menuView;

@property (weak,nonatomic) id <BZMenuViewDataSource> dataSource;
@property (weak, nonatomic) id <BZMenuViewDelegate> delegate;

@end
