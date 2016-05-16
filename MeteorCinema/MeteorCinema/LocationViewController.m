//
//  LocationViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "LocationViewController.h"

#import <CoreLocation/CoreLocation.h>


// 引入 城市列表 数据库
#import "DataBaseUtil.h"
// 城市数据
#import "CityMessage.h"

#import "LocationView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// tabbar 高 49

@interface LocationViewController () < UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate >

@property (nonatomic, strong) UITableView * allCityTableView;

@property (nonatomic, strong) UITableView * searchTableView;

// 装有所有城市的数组
@property (nonatomic, strong) NSMutableArray * allCityArray;
// 装有所有城市的字典
@property (nonatomic, strong) NSMutableDictionary * allCityDic;
// 装所有城市的首字母(并要实施排序)
@property (nonatomic, strong) NSMutableArray * allCityInitalArray;

// 搜索栏
@property (nonatomic, strong) UISearchBar * searchBar;
// 存储搜索结果
@property (nonatomic, strong) NSMutableArray * searchArray;


// 定位视图
@property (nonatomic, strong) LocationView * locationView;



// 实现 GPS 搜索位置
@property (nonatomic, strong) CLLocationManager * locationManager;
// 实现位置的 反编码
@property (nonatomic, strong) CLGeocoder * geocoder;


@end

@implementation LocationViewController

#pragma mark- 懒加载
-(UITableView *)allCityTableView{
    if (!_allCityTableView) {
        self.allCityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 15 + 100, ScreenWidth, self.view.bounds.size.height - 49 - 64 - ScreenHeight / 15 - 100) style:UITableViewStylePlain];
        self.allCityTableView.delegate = self;
        self.allCityTableView.dataSource = self;
        self.allCityTableView.backgroundColor = [UIColor yellowColor];
        
    }
    return _allCityTableView;
}


-(UITableView *)searchTableView{
    if (!_searchTableView) {
        self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 15 + 100, ScreenWidth, self.view.bounds.size.height - 49 - 64 - ScreenHeight / 15 - 100) style:UITableViewStylePlain];
        self.searchTableView.delegate = self;
        self.searchTableView.dataSource = self;
        self.allCityTableView.backgroundColor = [UIColor redColor];
        
        
    }
    return _searchTableView;
}

-(NSMutableArray *)allCityArray{
    if (!_allCityArray) {
        self.allCityArray = [NSMutableArray array];
    }
    return _allCityArray;
}

-(NSMutableDictionary *)allCityDic{
    if (!_allCityDic) {
        self.allCityDic = [NSMutableDictionary dictionary];
    }
    return _allCityDic;
}

-(NSMutableArray *)allCityInitalArray{
    if (!_allCityInitalArray) {
        self.allCityInitalArray = [NSMutableArray array];
    }
    return _allCityInitalArray;
}

-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        self.searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

-(LocationView *)locationView{
    if (!_locationView) {
        self.locationView = [[LocationView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 15, ScreenWidth, 100)];
    }
    return _locationView;
}

#pragma mark- 记载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    self.navigationItem.title = @"选择城市";
    
    // 处理数据
    [self handleCityListDataBase];
    // 排序
    [self sotrIntitalLetterArray];
    
    
    // 添加搜索按钮
    [self creatSearchBar];
    
    
    // 添加 定位 View
    [self.view addSubview:self.locationView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
    [self.locationView.cityNaemLabel addGestureRecognizer:tap];
    self.locationView.cityNaemLabel.userInteractionEnabled = YES;
    
//    // 记录每次定位的记录
//    NSString * tempString = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
//    if (tempString.length > 0) {
//        self.locationView.cityNaemLabel.text = tempString;
//    }else{
//        
//    }
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];

    
//    if (![CLLocationManager locationServicesEnabled]) {
//        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
//        return;
//    }
    //如果没有授权则请求(申请)用户授权
    // 添加 plist文件  NSLocationWhenInUseUsageDescription ( 注意事项 )
    
//    dispatch_after(2, dispatch_get_main_queue(), ^{
//        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//            [_locationManager requestWhenInUseAuthorization];
//        }
//        
//    });
    
    [self performSelector:@selector(delNotification) withObject:nil afterDelay:2.0f];
   
    
    
    //设置代理
    _locationManager.delegate = self;
    //设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance=1000.0;//十米定位一次
    _locationManager.distanceFilter = distance;
    //启动跟踪定位
    [_locationManager startUpdatingLocation];
    
    
