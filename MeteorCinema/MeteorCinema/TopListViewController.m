//
//  NewsViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TopListViewController.h"
#import "NetWorkRequestManager.h"
#import "TopListModel.h"
#import "HeadModel.h"
#import "UIImageView+WebCache.h"
#import "NewsTableViewCell.h"
#import "NewsTableViewCell2.h"
#import "DetailViewController.h"
#import "TimeTop100ViewController.h"
#import "WorldViewController.h"
#import "MJRefresh.h"
@interface TopListViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TopListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tab reloadData];
    //下拉刷新页面
    [self.tab addHeaderWithTarget:self action:@selector(headerRefreshing) ];
    [self.tab headerBeginRefreshing];
    //上拉加载更多数据
    [self.tab addFooterWithTarget:self action:@selector(footerRefreshingText)];
}
#pragma mark - 下拉刷新
-(void)headerRefreshing{
    [self.dataArray removeAllObjects];    
    pageIndex = 1;
    [self loadData];
    [self loadImage];
    [self.tab reloadData];
    [self.tab headerEndRefreshing];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

}
#pragma mark - 上拉加载
-(void)footerRefreshingText{
    pageIndex++;
    [self loadData];
    [self loadImage];
    [self.tab footerEndRefreshing];
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 第一个 tableview 数据
-(void)loadData{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListOfAll.api?pageIndex=%ld",(long)pageIndex] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"topLists"];
        for (NSDictionary *dic0 in array) {
            TopListModel *model = [[TopListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic0];
            model.identifier = [dic0[@"id"]integerValue];
                        [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tab reloadData];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - 第一个tableView顶部view
-(void)loadImage{
    [NetWorkRequestManager requestWithType:Get URLString:BigImage_URL parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic0 = dic[@"topList"];
        HeadModel *headModel = [[HeadModel alloc]init];
        [headModel setValuesForKeysWithDictionary:dic0];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 300)];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, UIScreenWidth, 210);
            [button addTarget:self action:@selector(doBigBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = [dic[@"topList"][@"id"]integerValue];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, UIScreenWidth, 30)];
            label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [button addSubview:label];
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 210, UIScreenWidth/3, 90);
            [leftButton setTitle:@"时光Top100" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
            [leftButton addTarget:self action:@selector(doBtn:) forControlEvents:UIControlEventTouchUpInside];
            leftButton.tag = 2065;
            UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            middleButton.frame = CGRectMake(UIScreenWidth/3,210, UIScreenWidth/3, 90);
            [middleButton setTitle:@"华语Top100" forState:UIControlStateNormal];
            [middleButton setTitleColor:[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]forState:UIControlStateNormal];
            middleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
            [middleButton addTarget:self action:@selector(doBtn:) forControlEvents:UIControlEventTouchUpInside];
            middleButton.tag = 2066;
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(UIScreenWidth*2/3, 210, UIScreenWidth/3, 90);
            [rightButton setTitle:@"全球票房榜" forState:UIControlStateNormal];
            [rightButton setTitleColor:[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1] forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"BoxOffice-1"] forState:UIControlStateNormal];
            rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
            [rightButton addTarget:self action:@selector(doRightBtn) forControlEvents:UIControlEventTouchUpInside];
            UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 299.5, UIScreenWidth, 0.5)];
            horizontal.backgroundColor = [UIColor lightGrayColor];
            [views addSubview:horizontal];
            [views addSubview:button];
            [views addSubview:leftButton];
            [views addSubview:middleButton];
            [views addSubview:rightButton];
            self.tab.tableHeaderView = views;
            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headModel.imageUrl]]] forState:UIControlStateNormal];
            label.text = headModel.title;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:16];
        });
        
    } error:^(NSError *error) {
        
    }];
}
-(void)doBigBtn:(UIButton *)btn{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=1&topListId=%ld",(long)btn.tag] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            TimeTop100ViewController *top100 = [[TimeTop100ViewController alloc]init];
            top100.identifier = btn.tag;
            top100.itemTitle = dic[@"topList"][@"name"];
            top100.oldSummary = dic[@"topList"][@"summary"];
            top100.image = @"http://img31.mtime.cn/mg/2016/05/02/171346.87271987.jpg";
            [self.navigationController pushViewController:top100 animated:YES];
        });
    } error:^(NSError *error) {
        
    }];

}

#pragma mark - leftbtton和 middleBtn执行方法
-(void)doBtn:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=%ld&locationId=%7B2%7D"
,(long)btn.tag] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            TimeTop100ViewController *top100 = [[TimeTop100ViewController alloc]init];
            top100.index = btn.tag;
            top100.itemTitle = dic[@"topList"][@"name"];
            top100.oldSummary = dic[@"topList"][@"summary"];
            top100.image = @"http://img.taopic.com/uploads/allimg/140507/240388-14050H1515087.jpg";
            [self.navigationController pushViewController:top100 animated:YES];
        });
    } error:^(NSError *error) {
        
    }];

//    TimeTop100ViewController *top100 = [[TimeTop100ViewController alloc]init];
//    top100.index = btn.tag;
//    top100.button.hidden = YES;
//    [self.navigationController pushViewController:top100 animated:YES];
}
#pragma mark - rightbutton执行方法
-(void)doRightBtn{
    WorldViewController *worldBox = [[WorldViewController alloc]init];
    [self.navigationController pushViewController:worldBox animated:YES];
}
#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//////////
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
////////
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    TopListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.topListNameCn;
    cell.detailTextLabel.text = model.summary;
    cell.detailTextLabel.numberOfLines = 3;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TopListModel *model = self.dataArray[indexPath.row];
    TimeTop100ViewController *top100 = [[TimeTop100ViewController alloc]init];
    top100.identifier = model.identifier;
    top100.itemTitle = model.topListNameCn;
    top100.oldSummary = model.summary;
    top100.image = @"http://img.taopic.com/uploads/allimg/140507/240388-14050H1515087.jpg";
    [self.navigationController pushViewController:top100 animated:YES];
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
