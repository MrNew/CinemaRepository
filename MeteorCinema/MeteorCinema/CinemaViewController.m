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

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define READLIST_URL @"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api"


@interface CinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *CinemaTabelView;
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

//-----------------------UItablelView-------------------//
    
    _CinemaTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64) style:UITableViewStylePlain];
    //_tab.contentSize = CGSizeMake(200, 0);
    
    _CinemaTabelView.delegate = self;
    _CinemaTabelView.dataSource = self;
    
  
    [self.view addSubview:_CinemaTabelView];
    
    [self requestData];
    


}


//数据接口
-(void)requestData
{
    [NetWorkRequestManager requestWithType:Get URLString:READLIST_URL parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //解析的实质 就一层层的剥离数据
        //   NSLog(@"%ld",array.count);
        
        for (NSDictionary *dic in array) {
            Cinema *send = [[Cinema alloc] init];
            [send setValuesForKeysWithDictionary:dic];
            //            send.cinameName = [dic objectForKey:@"cinameName"];
            //            send.address = [dic objectForKey:@"address"];
            //            send.minPrice = [dic objectForKey:@"minPrice"];
            
            [_dataArray addObject:send];
            
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
    cell.minPriceLabel.text = @"￥34";
    
//    cell.backgroundColor = [UIColor blackColor];
//    cell.alpha = 0.5;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *sen = [[SecondViewController alloc] init];
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
