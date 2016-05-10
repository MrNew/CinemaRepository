//
//  ViewController.m
//  News
//
//  Created by lanou on 16/4/8.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "ViewController.h"
// 信息栏
#import "InformationBar.h"
// 其子控制器
#import "RootViewController.h"
// 抽屉栏
#import  "Login.h"


// 数据库
#import "DataBaseUtil.h"

// 可跳转到的视图
#import "MoreViewController.h"

#import "CollectionViewController.h"

#import "AddCollectionViewController.h"

#import "WeatherViewController.h"

#import "SearchViewController.h"

#define WIDTH self.view.frame.size.width

#define HEIGHT self.view.frame.size.height



#import "NowWeatherView.h"

#import "WeatherDataBaseUtil.h"




@interface ViewController () < UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,AddCollectionViewControllerDelegate >
{
    RootViewController * vc;
    UIView * clearView;
    UITapGestureRecognizer * tap;
//    UISwipeGestureRecognizer * swipe;
    UIPanGestureRecognizer * pan;
    Login * locker;
}

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSString * addressString;



// 城市基本信息
@property (nonatomic, strong) NSDictionary * aqiDic;
// 城市空气质量
@property (nonatomic, strong) NSDictionary * basicDic;
//
@property (nonatomic, strong) NSArray * daily_forecastArray;
//
@property (nonatomic, strong) NSArray * hourly_forecastArray;
//
@property (nonatomic, strong) NSDictionary * nowDic;
//
@property (nonatomic, strong) NSDictionary * suggestion;



@property (nonatomic, strong) NowWeatherView * now;

@property (nonatomic, strong) UIImage * nowImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 创建数据库(以存储数据
    NSLog(@"%@",NSHomeDirectory());
    
    [[DataBaseUtil share] createTableWithName:@"collection"];
    [[DataBaseUtil share] createTableWithName:@"history"];
    
    
    // 记录 查询天气的地方名字
    if (self.addressString.length == 0) {
        self.addressString = @"广州";
    }
    
    [self requestData:self.addressString];
    
    
    
    self.view.backgroundColor = COLOR(70, 126, 194, 0.9);
    
    // 抽屉栏
    locker = [[Login alloc] initWithFrame:CGRectMake( 0, 0, WIDTH / 3 * 2, HEIGHT)];
    
    
    self.tableView = [[UITableView alloc] init];
    [locker addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT / 6 * 3);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = NO;
//    self.tableView.backgroundColor = [UIColor purpleColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    

    [self.view addSubview:locker];
    
   
    [self createRootViewController];
    
    
}


#pragma mark- tableView 更新
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 0) {

        cell.imageView.tintColor = [UIColor whiteColor];
        if (self.now) {
            [cell addSubview:self.now];
            cell.imageView.image = self.nowImage;
        }
        
        UILabel * address = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width / 4  * 2.5, 0, 50, 50)];
        address.text = self.addressString;
        address.textColor = [UIColor whiteColor];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [cell addSubview:address];
            
        });
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"订阅";
        cell.imageView.image = [UIImage imageNamed:@"message"];
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"收藏";
        cell.imageView.image = [UIImage imageNamed:@"shoucang"];
        
    }
    //    if (indexPath.row == 3) {
    //        cell.textLabel.text = @"评论";
    //        cell.imageView.image = [UIImage imageNamed:@"pinglun"];
    //    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"更多";
        cell.imageView.image = [UIImage imageNamed:@"gengduo"];
    }
    if (indexPath.row == 5) {
        cell.textLabel.text = @"请输入关键词";
        cell.imageView.image = [UIImage imageNamed:@"sousuo"];
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        WeatherViewController * weather = [[WeatherViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:weather];
        nav.navigationBar.translucent = NO;
        weather.addressString = self.addressString;
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    if (indexPath.row == 1) {

        UICollectionViewFlowLayout * layout = [self createUICollectionViewFlowLayout];
        
        
        AddCollectionViewController * add = [[AddCollectionViewController alloc] initWithCollectionViewLayout:layout];
        add.delegate = self;
        
        add.boardArray = vc.boardArray;
        
        UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:add];
        
        
        
        navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:navigation animated:YES completion:^{
            
        }];
    }
    
    if (indexPath.row == 2) {
        CollectionViewController * collection = [[CollectionViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:collection];
        nav.navigationBar.translucent = NO;
    
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    if (indexPath.row == 4) {
        MoreViewController * more = [[MoreViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:more];
        nav.navigationBar.translucent = NO;
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    if (indexPath.row == 5) {
        
        
        SearchViewController * search = [[SearchViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:search];
        nav.navigationBar.translucent = NO;
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return HEIGHT / 6 * 3 / 4;
    }else{
        return (HEIGHT / 6 * 3 - HEIGHT / 6 * 3 / 4) / 5;
    }
    
    
}

#pragma mark- 申请天气数据
-(void)requestData:(NSString *)cityName{
    NSString * urlStr = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?city=%@&key=5719f35cf7424123bd8032d1d7b8cc98",cityName];

    [NetWorkRequestManager requestWithType:Get URLString:urlStr parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"%@",dataDic);
        NSArray * array = [dataDic objectForKey:@"HeWeather data service 3.0"];

        // 天气信息
        NSDictionary * dic = array[0];

        // 不同的天气 信息字典 数组
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

                self.now = [[NowWeatherView alloc] initWithFrame:CGRectMake(HEIGHT / 6 * 3 / 4 + 10, 0, HEIGHT / 6 * 3 / 4 * 1.8, HEIGHT / 6 * 3 / 4)];
                [self.now setTitleWithDictionary:self.nowDic];

                
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                    NSDictionary * nowdic = [self.nowDic objectForKey:@"cond"];
                    
                    NSArray * dayArray = [[WeatherDataBaseUtil share] selectWeatherNameWith:[nowdic objectForKey:@"txt"]];
                    NSLog(@"%@",[nowdic objectForKey:@"txt"]);
                    
                    WeatherModel * dayweather = dayArray[0];
                    
                    NSData * dayData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dayweather.weatherIcon]];
                    
                self.nowImage = [UIImage imageWithData:dayData];
                self.nowImage = [self.nowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                
                    dispatch_async(dispatch_get_main_queue(), ^{
                
                        [self.tableView reloadData];
                        
                    });
                
                });
        
            }else{

            }

        });


    } error:^(NSError *error) {

    }];
}


