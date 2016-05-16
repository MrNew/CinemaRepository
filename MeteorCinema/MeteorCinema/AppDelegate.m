//
//  AppDelegate.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>


#import "TabBarViewController.h"

#import "NavigationViewController.h"
@interface AppDelegate () < CLLocationManagerDelegate >
// 实现 GPS 搜索位置
@property (nonatomic, strong) CLLocationManager * locationManager;
// 实现位置的 反编码
@property (nonatomic, strong) CLGeocoder * geocoder;



@property (nonatomic, strong) NSMutableArray * userDefaultLanguages;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:2.0];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    self.window.rootViewController = [[TabBarViewController alloc] init];
    
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    self.userDefaultLanguages = [NSMutableArray array];
    self.userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                             objectForKey:@"AppleLanguages"];
    
    
    // 强制 成 简体中文
    [[NSUserDefaults
      standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                       nil] forKey:@"AppleLanguages"];
    
    

    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    [[NSUserDefaults
      standardUserDefaults] setObject:self.userDefaultLanguages
     forKey:@"AppleLanguages"];
    
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    self.userDefaultLanguages = [NSMutableArray array];
    self.userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                 objectForKey:@"AppleLanguages"];
    
    
    // 强制 成 简体中文
    [[NSUserDefaults
      standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                       nil] forKey:@"AppleLanguages"];
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
