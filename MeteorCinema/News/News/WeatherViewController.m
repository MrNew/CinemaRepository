//
//  WeatherViewController.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "WeatherViewController.h"

#import "WeatherDataBaseUtil.h"

#import "CityModel.h"

#import "WeatherModel.h"

#import "NetWorkRequestManager.h"



#import "NowWeatherView.h"

#import "Daily_forecastView.h"

#import "WeatherDataBaseUtil.h"

@interface WeatherViewController () < UITableViewDataSource,UITableViewDelegate >

// 选择城市
@property (nonatomic, strong) NSMutableArray * proArray;

@property (nonatomic, strong) NSMutableArray * cityArray;

// 二级菜单栏
@property (nonatomic, strong) UITableView * proTableView;

@property (nonatomic, strong) UITableView * cityTableView;


// 城市的按钮
@property (nonatomic, strong) UIButton * cityButton;

@property (nonatomic, strong) UIView * coverView;



// 显示界面
@property (nonatomic, strong) UIScrollView * scrollView;
// 头视图
@property (nonatomic, strong) UIView * topView;

@property (nonatomic, strong) NowWeatherView * nowView;

@property (nonatomic, strong) Daily_forecastView * day;

@end

@implementation WeatherViewController

-(NSMutableArray *)cityArray{
    if (!_cityArray) {
        self.cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

-(NSMutableArray *)array{
    if (!_proArray) {
        self.proArray = [NSMutableArray array];

        
    }
    return _proArray;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight / 3 + ScreenWidth / 4 + ScreenHeight / 4 * 3 + 64);
        self.scrollView.bounces = NO;
        
        
       
    }
    return _scrollView;
}


-(UITableView *)proTableView{
    if (!_proTableView) {
        self.proTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - ScreenHeight / 4, ScreenWidth / 3, ScreenHeight / 4) style:UITableViewStylePlain];
        self.proTableView.backgroundColor = COLOR(62, 162, 194, 1);
        self.proTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _proTableView;
}

-(UITableView *)cityTableView{
    if (!_cityTableView) {
        self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth / 3, - ScreenHeight / 4, ScreenWidth / 3 * 2, ScreenHeight / 4) style:UITableViewStylePlain];
        self.cityTableView.backgroundColor = COLOR(62, 162, 194, 1);
        self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _cityTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.proArray = (NSMutableArray *)[[WeatherDataBaseUtil share] selectColumnWithTableName:@"CityList" WithElement:@"prov"];
    
    self.cityArray = (NSMutableArray *)[[WeatherDataBaseUtil share] selectCityStringWith:@"广东"];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    [self.scrollView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"back1.jpg"];
    
    
    [self.view addSubview:self.scrollView];

    
    
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 15)];
    self.topView.backgroundColor = COLOR(46, 143, 167, 1);
    [self.scrollView addSubview:self.topView];
    [self.scrollView bringSubviewToFront:self.topView];
    
    
    self.cityButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.cityButton.frame = CGRectMake(self.topView.frame.size.width / 10, 0, self.topView.frame.size.width / 10 * 8, self.topView.frame.size.height);
    [self.cityButton setTitle:self.addressString forState:UIControlStateNormal];
    
    [self.cityButton addTarget:self action:@selector(changeTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:self.cityButton];
    [self.cityButton setBackgroundColor:COLOR(46, 143, 167, 1)];

    
    
    
    
    
    
    self.nowView = [[NowWeatherView alloc] initWithFrame:CGRectMake(10, ScreenHeight / 3, ScreenWidth / 8 * 3, ScreenWidth / 4)];
//    self.nowView.backgroundColor = COLOR(200, 190, 210, 1);
    
//    if (self.nowDic) {
        [self.nowView setTitleWithDictionary:self.nowDic];
        [self.scrollView addSubview:self.nowView];
//    }
    
    
    // 请求数据
    [self requestData:self.cityButton.titleLabel.text];

    // 处理数据
    [self.day setWeatherValueWith:self.daily_forecastArray];
    
    

    
    self.day = [[Daily_forecastView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 3 + ScreenWidth / 4, ScreenWidth, ScreenHeight / 4 * 3)];
    self.day.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.day];
    
    
    
    
    
}

