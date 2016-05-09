//
//  SecondViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailedViewController.h"
#import "NetWorkRequestManager.h"
#import "UIImageView+WebCache.h"
#import "SecondTableViewCell.h"
#import "UIButton+WebCache.h"

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define READLIST_URL @"http://api.m.mtime.cn/Showtime/ShowtimeMovieAndDateListByCinema.api?cinemaId=2368"


@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,DetailedViewControllerDelegate>



@property(nonatomic,strong)UIScrollView *ScrollViewController;
@property(nonatomic,strong)UIScrollView *ScrollView;
//接收电影的图片的BUtton
@property(nonatomic,strong)UIButton *button;
//电影数组
@property(nonatomic,strong)NSMutableArray *SendcondDataArray;
//演播厅数组
@property(nonatomic,strong)NSMutableArray *studioDataArray;

@property(nonatomic,assign)NSInteger movieIdNumber; //电影ID

@property(nonatomic,strong)UITableView *SendcondTabelView;


@property(nonatomic,strong)UILabel *titiLabel;
@property(nonatomic,strong)UILabel *TimeLabel;
@property(nonatomic,strong)UILabel *classifyLabel;
@property(nonatomic,strong)UIImageView *imageV;



@end

@implementation SecondViewController

//懒加载
-(NSMutableArray *)SendcondDataArray
{
    if (!_SendcondDataArray) {
        //一定要用self.listArray 不能用_listArray
        self.SendcondDataArray = [NSMutableArray array];
    }
    return _SendcondDataArray;
}


//懒加载
-(NSMutableArray *)studioDataArray
{
    if (!_studioDataArray) {
        //一定要用self.listArray 不能用_listArray
        self.studioDataArray = [NSMutableArray array];
    }
    return _studioDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str = self.cinamea.cinemaId;
    
    self.cinemaIdtwo = [str intValue];
    
    // NSLog(@"我啦个操啦=%ld",self.cinemaIdtwo);
    
    
    
    _ScrollViewController = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _ScrollViewController.contentSize =CGSizeMake(ScreenWidth, ScreenHeight*2);
    // _ScrollViewController.pagingEnabled = YES;
    
    [self.view addSubview:_ScrollViewController];
    
    [self LastSendcondTabelView];
    [self titleandaddress];
    [self ScrollViewandImage];
    [self titiLabeltime];
    [self movierequestData];
    [self studiorequestData];
    
    
}

//标题和地址
-(void)titleandaddress
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    view.backgroundColor = [UIColor yellowColor];
    [_ScrollViewController addSubview:view];
    
    UILabel *titLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    titLabel.backgroundColor = [UIColor greenColor];
    titLabel.text = self.cinamea.cinameName;
    [view addSubview:titLabel];
    
    UILabel *addressLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    addressLabel.backgroundColor = [UIColor cyanColor];
    addressLabel.text = self.cinamea.address;
    [view addSubview:addressLabel];
    
    UILabel *arrow =[[UILabel alloc] initWithFrame:CGRectMake(320, 50, 50, 30)];
    arrow.backgroundColor = [UIColor orangeColor];
    arrow.text = @">>";
    [view addSubview:arrow];
    
    
    //创建点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBeautiful)];
    //控制手指个数
    tap.numberOfTouchesRequired = 1;
    
    //控制点击次数(隐藏操作)
    tap.numberOfTapsRequired = 1;
    
    
    //把手势添加到图片中
    [view addGestureRecognizer:tap];
    //开启交互
    view.userInteractionEnabled =YES;
}
//点击跳转
-(void)touchBeautiful
{
    DetailedViewController *detai = [[DetailedViewController alloc] init];
    detai.delegate = self;
    detai.cinemaIdNUM = self.cinemaIdtwo;
    [self.navigationController pushViewController:detai animated:YES];
}


//电影解析
-(void)movierequestData
{
    
    
    
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/ShowtimeMovieAndDateListByCinema.api?cinemaId=%ld&movieId=%ld",self.cinemaIdtwo,self.movieIdNumber] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //解析的实质 就一层层的剥离数据
        //   NSLog(@"%ld",array.count);
        NSArray *array = [dic objectForKey:@"movies"];
        
        for (NSDictionary *dic in array) {
            MovIs *movie = [[MovIs alloc] init];
            [movie setValuesForKeysWithDictionary:dic];
            
            
            [self.SendcondDataArray addObject:movie];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            for (MovIs *mo in self.SendcondDataArray) {
                _titiLabel.text = mo.title;
                _TimeLabel.text = mo.length ;
                _classifyLabel.text = mo.type;
                
                NSString *str = mo.movieId;
                
                self.movieIdNumber = [str intValue];
                
                
            }
            
            [self ScrollViewandImage];
            
            
            
        });
        
        
        // [self performSelectorOnMainThread:@selector(doMain) withObject:nil waitUntilDone:YES];
        
        
    } error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
    
}

//演播厅
-(void)studiorequestData
{
    [self.studioDataArray removeAllObjects];
    NSLog(@"%ld",self.movieIdNumber);
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/ShowTimesByCinemaMovieDate.api?cinemaId=%ld&movieId=%ld",self.cinemaIdtwo,self.movieIdNumber] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //解析的实质 就一层层的剥离数据
        //   NSLog(@"%ld",array.count);
        NSArray *array = [dic objectForKey:@"s"];
        //NSLog(@"%@",dic);
        
        for (NSDictionary *dic in array) {
            studio *stu = [[studio alloc] init];
            [stu setValuesForKeysWithDictionary:dic];
            
            
            [self.studioDataArray addObject:stu];
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self.SendcondTabelView reloadData];
            
            
        });
        
        
        // [self performSelectorOnMainThread:@selector(doMain) withObject:nil waitUntilDone:YES];
        
        
    } error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
    
}

