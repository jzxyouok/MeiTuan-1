//
//  BZBuyGroupDetailViewModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZDeal.h"
#import "BZBusinessModel.h"

@interface BZGroupBuyDetailDataModel : NSObject

@property (strong, nonatomic) BZDeal *deal;
@property (strong, nonatomic) BZBusinessModel *business;

@property (assign, nonatomic) CGFloat buyCellHeight;
@property (assign, nonatomic) CGFloat commentCellHeight;
@property (assign, nonatomic) CGFloat businessCellHeight;
@property (assign, nonatomic) CGFloat detailTextCellHeight;
@property (assign, nonatomic) CGFloat detailTipCellHeight;
@property (assign, nonatomic) CGFloat commentDetailCellHeight;

@end
