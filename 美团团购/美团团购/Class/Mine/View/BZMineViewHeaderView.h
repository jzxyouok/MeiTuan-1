//
//  BZMineViewHeaderView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZMineViewHeaderView;
@protocol BZMineViewHeaderViewDelegate <NSObject>

- (void)headerViewDidClickBtn:(BZMineViewHeaderView *)headerView;
- (void)headerViewDidLoginBtn:(BZMineViewHeaderView *)headerView;

@end

@interface BZMineViewHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)setCollectionCount:(int)collectionCount;

@property (weak, nonatomic) id <BZMineViewHeaderViewDelegate> delegate;

+ (instancetype)headerView;


@end
