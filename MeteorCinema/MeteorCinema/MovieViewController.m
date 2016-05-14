//
//  MovieViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieViewController.h"


#import "LocationViewController.h"

#import "MovieDetailViewController.h"

#import "TabBarViewController.h"

#import "VideoListViewController.h"

#import "HotMovieTableViewCell.h"

#import "MovieWebViewController.h"


// 前景图片
#import "FirsView.h"
// 城市数据库
#import "DataBaseUtil.h"
// 申请数据
#import "NetWorkRequestManager.h"



// 最受关注 cell
#import "AttentionMovieTableViewCell.h"


#import "FutureTableViewCell.h"


// 即将上映数据模型
#import "FutureMovieModel.h"

#import "TopView.h"


#import "MovieCollectionDataBaseUtil.h"

#import "XRCarouselView.h"


#define Width [UIScreen mainScreen].bounds.size.width

#define Height [UIScreen mainScreen].bounds.size.height







@interface MovieViewController () < LocationViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,AttentionMovieTableViewCellDelegate,FutureTableViewDelegate,UIScrollViewDelegate,XRCarouselViewDelegate >


@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIButton * topButton;
// 热映电影数组
@property (nonatomic, strong) NSMutableArray * hotArray;

// 将上映电影数组 (最受关注)
@property (nonatomic, strong) NSMutableArray * attentionArray;
// 即将上映电影数组 (即将上映)
@property (nonatomic, strong) NSMutableArray * futureArray;

@property (nonatomic, strong) NSMutableArray * headArray;


// 正在热映和即将上映的转换
@property (nonatomic, strong) TopView * topView;





@end

@implementation MovieViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;

}

#pragma mark- 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height / 15 - 49, Width, Height - 64 - Height / 15) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self setExtraCellLineHidden:self.tableView];
        
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

-(NSMutableArray *)headArray{
    if (!_headArray) {
        self.headArray = [NSMutableArray array];
    }
    return _headArray;
}


-(UIView *)topView{
    if (!_topView) {

        self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 3, Width, Height / 20)];

        self.topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}



