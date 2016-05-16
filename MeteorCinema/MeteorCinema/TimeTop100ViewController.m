//
//  TimeTop100ViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/9.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TimeTop100ViewController.h"
#import "Time100TableViewCell.h"
#import "BoxOfficeModel.h"
#import "NetWorkRequestManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "showView.h"
#import "NewsDataBaseUtil.h"

@interface TimeTop100ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *summaryLabel;
@property(nonatomic,assign)NSInteger pageCount;
@property(nonatomic,strong)showView *showView;
@end

@implementation TimeTop100ViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.rowHeight = 185;
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 180)];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 45)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:18];
    [content addSubview:self.nameLabel];
    //创建票房统计时间的 label
    self.summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, UIScreenWidth, 23)];
    _summaryLabel.textColor  = [UIColor darkGrayColor];
    _summaryLabel.font = [UIFont systemFontOfSize:13];
    [content addSubview:_summaryLabel];
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, 116)];
    pic.image = [UIImage imageNamed:@"11.jpg"];
    [content addSubview:pic];
    self.tab.tableHeaderView = content;
    //
    //下拉刷新页面
    [self.tab addHeaderWithTarget:self action:@selector(headerRefreshing) ];
    [self.tab headerBeginRefreshing];
    //上拉加载更多数据
    [self.tab addFooterWithTarget:self action:@selector(footerRefreshingText)];
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,32,32)];
    [_button setImage:[UIImage imageNamed:@"收藏"] forState: UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:_button];
    [_button addTarget:self action:@selector(collectItem:) forControlEvents:UIControlEventTouchUpInside];
    _showView = [[[NSBundle mainBundle]loadNibNamed:@"showView" owner:nil options:nil]lastObject];
    [self judgeCollect];
}
#pragma mark - 收藏执行方法
-(void)collectItem:(UIButton *)button{
    NSArray *array = [[NewsDataBaseUtil shareDataBase]selectTitle:self.itemTitle];
    if ([array count] == 0) {
        [[NewsDataBaseUtil shareDataBase]insertTitle:self.itemTitle title2:self.summary  image:self.image];
        _showView.label.text = @"已收藏";
    }else{
        [[NewsDataBaseUtil shareDataBase]deletewithTitle:self.itemTitle fromTable:@"collects"];
        _showView.label.text = @"已取消";
    }
    [self.view addSubview:_showView];
    [self judgeCollect];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disappear) userInfo:nil repeats:NO];
}
/////////
-(void)disappear
{
    [_showView removeFromSuperview];
}
/////////
-(void)judgeCollect
{
    NSArray *array = [[NewsDataBaseUtil shareDataBase]selectTitle:self.itemTitle];
    if ([array count] == 0) {
        [_button setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    }else{
        [_button setImage:[UIImage imageNamed:@"收藏(1)"] forState:UIControlStateNormal];
    }
}
#pragma mark - 下拉刷新
-(void)headerRefreshing{
    [self.dataArray removeAllObjects];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    pageIndex = 1;
    if (!self.identifier) {
        [self network];
    }
    else{
        [self detailNetwork];}
    [self.tab reloadData];
    [self.tab headerEndRefreshing];
}
#pragma mark - 上拉加载
-(void)footerRefreshingText{
    if (!self.identifier) {
        pageIndex++;

        [self network];
    }
    else{
        if (pageIndex < self.pageCount ) {
            NSLog(@"=======%ld",(long)self.pageCount);
            pageIndex++;
            [self detailNetwork];
            [self.tab reloadData];
        }
}
    [self.tab footerEndRefreshing];
}
-(void)network{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=%ld&pageSubAreaID=%ld&locationId=%7B2%7D",(long)pageIndex,(long)self.index] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.summary = dic[@"topList"][@"summary"];
        self.name = dic[@"topList"][@"name"];
        NSArray *array = dic[@"movies"];
        for (NSDictionary *dico in array) {
            BoxOfficeModel *model = [[BoxOfficeModel alloc]init];
            [model setValuesForKeysWithDictionary:dico];
            NSLog(@"%@",model.weekBoxOffice);
            [self.dataArray addObject:model];
        }
dispatch_async(dispatch_get_main_queue(), ^{
    
    self.nameLabel.text = [@"  " stringByAppendingString:self.name];
    
    self.summaryLabel.text = [@"   " stringByAppendingString:self.summary];
    [self.tab reloadData];
});
    } error:nil];
}
//////
-(void)detailNetwork{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=%ld&topListId=%ld",(long)pageIndex,(long)self.identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.summary = dic[@"topList"][@"summary"];
        self.name = dic[@"topList"][@"name"];
        self.pageCount = [dic[@"pageCount"]integerValue];

        NSArray *array = dic[@"movies"];
        for (NSDictionary *dico in array) {
            BoxOfficeModel *model = [[BoxOfficeModel alloc]init];
            [model setValuesForKeysWithDictionary:dico];
            NSLog(@"%@",model.weekBoxOffice);
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [@"  " stringByAppendingString:self.name];
            self.summaryLabel.text = [@"   " stringByAppendingString:self.summary];
            [self.tab reloadData];
        });
    } error:nil];

}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    Time100TableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[Time100TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    BoxOfficeModel *model = self.dataArray[indexPath.row];
    [cell.poster sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    cell.rating.text = [NSString stringWithFormat:@"%.1f",model.rating];
    
    cell.rank.text = [NSString stringWithFormat:@"%ld",(long)model.rankNum];
    cell.name.text = [model.name stringByAppendingString:@" "];
    cell.nameEn.text = model.nameEn;
    cell.director.text = [@"导演: " stringByAppendingString:model.director];
    cell.actor.text = [@"主演: " stringByAppendingString:model.actor];
    cell.releaseTime.text =[ [@"上映日期: " stringByAppendingString:model.releaseDate] stringByAppendingString:@" 美国"];
    cell.back.text = model.remark;
    return cell;
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