-(void)requestData:(NSString *)cityName{
    NSString * urlStr = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?city=%@&key=5719f35cf7424123bd8032d1d7b8cc98",cityName];
    
    [NetWorkRequestManager requestWithType:Get URLString:urlStr parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"%@",dataDic);
        NSArray * array = [dataDic objectForKey:@"HeWeather data service 3.0"];
        
        //        for (int i = 0; i < array.count; i++) {
        //            NSLog(@"%@",array[i]);
        //        }
        NSDictionary * dic = array[0];
        
        self.aqiDic = [dic objectForKey:@"aqi"];
        //        NSLog(@"%@",self.aqiDic);
        
        self.basicDic = [dic objectForKey:@"basic"];
        //        NSLog(@"%@",self.basicDic);
        
        self.daily_forecastArray = [dic objectForKey:@"daily_forecast"];
//                NSLog(@"%@",self.daily_forecastArray);
        
        self.hourly_forecastArray = [dic objectForKey:@"hourly_forecast"];
//                NSLog(@"%@",self.hourly_forecastArray);
        
        
        self.suggestion = [dic objectForKey:@"suggestion"];
        //        NSLog(@"%@",self.suggestion);
        
        self.nowDic = [dic objectForKey:@"now"];
//        NSLog(@"%@",self.nowDic);

       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.daily_forecastArray.count > 0) {
                
                // 处理数据

                [self.nowView setTitleWithDictionary:self.nowDic];

                [self.day setWeatherValueWith:self.daily_forecastArray];

            }else{
                
               
            }
            
        });
        
        
    } error:^(NSError *error) {
        
    }];
}


-(void)changeTitleButton:(UIButton *)button{
    
    self.scrollView.scrollEnabled = NO;
    
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.scrollView addSubview:self.coverView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearView:)];
//    tap.numberOfTapsRequired = 2;
    [self.coverView addGestureRecognizer:tap];
    
    
    
    // 添加标示符
    self.proTableView.tag = 40;
    [self.scrollView addSubview:self.proTableView];
//    [self.scrollView 
    
    self.proTableView.delegate = self;
    self.proTableView.dataSource = self;
    

    
    [UIView animateWithDuration:2 animations:^{
        self.proTableView.frame = CGRectMake(0, ScreenHeight / 15, ScreenWidth / 3, ScreenHeight / 4);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
    
    
    
    
    
    
    [self.scrollView addSubview:self.cityTableView];
//    [self.scrollView sendSubviewToBack:self.cityTableView];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    // 添加标示符
    self.cityTableView.tag = 41;
    [UIView animateWithDuration:2 animations:^{
        self.cityTableView.frame = CGRectMake(ScreenWidth / 3, ScreenHeight / 15, ScreenWidth / 3 * 2, ScreenHeight / 4);
    } completion:^(BOOL finished) {
        
    }];
    
    [self.scrollView bringSubviewToFront:self.topView];
    
}


-(void)clearView:(UITapGestureRecognizer *)tap{
    
    [self.coverView removeFromSuperview];
    
    self.proTableView.frame = CGRectMake(0, - ScreenHeight / 4, ScreenWidth / 3, ScreenHeight / 4);
    [self.proTableView removeFromSuperview];
    self.cityTableView.frame = CGRectMake(ScreenWidth / 3, - ScreenHeight / 4, ScreenWidth / 3 * 2, ScreenHeight / 4);
    [self.cityTableView removeFromSuperview];
    self.scrollView.scrollEnabled = YES;
}



#pragma mark- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 40) {
        return self.proArray.count;
    }else{
        return self.cityArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"weather";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (tableView.tag == 40) {
        cell.textLabel.text = [[WeatherDataBaseUtil share] selectColumnWithTableName:@"CityList" WithElement:@"prov"][indexPath.row];
        
    }else if (tableView.tag == 41){
        
        cell.textLabel.text = self.cityArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 40) {
        NSString * string = [[WeatherDataBaseUtil share] selectColumnWithTableName:@"CityList" WithElement:@"prov"][indexPath.row];
        
        [self.cityArray removeAllObjects];
        self.cityArray = (NSMutableArray *)[[WeatherDataBaseUtil share] selectCityStringWith:string];
        
        [self.cityTableView reloadData];
        
    }else if (tableView.tag == 41){
        
        NSString * string = self.cityArray[indexPath.row];
        
        [self.cityButton setTitle:string forState:UIControlStateNormal];
        
        [self requestData:string];
        // 处理数据
        [self.nowView setTitleWithDictionary:self.nowDic];
        [self.day setWeatherValueWith:self.daily_forecastArray];
        
        
        [self.coverView removeFromSuperview];
        self.proTableView.frame = CGRectMake(0, - ScreenHeight / 3, ScreenWidth / 3, ScreenHeight / 3);
        [self.proTableView removeFromSuperview];
        self.cityTableView.frame = CGRectMake(ScreenWidth / 3, - ScreenHeight / 3, ScreenWidth / 3 * 2, ScreenHeight / 3);
        [self.cityTableView removeFromSuperview];
        self.scrollView.scrollEnabled = YES;
        
    }
}





-(void)backButton:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