//    self.locationView.cityNaemLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TureLocation"];
    
    
    // 注册通知 (来接收 刚查询到的地址 )
//    [self listener];
    
    
    
    // 隐藏额外的 线
    [self setExtraCellLineHidden:self.allCityTableView];
    //添加 tableView
    [self.view addSubview:self.allCityTableView];
    
//    self.allCityTableView.backgroundColor = [UIColor grayColor];
  //  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(popBack) userInfo:nil repeats:NO];

    
}

-(void)delNotification
{
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }
    
}



#pragma mark - 不允许定位 执行的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"广州" forKey:@"defaultLocation"];
        
        [[NSUserDefaults standardUserDefaults] setInteger:365 forKey:@"defaultLocationID"];
        
        self.locationView.cityNaemLabel.text = @"亲，请授权(づ￣3￣)づ╭❤～";
        
        
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}


//-(void)popBack{
//    [self.navigationController popViewControllerAnimated:YES];
//}
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
    

    
}

// 反编码获取位置
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    NSLog(@"stghjtyuhjk%@",location);
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        
        //        NSLog(@"详细信息:%@",placemark.addressDictionary);

        if (placemark.locality.length > 0) {
            
            NSString * string1= [placemark.locality substringFromIndex:(placemark.locality.length - 1)];
            
            if ([string1 isEqualToString:@"市"]) {
                NSString * string = [placemark.locality substringToIndex:(placemark.locality.length - 1)];
                self.locationView.cityNaemLabel.text = [NSString stringWithFormat:@"%@",string];
            }else{
                self.locationView.cityNaemLabel.text = placemark.locality;
            }
            
            
            //    如果不需要实时定位，使用完即使关闭定位服务
            [_locationManager stopUpdatingLocation];
            
        }else{
            self.locationView.cityNaemLabel.text = @"抱歉,当前网络不给力";
        }
        
    }];
    
    
}


//#pragma mark- 接受 刚获取的地点通知
//-(void)listener{
//    // 注册成为广播站ChangeTheme频道的听众
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    // 成为听众一旦有广播就来调用self recvBcast:函数
//    [nc addObserver:self selector:@selector(recvBcast:) name:@"kNotificationLocation" object:nil];
//}
//
//
//- (void) recvBcast:(NSNotification *)notify
//{
//    
//    //    static int index;
//    
//    //    NSLog(@"recv bcast %d", index++);
//    // 取得广播内容
//    
//    NSDictionary *dict = [notify userInfo];
//    
//    NSString * cityName = [dict objectForKey:@"TureLocation"];
//    
//    self.locationView.cityNaemLabel.text = cityName;
//    
//    [[NSUserDefaults standardUserDefaults] setValue:cityName forKey:@"cityName"];
//    
//}



#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

#pragma mark- 返回方法
-(void)backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)backTap:(UITapGestureRecognizer *)tap{
    
    // 要注意返回的 词
    NSArray * array = [[DataBaseUtil share] vagueSelectTableWith:self.locationView.cityNaemLabel.text];
    if (array.count > 0) {
        CityMessage * city = [array objectAtIndex:0];
        // 代理传值
        [self.delegate passLocationCity:city];
        
        
        // 改为通过 通知 来传达地点(方便在电影和影院页面做统一)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCity" object:nil userInfo:@{@"cityID":[NSNumber numberWithInteger:city.identifier],@"cityName":city.name}];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        
        if (![self.locationView.cityNaemLabel.text isEqualToString:@"抱歉,当前网络不给力"]){
            
            if (![self.locationView.cityNaemLabel.text isEqualToString:@"定位中..."]) {
                if (![self.locationView.cityNaemLabel.text isEqualToString:@"亲，请授权(づ￣3￣)づ╭❤～"]) {
                    
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"搜索不到目标" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:^{
                    [alert dismissViewControllerAnimated:YES completion:^{
                     
                    }];
                }];
                    
                }
            }
//         [self.locationView.cityNaemLabel.text isEqualToString:@"定位中..."]
            

        }
        
    }
    
    
}

