//
//  MovieViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieViewController.h"

#import "LocationViewController.h"
// 前景图片
#import "FirsView.h"
// 城市数据库
#import "DataBaseUtil.h"
// 申请数据
#import "NetWorkRequestManager.h"

// 热映电影
#import "HotMovieTableViewCell.h"
// 热映数据模型
#import "HotMovieModel.h"

// 最受关注 cell
#import "AttentionMovieTableViewCell.h"


// 即将上映数据模型
#import "FutureMovieModel.h"


#import "TopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MovieViewController () < LocationViewControllerDelegate,UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UITableView * tableView;

// 热映电影数组
@property (nonatomic, strong) NSMutableArray * hotArray;

// 将上映电影数组 (最受关注)
@property (nonatomic, strong) NSMutableArray * attentionArray;
// 即将上映电影数组 (即将上映)
@property (nonatomic, strong) NSMutableArray * futureArray;

// 正在热映和即将上映的转换
@property (nonatomic, strong) TopView * topView;



//  标记当前显示什么内容
@property (nonatomic, strong) NSString * status;



@end

@implementation MovieViewController

#pragma mark- 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 15, ScreenWidth, ScreenHeight - 64 - ScreenHeight / 15) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}


-(NSMutableArray *)hotArray{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

-(NSMutableArray *)attentionArray{
    if (!_attentionArray) {
        self.attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
}



-(NSMutableArray *)futureArray{
    if (!_futureArray) {
        self.futureArray = [NSMutableArray array];
    }
    return _futureArray;
}

-(UIView *)topView{
    if (!_topView) {
        self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 15)];
        self.topView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        
    }
    return _topView;
}


#pragma mark- 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"电影";
    self.status = @"正在热映";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"广州" style:UIBarButtonItemStylePlain target:self action:@selector(selectorLocation:)];
    
    //***************** 定位的模式 ********************//
    
    // 先判断是否进入 算地点界面
    NSString * locationName = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultLocation"];
    // 判断是否进入选地点的页面
    if (locationName.length > 0) {
        self.navigationItem.leftBarButtonItem.title = locationName;
    }else{
        LocationViewController * location = [[LocationViewController alloc] init];
        
        location.delegate = self;
        
        [self.navigationController pushViewController:location animated:YES];
        
    }
    // 等通知 通知( 比较通知信息 与 原来存的 地点是否吻合来决定是否 更新信息 )
    [self listener];
    
    //***********************前景图*********************//
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [user stringForKey:@"标记"];
    
    if (![string isEqualToString:@"you"]) {
        
        
        FirsView *fir = [[FirsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        
        [window addSubview:fir];
        
    }
    
    
    //************************ 加载数据 *********************//
    //  地点 name
    //  locationName
    NSInteger locationID = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultLocationID"];
    
    // 申请
    [self requestHotData:locationID];
    [self requestFutureData:locationID];
    
    
    // 添加tableView
    [self.view addSubview:self.tableView];
    
    
    [self.view addSubview:self.topView];
    [self.topView setTitleButton:@[@"正在热映",@"即将上映"]];
    for (UIButton * button in self.topView.buttonArray) {
        [button addTarget:self action:@selector(reflashData:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 15)];
//    [self.topView addSubview:segment];
//    [segment insertSegmentWithTitle:@"即将上映" atIndex:0 animated:NO];
//    [segment insertSegmentWithTitle:@"正在热映" atIndex:0 animated:NO];
//    segment.layer.borderColor = [UIColor clearColor].CGColor;
//    [segment setTintColor:[UIColor clearColor]];
    
}

-(void)reflashData:(UIButton *)button{
//    if ([button.titleLabel.text isEqualToString:@"正在热映"]) {
//        
//        self.status = @"正在热映";
//        
//        
//    }else if ([button.titleLabel.text isEqualToString:@"即将上映"]){
//        
//        
//        
//    }
    
    self.status = button.titleLabel.text;
    
    [self.tableView reloadData];
  
    
    
}



#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.status isEqualToString:@"正在热映"]) {
        return 1;
        
    }else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([self.status isEqualToString:@"正在热映"]) {
        
        return self.hotArray.count;
        
    }else{
        if (section == 0) {
            return 1;
        }else{
            return self.futureArray.count;
        }
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"hot";
    static NSString * identifier1 = @"cell";
    if ([self.status isEqualToString:@"正在热映"]) {
        HotMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HotMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        HotMovieModel * hot = [self.hotArray objectAtIndex:indexPath.row];
        cell.hot = hot;
        return cell;
        
        
    }else{
        if (indexPath.section == 0) {
        
        AttentionMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[AttentionMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        
            [cell setDetailView:self.attentionArray];
            return cell;
        }else{
            
            
            return nil;
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenHeight / 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.status isEqualToString:@"正在热映"]) {
       
        return 0;
        
    }else{
        return 50;
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.status isEqualToString:@"正在热映"]) {
        return nil;
        
    }else{
        if (section == 0) {
            return @"最受关注";
        }else{
            return @"即将上映";
        }
    }
}


#pragma mark- 申请数据

// 申请 热映数据
// 申请 数据 (附上 Locationid 参数)
-(void)requestHotData:(NSInteger)identifier{
    
//    http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=490
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=%ld",identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        // 申请数据完毕
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * array = [dataDic objectForKey:@"ms"];
        for (NSDictionary * dic in array) {
            
            HotMovieModel * hot = [[HotMovieModel alloc] init];
            [hot setValueWithDataDic:dic];
            
            [self.hotArray addObject:hot];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        
    }];
    
    
    
}