#pragma mark- 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",NSHomeDirectory());
    
    [[MovieCollectionDataBaseUtil share] createTableWithName:@"movie"];
    

    self.navigationItem.title = @"电影";
    
    self.topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.topButton setTitle:@"电影" forState:UIControlStateNormal];
    [self.topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = self.topButton;
    
    
    
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
        
//        location.delegate = self;
        
        [self.navigationController pushViewController:location animated:YES];
        
    }
    // 等通知 通知( 比较通知信息 与 原来存的 地点是否吻合来决定是否 更新信息 )
    [self listener];
    
    [self listenerForcast];
    
    [self listenerPassCity];
    
    //***********************前景图*********************//
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [user stringForKey:@"标记"];
    

    if (![string isEqualToString:@"you"]) {
        
        
        FirsView *fir = [[FirsView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        
        [window addSubview:fir];
        
    }
    
    
    //************************ 加载数据 *********************//
    //  地点 name
    //  locationName
    NSInteger locationID = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultLocationID"];
    
    
    [self requestHeadData];
    // 申请
    [self requestHotData:locationID];
    [self requestFutureData:locationID];
    
    
    // 添加tableView
    [self.view addSubview:self.tableView];
    
}



-(void)reflashData:(UIButton *)button{

    
    self.status = button.titleLabel.text;
    
    [self.tableView reloadData];
  
    
    
}


#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
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
    static NSString * identifier1 = @"attention";
    static NSString * identifier2 = @"future";
    if ([self.status isEqualToString:@"正在热映"]) {
        HotMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HotMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
       
            
        HotMovieModel * hot = [self.hotArray objectAtIndex:indexPath.row];
            
        
            
        cell.hot = hot;
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        return cell;
        
        
    }else{
        if (indexPath.section == 0) {
        
        AttentionMovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            
        if (cell == nil) {
            cell = [[AttentionMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        
            [cell setDetailView:self.attentionArray];
            
            cell.delegate = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            FutureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (cell == nil) {
                cell = [[FutureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier2];
            }
            FutureMovieModel * future = [self.futureArray objectAtIndex:indexPath.row];
            
            cell.future = future;
            
            cell.delegate = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Height / 5;
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailViewController * movie = [[MovieDetailViewController alloc] init];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    [(TabBarViewController *)self.tabBarController hidenBottomView];
    
    // 传入 当前城市 ID
    NSInteger cityID = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultLocationID"];
    
    movie.cityID = cityID;
    NSLog(@"%ld",cityID);
    
    if ([self.status isEqualToString:@"正在热映"]) {
        
//        movie.cityID
        
        HotMovieModel * hot = [self.hotArray objectAtIndex:indexPath.row];
       
        movie.movieID = hot.identifier;
        movie.hotMovie = hot;
        
        
    }else{
        if (indexPath.section == 0) {
            
            
            
        }else{
            
//            [self.navigationController pushViewController:movie animated:YES];
        
            FutureMovieModel * future = [self.futureArray objectAtIndex:indexPath.row];
            movie.movieID = future.identifier;
            movie.future = future;
        }
    }
    [self.navigationController pushViewController:movie animated:YES];
    
}




#pragma mark- 观察tableView 移动的情况
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    //    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 1000) {
        self.topButton.userInteractionEnabled = YES;
        [self.topButton setTitle:@"点击返回顶部" forState:UIControlStateNormal];
        [self.topButton addTarget:self action:@selector(topButtonClik:) forControlEvents:UIControlEventTouchUpInside];
        [self.topButton sizeToFit];
        
        
    }else{
        [self.topButton setTitle:@"电影" forState:UIControlStateNormal];
        self.topButton.userInteractionEnabled = NO;
    }
    
    
    
}

-(void)topButtonClik:(UIButton *)button{
    
    
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}



#pragma mark- 申请数据


//http://cms.phonemovie.cnlive.com/api/?functionId=pageData&params=%7B%22appid%22%3A%22movie%22%2C%22plat%22%3A%22a%22%2C%22pageType%22%3A%22index%22%2C%22pageUUID%22%3A%22fe5cd895-9e5e-11e5-9eb6-c7d8a7a18cc4%22%2C%22version%22%3A509%7D
// 申请表头信息
-(void)requestHeadData{
    
    [self.headArray removeAllObjects];
    
    [NetWorkRequestManager requestWithType:Get URLString:@"http://cms.phonemovie.cnlive.com/api/?functionId=pageData&params={\"appid\":\"movie\",\"plat\":\"a\",\"pageType\":\"index\",\"pageUUID\":\"fe5cd895-9e5e-11e5-9eb6-c7d8a7a18cc4\",\"version\":509}" parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
       
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dataDic);
        NSArray * array = [dataDic objectForKey:@"banner"];
//        NSLog(@"%@",array);
        for (NSDictionary * dic in array) {
            HeadMovieModel * head = [[HeadMovieModel alloc] init];
            [head setValuesForKeysWithDictionary:dic];
            [self.headArray addObject:head];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray * arrayImage = [NSMutableArray array];
            NSMutableArray * arrayDescribe = [NSMutableArray array];
            for (HeadMovieModel * head in self.headArray) {
                [arrayImage addObject:head.img];
                [arrayDescribe addObject:head.title];
            }
            
            UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3 + self.view.bounds.size.height / 15)];
            
            
            XRCarouselView * carousel = [XRCarouselView carouselViewWithImageArray:arrayImage describeArray:arrayDescribe];
            carousel.pageControl.hidden = YES;
            carousel.delegate = self;
            carousel.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3);
            
            [backView addSubview:carousel];
            
            
            // 字体颜色
//            self.topView.selectButtonTitleColor = [UIColor colorWithRed:90/255.0 green:144/255.0 blue:206/255.0 alpha:1];
            self.topView.selectButtonTitleColor = [UIColor redColor];
            
            [self.topView setTitleButton:@[@"正在热映",@"即将上映"]];
            for (UIButton * button in self.topView.buttonArray) {
                [button addTarget:self action:@selector(reflashData:) forControlEvents:UIControlEventTouchUpInside];
            }
            // 背景颜色
//            [self.topView setTitleButtonColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]];
            [self.topView setTitleButtonColor:[UIColor whiteColor]];
        
            [backView addSubview:self.topView];
            
            
            self.tableView.tableHeaderView = backView;
            
            
            
            
            
            
            
        });
        
        
        
    } error:^(NSError *error) {
        
    }];
}



