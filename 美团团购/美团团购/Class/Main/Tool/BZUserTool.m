//
//  BZUserTool.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZUserTool.h"
#define UserPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]

@implementation BZUserTool

static NSMutableArray *_users;


+ (void)saveUser:(BZUserModel *)user
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    [_users addObject:user];
    [NSKeyedArchiver archiveRootObject:_users toFile:UserPath];
}

+ (BZUserModel *)user
{
    _users = [NSKeyedUnarchiver unarchiveObjectWithFile:UserPath];
    return [_users firstObject];
}

+ (void)deleteUser
{
    _users = [NSKeyedUnarchiver unarchiveObjectWithFile:UserPath];
    [_users removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_users toFile:UserPath];
}
@end
