//
//  NSString+File.m
//  河科院微博
//
//  Created by 👄 on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//


#import "NSString+File.h"

@implementation NSString (File)
- (long long)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 1.路径不存在就返回
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (fileExists == NO) return 0;
    
    // 2.判断路径是不是文件夹
    if (isDirectory) { // 是
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else { // 不是
        // 计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}
@end
