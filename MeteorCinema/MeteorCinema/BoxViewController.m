//
//  BoxTableViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "BoxViewController.h"
#import "BoxOfficeTableViewCell.h"
#import "NetWorkRequestManager.h"
#import "BoxOfficeModel.h"
#import "UIImageView+WebCache.h"
@interface BoxViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *timeText;

@end

@implementation BoxViewController
#pragma mark - 写一个单例方法创建控制器
+(instancetype)initWithString:(NSString *)str{
        BoxViewController *box = [[BoxViewController alloc]init];
    box.str = str;
    return box;
}
#pragma mark - 懒加载数组
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    //创建票房统计时间的 label
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.3, UIScreenWidth, 22.4)];
    _timeLabel.textColor  = [UIColor lightGrayColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    UILabel *horizon1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.3)];
    UILabel *horizon2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 22.7, UIScreenWidth, 0.3)];
    horizon1.backgroundColor = [UIColor lightGrayColor];
    horizon2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:horizon1];
    [self.view addSubview:horizon2];
    [self.view addSubview:_timeLabel];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 23, UIScreenWidth, self.view.frame.size.height - 23 - 64 -35) style:UITableViewStylePlain];
    self.tableView.rowHeight = 120;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - 下载网络数据
-(void)loadData{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=%@&locationId=365",self.str] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.timeText = dic[@"topList"][@"summary"];
        NSLog(@"=%@",self.timeText);

        NSArray *array = dic[@"movies"];
        for (NSDictionary *dico in array) {
            BoxOfficeModel *model = [[BoxOfficeModel alloc]init];
            [model setValuesForKeysWithDictionary:dico];
            NSLog(@"%@",model.weekBoxOffice);

            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeLabel.text = self.timeText;
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    BoxOfficeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BoxOfficeTableViewCell" owner:self options:nil]lastObject];
    }
    BoxOfficeModel *model = self.dataArray[indexPath.row];
    [cell.postImageV sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    cell.rating.text = [NSString stringWithFormat:@"%.1f",model.rating];
    
    cell.rankNum.text = [NSString stringWithFormat:@"%ld",model.rankNum];
    cell.rankNum.layer.cornerRadius = 10;
    cell.rankNum.layer.masksToBounds = YES;
    cell.name.text = model.name;
    cell.nameEn.text = model.nameEn;
    NSString *str = [model.weekBoxOffice stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cell.weekBoxOffice.text = str;
    cell.totalBoxOffice.text = model.totalBoxOffice;
    cell.buy.layer.cornerRadius = 12;
    cell.buy.layer.masksToBounds = YES;
    return cell;
}

////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
