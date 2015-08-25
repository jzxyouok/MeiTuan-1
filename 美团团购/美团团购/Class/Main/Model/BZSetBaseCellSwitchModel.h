//
//  BZSetBaseCellSwitchModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/30.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSetBaseCellDataModel.h"

@interface BZSetBaseCellSwitchModel : BZSetBaseCellDataModel

@property (copy, nonatomic) NSString *key;

+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon key:(NSString *)key;
@end