#pragma mark- addController
-(UICollectionViewFlowLayout *)createUICollectionViewFlowLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(100, 30);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return layout;
}


-(void)passboardArray:(NSArray *)boardArray{
    
    for (UIViewController * oldVC in self.childViewControllers) {
 
        if ([oldVC isKindOfClass:[RootViewController class]]) {

            RootViewController * newVC = (RootViewController *)oldVC;
    
            [newVC refresh:boardArray];
            
            newVC.view.frame = CGRectMake(0, 0, newVC.view.frame.size.width, newVC.view.frame.size.height);
        }
    
    }


}

#pragma mark- 根视图
// 创建根视图,并添加手势
-(void)createRootViewController{
    // 主视图
    vc = [[RootViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [vc.info.headButton addTarget:self action:@selector(appearLocker:) forControlEvents:UIControlEventTouchUpInside];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack:)];
    
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBack:)];
    pan.delegate = self;
    [pan setEnabled:YES];
    //    [pan delaysTouchesEnded];
}



// 出现抽屉栏
-(void)appearLocker:(UIButton *)button{
    
    // 视图上的 透明视图
    clearView = [[UIView alloc] initWithFrame:vc.view.frame];
    
    // 添加点击手势
    [clearView addGestureRecognizer:tap];
    
    // 添加 拖拽手势
    [clearView addGestureRecognizer:pan];
    
    [vc.view addSubview:clearView];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = vc.view.frame;
        frame.origin.x = WIDTH / 3 * 2;
        vc.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

// 点击手势
-(void)returnBack:(UITapGestureRecognizer *)gesture{

    [UIView animateWithDuration:0.5 animations:^{
        vc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        [clearView removeFromSuperview];
        
        [clearView removeGestureRecognizer:gesture];
    }];
    
    
}
// 轻扫手势
-(void)moveBack:(UISwipeGestureRecognizer *)gesture{
    
    [UIView animateWithDuration:0.6 animations:^{
        vc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        [clearView removeFromSuperview];
        [clearView removeGestureRecognizer:gesture];
    }];
    
}

// 拖拽手势
-(void)panBack:(UIPanGestureRecognizer *)gesture{
    
    UIView * view = (UIView *)gesture.view;
//    vc.view.transform = CGAffineTransformTranslate(vc.view.transform, 1, 0);
    // 移动的点
    CGPoint point = [gesture translationInView:view];
//    NSLog(@"%f",point.x);
    [gesture setTranslation:CGPointZero inView:view];
    

    // 版本 2.0
        CGRect frame = vc.view.frame;
        frame.origin.x += point.x;
        if (frame.origin.x <= WIDTH / 3 * 2 && frame.origin.x > 0) {
            frame.origin.x = frame.origin.x + point.x;
            vc.view.frame = frame;
            
            
        }else if (frame.origin.x <= 0){
            [clearView removeFromSuperview];
            vc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            
            [clearView removeGestureRecognizer:gesture];
        }else{
            vc.view.frame = CGRectMake(WIDTH / 3 * 2, 0, WIDTH, HEIGHT);
        }
        

    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if ( vc.view.frame.origin.x <= WIDTH / 3 / 2 * 2) {
            [UIView animateWithDuration:0.1 animations:^{
                vc.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            }];
            [clearView removeFromSuperview];
            [clearView removeGestureRecognizer:gesture];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                vc.view.frame = CGRectMake(WIDTH / 3 * 2, 0, WIDTH, HEIGHT);
        
            }];
        }
    }
}



-(void)changeStyle:(BOOL)style{
    if (style) {
        vc.info.backgroundColor = [UIColor blackColor];
        vc.info.scrollView.backgroundColor = vc.info.backgroundColor;
        
    }else{
        vc.info.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:244/255.0 alpha:1];
        vc.info.scrollView.backgroundColor = vc.info.backgroundColor;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