#pragma mark- 处理数据库中的信息
-(void)handleCityListDataBase{
    
    NSArray * array = [[DataBaseUtil share] selectTable];
    
    for (CityMessage * city in array) {
        if ([self.allCityDic.allKeys containsObject:city.initialLetter]) {
            // 有对应的数组
            // 1. 先找到对应的 数组
            NSMutableArray * dicArray = [self.allCityDic objectForKey:city.initialLetter];
            // 2. 添加到对应数组
            [dicArray addObject:city];
            
        }else{
            
            // 没有对应的 数组
            // 1.先创建一个新的可变数组
            NSMutableArray * dicArray = [NSMutableArray array];
            // 2.在给字典添加一个新的数组
            [self.allCityDic setValue:dicArray forKey:city.initialLetter];
            // 3.添加到该数组中
            [dicArray addObject:city];
            
            [self.allCityInitalArray addObject:city.initialLetter];
        }
    }
}

#pragma mark- 对首字母字典进行排序
-(void)sotrIntitalLetterArray{
    
    // 按首字母排序
    self.allCityInitalArray = (NSMutableArray *)[self.allCityInitalArray sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        
    }];
    

}



#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.searchBar.text.length > 0) {
        return 1;
    }else{
        
        return self.allCityDic.allKeys.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.searchBar.text.length > 0) {
        return self.searchArray.count;
    }else{
        
        NSMutableArray * array = [self.allCityDic objectForKey:[self.allCityInitalArray objectAtIndex:section]];
        
        return array.count;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (self.searchBar.text.length > 0) {
        
        CityMessage * city = [self.searchArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = city.name;
        
        
    }else{
        
        NSMutableArray * array = [self.allCityDic objectForKey:[self.allCityInitalArray objectAtIndex:indexPath.section]];
        
        CityMessage * city = [array objectAtIndex:indexPath.row];
        
        cell.textLabel.text = city.name;
        
    }
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.searchBar.text.length > 0) {
        return 0;
    }else{
        return 30;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    if (self.searchBar.text.length > 0) {
        return nil;
    }else{
        
        return [[self.allCityInitalArray objectAtIndex:section] uppercaseString];
       
    }
}

// 设置右侧 索引兰
-(NSArray<NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (self.searchBar.text.length > 0) {
        return nil;
    }else{
        
        NSMutableArray * array = [NSMutableArray array];
        for (NSString * string in self.allCityInitalArray) {
            [string uppercaseString];
            [array addObject:[string uppercaseString]];
        }
        
        return array;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.searchBar resignFirstResponder];
    
    if (self.searchBar.text.length > 0) {
        
        CityMessage * city = [self.searchArray objectAtIndex:indexPath.row];
        
        [self.delegate passLocationCity:city];
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCity" object:nil userInfo:@{@"cityID":[NSNumber numberWithInteger:city.identifier],@"cityName":city.name}];
        
        [self saveUserdefault:city];
        
        
        
    }else{
        
      
        NSMutableArray * array = [self.allCityDic objectForKey:[self.allCityInitalArray objectAtIndex:indexPath.section]];
        
        
        
        
        
        CityMessage * city = [array objectAtIndex:indexPath.row];
        
        
            
        [self.delegate passLocationCity:city];
        
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCity" object:nil userInfo:@{@"cityID":[NSNumber numberWithInteger:city.identifier],@"cityName":city.name}];
        
        [self saveUserdefault:city];
            
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}

-(void)saveUserdefault:(CityMessage *)cityMessage{
    [[NSUserDefaults standardUserDefaults] setValue:cityMessage.name forKey:@"defaultLocation"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:cityMessage.identifier forKey:@"defaultLocationID"];
    
}

#pragma mark- searchBar 的设置
-(void)creatSearchBar{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 15)];
    self.searchBar.placeholder = @"输入城市名";
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // 点击searchButton
    
    
    
    // 回收键盘
    [searchBar resignFirstResponder];
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"%@",searchText);
    
    [self.searchArray removeAllObjects];
    
    NSArray * array = [[DataBaseUtil share] vagueSelectTableWith:searchText];
    
    [self.searchArray addObjectsFromArray:array];
    
    [self.allCityTableView reloadData];
    NSLog(@"%@",self.searchArray);
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
