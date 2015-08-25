//
//  AppDelegate.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/16.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "AppDelegate.h"
#import "BZTabBarController.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialYiXinHandler.h"
#import "UMSocialTwitterHandler.h"
#import "MobClick.h"
#import <MapKit/MapKit.h>
#import "UMSocialQQHandler.h"

@interface AppDelegate ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[BZTabBarController alloc]init];
    [self.window makeKeyAndVisible];

    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil]];

    
    //打开腾讯微博SSO开关，设置回调地址
    /********* 由于苹果审核，需要64位SDK，但是腾讯微博没有提供64位SDK所有不再由此方法 *******/
//    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    // 设置友盟appKey
    [UMSocialData setAppKey:@"55940bd867e58eb659000453"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址,必须新浪注册时填写的回调地址相同
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxe2a367623e96ad91" appSecret:@"ee481425ddbbc0b5548fe7c808b541db" url:@"http://www.umeng.com/social"];
    
    //设置易信Appkey和分享url地址,注意需要引用头文件 #import UMSocialYixinHandler.h
    [UMSocialYixinHandler setYixinAppKey:@"yxa0f1187d42134329b2ec34cefa67a5c0" url:@"http://www.umeng.com/social"];
    
    // 打开Twitter分享
    [UMSocialTwitterHandler openTwitter];
    
    // QQ及QQ空间分享
    [UMSocialQQHandler setQQWithAppId:@"1104726743" appKey:@"moPbXiV0zJtSJcdZ" url:@"http://www.umeng.com/social"];
    
    // 弹框提示用户是否开启定位
    _locationManager  = [[CLLocationManager alloc]init];
    [_locationManager requestAlwaysAuthorization];
    
    // 集成友盟统计分析
    [MobClick startWithAppkey:@"55bdde9367e58efd41003dbe" reportPolicy:SEND_INTERVAL channelId:nil];
    [MobClick setEncryptEnabled:YES];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
