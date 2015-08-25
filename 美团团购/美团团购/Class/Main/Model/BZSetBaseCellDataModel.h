//
//  BZSetBaseCellDataModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myBlock)();

@interface BZSetBaseCellDataModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *rightTitle;
@property (copy, nonatomic) myBlock optional;
@property (assign, nonatomic, getter=isInSetting) BOOL inSetting;
@property (unsafe_unretained, nonatomic) Class pushVC;

+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon pushVC:(Class)pushVC;
+ (instancetype)cellWithTitle:(NSString *)title icon:(NSString *)icon;


@end