// 申请即将上映数据
-(void)requestFutureData:(NSInteger)identifier{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat: @"http://api.m.mtime.cn/Movie/MovieComingNew.api?locationId=%ld",identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
       
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray * attention = [dataDic objectForKey:@"attention"];
        
        for (NSDictionary * dic in attention) {
            FutureMovieModel * future = [[FutureMovieModel alloc] init];
            
            [future setValueWithDataDic:dic];
            
            [self.attentionArray addObject:future];
            
            
            
            
        }
        
        
        NSMutableArray * moviecomings = [dataDic objectForKey:@"moviecomings"];
        
        for (NSDictionary * dic in moviecomings) {
            
            FutureMovieModel * future = [[FutureMovieModel alloc] init];
            
            [future setValueWithDataDic:dic];
            
            [self.futureArray addObject:future];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            
            [self.tableView reloadData];
            
            
        });
        
        
        
        
    } error:^(NSError *error) {
        
    }];
}












#pragma mark- 重设地点
-(void)selectorLocation:(UIButton *)button{
    
    LocationViewController * location = [[LocationViewController alloc] init];
    
    location.delegate = self;
    
    [self.navigationController pushViewController:location animated:YES];
    
    
}

#pragma mark- 代理传值
-(void)passLocationCity:(CityMessage *)city{
//    NSLog(@"%@",city.name);
    
    // 做响应跟新数据的操作
    
    self.navigationItem.leftBarButtonItem.title = city.name;
    
    
    [self.hotArray removeAllObjects];
    [self requestHotData:city.identifier];

    
    
    
}

#pragma mark- 接受 刚获取的地点通知
-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"kNotificationLocation" object:nil];
}


- (void) recvBcast:(NSNotification *)notify
{

    // 取得广播内容

    NSDictionary *dict = [notify userInfo];

    NSString * cityName = [dict objectForKey:@"TureLocation"];
    
    // 要注意返回的 词
    // 根据通知回来的值搜索是否有值
    NSArray * array = [[DataBaseUtil share] vagueSelectTableWith:cityName];
    
    // 先判断是否 与选中地点 相一致
    NSString * locationName = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultLocation"];
    
    if (array.count > 0) {
        
        // 找到数据库中响应的 city
        CityMessage * city = [array objectAtIndex:0];
       
        if (locationName.length > 0) {
            
            if (![city.name isEqualToString:locationName]) {
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"检测到不是定位城市" message:@"是否切换" preferredStyle:UIAlertControllerStyleAlert];
                
                // 执行相应操作
                UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action1];
                
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    // 重新设置值
                    [[NSUserDefaults standardUserDefaults] setValue:city.name forKey:@"defaultLocation"];
                    
                    [[NSUserDefaults standardUserDefaults] setInteger:city.identifier forKey:@"defaultLocationID"];
                    
                    self.navigationItem.leftBarButtonItem.title = cityName;
                    
                    [self.hotArray removeAllObjects];
                    [self requestHotData:city.identifier];
                    
                }];
                [alert addAction:action2];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
            }else{
                
                
            }
            
        }
     
    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
