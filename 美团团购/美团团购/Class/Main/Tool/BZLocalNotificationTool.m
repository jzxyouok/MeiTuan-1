//
//  BZLocalNotificationTool.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/10.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLocalNotificationTool.h"

@implementation BZLocalNotificationTool

+ (void)sendLocalNorificationToolSinceNow
{
    UILocalNotification *localNotification =[[UILocalNotification alloc]init];
    NSData *timeData = [[NSUserDefaults standardUserDefaults] dataForKey:BZMoreSetTimeTipDate];
    NSDate *date = [NSKeyedUnarchiver unarchiveObjectWithData:timeData];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSString *time = [formatter stringFromDate:date];
    int hour = [[time substringToIndex:2] intValue];
    int minu = [[time substringFromIndex:3] intValue];
    NSTimeInterval timeInterval = hour * 3600 + minu * 60;
    //        NSTimeInterval tiemInterval = [date timeIntervalSinceNow];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertAction = @"进入应用";
    localNotification.alertTitle = @"今天是个伟大的日子！";
    localNotification.alertBody = @"就在今天发生了一件了不起的大事";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