-(void)ScrollViewandImage;

{
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, ScreenWidth, 160)];
    
    _ScrollView.backgroundColor = [UIColor purpleColor];
    
    _ScrollView.contentSize =CGSizeMake(ScreenWidth*3, 160);
    
    [_ScrollViewController addSubview:_ScrollView];
    
    
    for (int i = 0; i<self.SendcondDataArray.count; i++) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        MovIs *mo = self.SendcondDataArray[i];
        [_button sd_setBackgroundImageWithURL:[NSURL URLWithString:mo.img] forState:UIControlStateNormal placeholderImage:nil];
        
        
        _button.frame = CGRectMake((ScreenWidth/4-90)+(i*ScreenWidth/4), (49-30)/2, 90, 130);
        
        _button.tag = i+1;//self.view.tag默认是0,所以一般不从0开始
        
        //   button.backgroundColor = [UIColor greenColor];
        
        [_button addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchDown];
        
        //文字大小
        
        _button.titleLabel.font = [UIFont systemFontOfSize:10.0];
        
        //图标位置
        
        [_button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
        
        //调整文字在按钮中的位置
        
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, -35, 0)];
        
        _button.backgroundColor = [UIColor greenColor];
        
        [_ScrollView addSubview:_button];
        
        
    }
    
}

-(void)selectedItem:(UIButton *)button
{
    
    if (button.tag == 1) {
        
        NSLog(@"你点了第一个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        NSLog(@"%@",mo.movieId);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        NSString *str = mo.movieId;
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
    }else if (button.tag == 2){
        
        NSLog(@"你点了第二个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        
        NSString *str = mo.movieId;
        
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
    }else if (button.tag == 3){
        
        NSLog(@"你点了第三个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"电影ID=%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        
        NSString *str = mo.movieId;
        
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
    }else if (button.tag == 4){
        
        NSLog(@"你点了第四个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        NSString *str = mo.movieId;
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
        
    }else if (button.tag == 5){
        
        NSLog(@"你点了第五个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        
        NSString *str = mo.movieId;
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
    }else if (button.tag == 6){
        
        NSLog(@"你点了第六个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        NSString *str = mo.movieId;
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
        
    }else if (button.tag == 7){
        
        NSLog(@"你点了第七个");
        MovIs *mo = self.SendcondDataArray[button.tag - 1];
        NSLog(@"%@",mo.title);
        _titiLabel.text = mo.title;
        _TimeLabel.text = mo.length ;
        _classifyLabel.text = mo.type;
        
        NSString *str = mo.movieId;
        self.movieIdNumber = [str intValue];
        NSLog(@"电影ID=%ld",self.movieIdNumber);
        [self studiorequestData];
        //[_SendcondTabelView reloadData];
    }
}

-(void)titiLabeltime
{
    
    
    
    UIView *movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, ScreenWidth, 100)];
    movieView.backgroundColor = [UIColor cyanColor];
    [_ScrollViewController addSubview:movieView];
    
    
    _titiLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 300, 30)];
    _titiLabel.textAlignment = NSTextAlignmentCenter;//居中
    _titiLabel.backgroundColor = [UIColor greenColor];
    //    _titiLabel.text =self.titlee;
    [movieView addSubview:_titiLabel];
    
    _TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 70, 30)];
    //   _TimeLabel.text = self.length;
    _TimeLabel.backgroundColor = [UIColor orangeColor];
    [movieView addSubview:_TimeLabel];
    
    _classifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 50, 150, 30)];
    // _classifyLabel.text = self.type;
    _classifyLabel.backgroundColor = [UIColor yellowColor];
    [movieView addSubview:_classifyLabel];
    
    
}


//
-(void)LastSendcondTabelView
{
    _SendcondTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight-350, ScreenWidth, _ScrollViewController.frame.size.height)];
    
    _SendcondTabelView.delegate = self;
    _SendcondTabelView.dataSource = self;
    
    _SendcondTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _SendcondTabelView.scrollEnabled = NO;
    [_ScrollViewController addSubview:_SendcondTabelView];
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.studioDataArray.count;
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell";
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell= [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    /*
     @property(nonatomic,strong)UILabel *startTimeLabel;//开始时间
     @property(nonatomic,strong)UILabel *endTimeLabel;//结束时间
     @property(nonatomic,strong)UILabel *versionDescLabel;//2D
     @property(nonatomic,strong)UILabel *languageLabel;//中文
     @property(nonatomic,strong)UILabel *hallLabel;//几号厅
     @property(nonatomic,strong)UILabel *priceLabel;//价格
     @property(nonatomic,strong)UILabel *buyLabel;//购票
     */
    
    studio *studi = [_studioDataArray objectAtIndex:indexPath.row];
    
    
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:studi.startTime];
    NSString *studitime1 = [[NSString stringWithFormat:@"%@",date1] substringWithRange:NSMakeRange(5, 11)];
    cell.startTimeLabel.text = studitime1;
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:studi.endTime];
    NSString *studitime = [[NSString stringWithFormat:@"%@",date] substringWithRange:NSMakeRange(5, 11)];
    cell.endTimeLabel.text = studitime;
    
    
    
    NSString *restric3 = [NSString stringWithFormat:@"%@",studi.versionDesc];
    cell.versionDescLabel.text = restric3;
    cell.languageLabel.text = studi.language;
    cell.hallLabel.text = studi.hall;
    
    NSString *restric4 = [NSString stringWithFormat:@"%@",studi.price];
    cell.priceLabel.text = restric4;
    
    
    
    
    
    
    
    
    //    NSString * str = send.cinemaId;
    //
    //    self.cinemaId = [str intValue];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
}

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