// 申请 热映数据
// 申请 数据 (附上 Locationid 参数)
-(void)requestHotData:(NSInteger)identifier{
    
//    http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=490
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=%ld",identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        // 申请数据完毕
        [self.hotArray removeAllObjects];
        
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
    
//    NSLog(@"%@",[NSString stringWithFormat: @"http://api.m.mtime.cn/Movie/MovieComingNew.api?locationId=%ld",identifier]);
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
    
//    location.delegate = self;
    
    [self.navigationController pushViewController:location animated:YES];
    
    
}

#pragma mark- 代理传值 ( 实现传城市信息的 功能能)
-(void)passLocationCity:(CityMessage *)city{
//    NSLog(@"%@",city.name);
    
    // 做响应跟新数据的操作
    
    self.navigationItem.leftBarButtonItem.title = city.name;
    
    
    [self.hotArray removeAllObjects];
    [self requestHotData:city.identifier];
    [self requestFutureData:city.identifier];

    
    
    
}

-(void)listenerPassCity{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(passCity:) name:@"kNotificationCity" object:nil];
}


-(void)passCity:(NSNotification *)notify{
    
    // 取得广播内容
    
    NSDictionary *dic = [notify userInfo];
    
    NSString * cityName = [dic objectForKey:@"cityName"];
    
    NSString * cityID = [dic objectForKey:@"cityID"];
    
    // 做响应跟新数据的操作
    
    self.navigationItem.leftBarButtonItem.title = cityName;
    
    
   
    [self requestHotData:[cityID integerValue]];
    [self requestFutureData:[cityID integerValue]];
}












#pragma mark- 接受 刚获取的地点通知
-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"kNotificationLocation" object:nil];
}


- (void)recvBcast:(NSNotification *)notify
{

    // 取得广播内容

    NSDictionary *dict = [notify userInfo];

    NSString * cityName = [dict objectForKey:@"TureLocation"];
    
    // 要注意返回的 词
    // 根据通知回来的值搜索是否有值
    
    NSString * string = [cityName substringFromIndex:(cityName.length - 1)];
    
    if ([string isEqualToString:@"市"]) {
        cityName = [cityName substringToIndex:(cityName.length - 1)];
    }
    
    
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
                    [self requestFutureData:city.identifier];
                    
                }];
                [alert addAction:action2];
                
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
            }else{
                
                
            }
            
        }
     
    }
   
    
}

#pragma mark-  点击了 预告片的按钮
-(void)listenerForcast{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcastForcast:) name:@"kNotificationForcast" object:nil];
}

-(void)recvBcastForcast:(NSNotification *)notify{
    
    NSDictionary * dic = notify.userInfo;
    
    NSLog(@"%@",dic);
    
    NSArray * array = [dic objectForKey:@"vedio"];
    
    NSString * imageString = [dic objectForKey:@"img"];
    
    NSString * nameString = [dic objectForKey:@"name"];
    
//    NSLog(@"%@",array);
    
    VideoListViewController * video = [[VideoListViewController alloc] init];
    
    video.videoArray = array;
    video.imageStr = imageString;
    video.nameStr = nameString;
    
    [self.navigationController pushViewController:video animated:YES];
    
    
    
}


#pragma mark- 点击了那个最搜关注的电影
-(void)passCityIdentifier:(FutureMovieModel *)future{
    
    
    
    MovieDetailViewController * movie = [[MovieDetailViewController alloc] init];
    //    self.tabBarController.hidesBottomBarWhenPushed = YES;
    //    [(TabBarViewController *)self.tabBarController hidenBottomView];
    
    // 传入 当前城市 ID
    NSInteger cityID = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultLocationID"];
    
    movie.cityID = cityID;
//    NSLog(@"%ld",cityID);


    movie.movieID = future.identifier;
    movie.future = future;
 
    [self.navigationController pushViewController:movie animated:YES];
    
    
    

    
}

#pragma mark- 点击了那个 预告片按钮
-(void)passFuturevedio:(FutureMovieModel *)future{
    
    VideoListViewController * video = [[VideoListViewController alloc] init];
    
    video.videoArray = future.videoArray;
    
    video.imageStr = future.image;
    
    video.nameStr = future.title;
    
    [self.navigationController pushViewController:video animated:YES];
    
    
}


#pragma mark- 点击那个轮播图
-(void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index{
    
    HeadMovieModel * head = [self.headArray objectAtIndex:index];
    
    NSLog(@"%@",head.title);
    NSLog(@"%@",head.url);
    
    
    MovieWebViewController * movie = [[MovieWebViewController alloc] init];
    movie.head = head;
    
    [self.navigationController pushViewController:movie animated:YES];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

