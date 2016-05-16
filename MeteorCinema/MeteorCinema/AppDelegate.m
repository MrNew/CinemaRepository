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
    
    
    
//    NavigationViewController * nav = [[NavigationViewController alloc] initWithRootViewController:[[LocationViewController alloc] init]];
    
//    self.window.rootViewController = nav;
    
    
    // 查询是否获得权限
    self.locationManager = [[CLLocationManager alloc] init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
    }
//    //如果没有授权则请求(申请)用户授权
//    // 添加 plist文件  NSLocationWhenInUseUsageDescription ( 注意事项 )
//    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//        [_locationManager requestWhenInUseAuthorization];
//    }
//    
//    //设置代理
//    _locationManager.delegate = self;
//    //设置定位精度
//    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//    //定位频率,每隔多少米定位一次
//    CLLocationDistance distance=1000.0;//十米定位一次
//    _locationManager.distanceFilter = distance;
//    //启动跟踪定位
//    [_locationManager startUpdatingLocation];
    

    
    return YES;
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
#pragma mark 根据坐标取得地名
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    
    // 初始化
    _geocoder=[[CLGeocoder alloc]init];
    
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    //    如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    
}

// 反编码获取位置
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    NSLog(@"stghjtyuhjk%@",location);
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        
        //        NSLog(@"详细信息:%@",placemark.addressDictionary);
        
//        self.locationView.cityNaemLabel.text = [NSString stringWithFormat:@"%@",placemark.locality];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:placemark.locality forKey:@"TureLocation"];
        
        NSLog(@"%@",placemark.locality);
        
        
        
        
        // 发送通知
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        

        if (placemark.locality.length > 0) {
            [nc postNotificationName:@"kNotificationLocation" object:nil userInfo:@{@"TureLocation":placemark.locality}];

            
        }else{
            [nc postNotificationName:@"kNotificationLocation" object:nil userInfo:@{@"TureLocation":@"广州"}];
        }
        
        
        
        
        
    }];
    
    
}

#pragma mark - 不允许定位 执行的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"广州" forKey:@"defaultLocation"];
        
        [[NSUserDefaults standardUserDefaults] setInteger:365 forKey:@"defaultLocationID"];
        
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
