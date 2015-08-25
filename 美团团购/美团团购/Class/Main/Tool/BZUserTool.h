//
//  BZUserTool.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BZUserModel;
@interface BZUserTool : NSObject

+ (void)saveUser:(BZUserModel *)user;
+ (BZUserModel *)user;
+ (void)deleteUser;
@end
