//
//  BZCategoryModel.h
//  美团HD-1
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZMenuView.h"

@interface BZCategoryModel : NSObject<BZMenuViewData>

@property (copy, nonatomic) NSString *map_icon;
@property (copy, nonatomic) NSString *highlighted_icon;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *small_highlighted_icon;
@property (copy, nonatomic) NSString *small_icon;
@property (strong, nonatomic) NSArray *subcategories;

@end
