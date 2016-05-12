//
//  CinemaViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CinemaViewController.h"
#import "NetWorkRequestManager.h"
#import "CinemaTableViewCell.h"
#import "Cinema.h"
#import "SecondViewController.h"
#import "MovIs.h"
#import "UIImageView+WebCache.h"
#import "LocationViewController.h"

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define READLIST_URL @"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=365"

//@"http://api.m.mtime.cn/Cinema/Detail.api?cinemaId=%ld


@interface CinemaViewController ()<UITableViewDataSource,UITableViewDelegate,SecondViewControllerDelegate,LocationViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *oneImageArray;
@property(nonatomic,strong)UITableView *CinemaTabelView;
@property(nonatomic,strong)NSMutableArray *characteristicArray;
@property(nonatomic,assign)NSInteger cinemaId;
@property(nonatomic,strong)UIButton *musicBtn;
@end

@implementation CinemaViewController

//懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        //一定要用self.listArray 不能用_listArray
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    self.navigationItem.title = @"影院";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
        _characteristicArray = [NSMutableArray array];


//-----------------------UItablelView-------------------//
    
    
    _CinemaTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    //_tab.contentSize = CGSizeMake(200, 0);
    
    _CinemaTabelView.delegate = self;
    _CinemaTabelView.dataSource = self;
    
  
    [self.view addSubview:_CinemaTabelView];
    
    [self requestData];
    [self shareleftBarButton];
    

  


}

#pragma -mark 右上角城市选择
-(void)shareleftBarButton
{
    //导航栏上面的分享的item
   _musicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _musicBtn.frame = CGRectMake(0, 0, 80, 40);
    //    [musicBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_musicBtn setTitle:@"广州" forState:UIControlStateNormal];
  
//  musicBtn.font = [UIFont boldSystemFontOfSize:15];
    [_musicBtn addTarget:self action:@selector(handlePresentCurrentMusicAction) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *currentMusicBtn = [[UIBarButtonItem alloc] initWithCustomView:_musicBtn];
    
    self.navigationItem.leftBarButtonItem = currentMusicBtn;
}

//城市选择
-(void)handlePresentCurrentMusicAction{

    LocationViewController * location = [[LocationViewController alloc] init];
    
    location.delegate = self;
    
    [self.navigationController pushViewController:location animated:YES];

}



-(void)passLocationCity:(CityMessage *)city
{
    

    [self.dataArray removeAllObjects];

    self.cinemaId = city.identifier;

    if (city.name == nil) {
        [self shareleftBarButton];
    }else{
        [_musicBtn setTitle:city.name forState:UIControlStateNormal];
    }
   
    
    
    
    // 先判断是否进入 算地点界面
   
    
    
    [self requestData];
}


//数据接口
-(void)requestData
{
    
    
    
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=%ld",self.cinemaId] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        
        for (NSDictionary *dic in array) {
            Cinema *send = [[Cinema alloc] init];
            [send setValuesForKeysWithDictionary:dic];
            

            [_dataArray addObject:send];
            
            NSDictionary *dic2 = [dic objectForKey:@"feature"];
           // NSLog(@"里面的字典=%@",dic2);
            
            // 1.便利所有的key
            for (NSString *strr in dic2.allKeys) {
                // 2.根据key 取dic2相应值
            NSString * value = [dic2 objectForKey:strr];
                
                // [strr boolValue];//转换成布尔类型
                // 3.当布尔值等于1时放进数组里
                if ([value boolValue]) {
                
                [self.characteristicArray addObject:strr];
                  //  NSLog(@"所有的值=%@",self.characteristicArray);
  
                }
            }
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_CinemaTabelView reloadData];
            
        });
        
        
        // [self performSelectorOnMainThread:@selector(doMain) withObject:nil waitUntilDone:YES];

        
    } error:^(NSError *error) {
         NSLog(@"error = %@",error);
    }];

    
}




//刷新
//-(void)doMain
//{
//   // [_CinemaTabelView reloadData];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;

    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell";
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell= [[CinemaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
  //  NSLog(@"%ld",_dataArray.count);
    Cinema *send = [_dataArray objectAtIndex:indexPath.row];


    cell.TitleLabel.text = send.cinameName;
    cell.addressLabel.text = send.address;
    
    NSString *restric = [NSString stringWithFormat:@"￥%@",send.minPrice];
    if (restric.length>3) {
        restric = [restric substringToIndex:3];//截取掉下标2之后的字符串
        cell.minPriceLabel.text = restric;
        }
    
    NSString * str = send.cinemaId;
    self.cinemaId = [str intValue];
    
    //小图标
//    NSString *la1   = [_characteristicArray objectAtIndex:2];
//    NSString *la2 =  [la1 substringFromIndex:3];
//    cell.Label1.text = la2;
//
//    
//    NSString *la3 = [_characteristicArray objectAtIndex:3];
//    NSString *la4 =  [la3 substringFromIndex:3];
//    cell.Label2.text = la4;
//    
//    
//    NSString *la5 = [_characteristicArray objectAtIndex:4];
//    NSString *la6 =  [la5 substringFromIndex:3];
//    cell.Label3.text = la6;
//    
//    
//    NSString *la7 = [_characteristicArray objectAtIndex:1];
//    if (la7.length>10) {
//    NSString *la8 =  [la7 substringFromIndex:10];
//    cell.Label4.text = la8;
//    }
  
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *sen = [[SecondViewController alloc] init];
    sen.delegate = self;
    sen.cinamea = [_dataArray objectAtIndex:indexPath.row];
    sen.cinemaIdtwo = self.cinemaId;
    [self.navigationController pushViewController:sen animated:YES];

    
    
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
