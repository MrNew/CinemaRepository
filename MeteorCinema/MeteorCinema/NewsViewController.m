//
//  NewsViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsViewController.h"
#import "NetWorkRequestManager.h"
#import "NewsModel.h"
#import "HeadModel.h"
#import "UIImageView+WebCache.h"
#import "NewsTableViewCell.h"
#import "NewsTableViewCell2.h"
#import "DetailViewController.h"
#import "WorldViewController.h"
#import "ChinaBoxOfficeViewController.h"
#import "PicScrollViewController.h"
#import "MJRefresh.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *imageUrl;
@end

@implementation NewsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    //下拉刷新页面
    [self.tab addHeaderWithTarget:self action:@selector(headerRefreshing) ];
    [self.tab headerBeginRefreshing];
    //上拉加载更多数据
    [self.tab addFooterWithTarget:self action:@selector(footerRefreshingText)];
}
#pragma mark - 下拉刷新
-(void)headerRefreshing{
    [self.dataArray removeAllObjects];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;

    pageIndex = 1;
    [self loadData1];
    [self loadImage1];
    [self.tab reloadData];
    [self.tab headerEndRefreshing];
}
#pragma mark - 上拉加载
-(void)footerRefreshingText{
    pageIndex++;
    [self loadData1];
    [self loadImage1];
    [self.tab footerEndRefreshing];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - 第一个 tableview 数据
-(void)loadData1{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/News/NewsList.api?pageIndex=%ld",(long)pageIndex] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"newsList"];
        for (NSDictionary *dic0 in array) {
            NewsModel *newsModel = [[NewsModel alloc]init];
            newsModel.title = dic0[@"title"];
            newsModel.title2 = dic0[@"title2"];
            newsModel.image = dic0[@"image"];
            newsModel.publishTime = [dic0[@"publishTime"] integerValue];
            newsModel.commentCount = [dic0[@"commentCount"]integerValue];
            newsModel.identifier = [dic0[@"id"]integerValue];
            newsModel.imageArray = dic0[@"images"];
            newsModel.image1 = dic0[@"images"][0][@"url1"];
            newsModel.image2 = dic0[@"images"][1][@"url1"];
            newsModel.image3 = [dic0[@"images"] lastObject][@"url1"];
            [self.dataArray addObject:newsModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

            [self.tab reloadData];
            
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - 第一个tableView顶部view
-(void)loadImage1{
    [NetWorkRequestManager requestWithType:Get URLString:BigImage_URL parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic0 = dic[@"news"];
        HeadModel *headModel = [[HeadModel alloc]init];
        [headModel setValuesForKeysWithDictionary:dic0];
        dispatch_async(dispatch_get_main_queue(), ^{
          
            UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 270)];
            views.backgroundColor = [UIColor whiteColor];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, UIScreenWidth, 210);
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, UIScreenWidth, 30)];
            label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [button addSubview:label];
            [button addTarget:self action:@selector(doBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = [dic0[@"newsID"]integerValue];
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 210, UIScreenWidth/2, 60);
            [leftButton setTitle:@"  内地票房榜" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor colorWithRed:233/255.0 green:80/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
            [leftButton setImage:[UIImage imageNamed:@"票务"] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:16];
            [leftButton addTarget:self action:@selector(doLeftButton) forControlEvents:UIControlEventTouchUpInside];
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(UIScreenWidth/2, 210, UIScreenWidth/2, 60);
            [rightButton setTitle:@"  全球票房榜" forState:UIControlStateNormal];
            
            [rightButton setTitleColor:[UIColor colorWithRed:156/255.0 green:88/255.0 blue:182/255.0 alpha:1] forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"票务-1"] forState:UIControlStateNormal];
            rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:16];
            [rightButton addTarget:self action:@selector(doRightButton:) forControlEvents:UIControlEventTouchUpInside];
            UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(UIScreenWidth/2-0.25, 210, 0.5, 60)];
            vertical.backgroundColor = [UIColor lightGrayColor];
            UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 269.5, UIScreenWidth, 0.5)];
            horizontal.backgroundColor = [UIColor lightGrayColor];
            [views addSubview:horizontal];
            [views addSubview:vertical];
            [views addSubview:button];
            [views addSubview:leftButton];
            [views addSubview:rightButton];
            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headModel.imageUrl]]] forState:UIControlStateNormal];
            label.text = headModel.title;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:16];
            self.tab.tableHeaderView = views;
            [self.tab reloadData];

        });
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - doBtn 执行方法
-(void)doBtn:(UIButton *)btn{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/News/Detail.api?newsId=%ld",(long)btn.tag] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            DetailViewController *detailVC = [[DetailViewController alloc]init];
            detailVC.itemTitle = dic[@"title"];
            detailVC.title2 = dic[@"title2"];
            detailVC.commentCount = [dic[@"commentCount"] integerValue];
            detailVC.image = @"http://tiandaoedu.com/uploads/100309/443_135959_1.jpg";
            detailVC.detailAPI = [NSString stringWithFormat:@"http://api.m.mtime.cn/News/Detail.api?newsId=%ld",(long)btn.tag];
            detailVC.identifier = btn.tag;
            [self.navigationController pushViewController:detailVC animated:YES];
        });
    } error:^(NSError *error) {
        
    }];

}
-(void)doLeftButton{
    ChinaBoxOfficeViewController *chinaVC = [[ChinaBoxOfficeViewController alloc]init];
    [self.navigationController pushViewController:chinaVC animated:YES];
}
-(void)doRightButton:(UIButton *)btn{
    WorldViewController *worldVC = [[WorldViewController alloc]init];
    [self.navigationController pushViewController:worldVC animated:YES];
}
#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//////////
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newsModel = [self.dataArray objectAtIndex:indexPath.row];
    if (newsModel.image1 == nil) {
        return 105.0;
    }else{
        return 140;
    }
}
////////
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    static NSString *identifier1 = @"cell1";
    NewsModel *newsModel = [self.dataArray objectAtIndex:indexPath.row];
    if (newsModel.image1 == nil) {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil].lastObject;
        }
        cell.title.text = newsModel.title;
        cell.title2.text = newsModel.title2;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:newsModel.publishTime];
        NSString *time = [[NSString stringWithFormat:@"%@",date] substringWithRange:NSMakeRange(5, 11)];
        cell.time.text = time;
        cell.commend.text = [@"评论 " stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)newsModel.commentCount]];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:newsModel.image]];
        return cell;
    }else{
        NewsTableViewCell2 *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell2" owner:self options:nil].lastObject;
        }
        [cell1.image1 sd_setImageWithURL:[NSURL URLWithString:newsModel.image1]];
        [cell1.image2 sd_setImageWithURL:[NSURL URLWithString:newsModel.image2]];
        [cell1.image3 sd_setImageWithURL:[NSURL URLWithString:newsModel.image3]];
        cell1.title.text = newsModel.title;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:newsModel.publishTime];
        NSString *time = [[NSString stringWithFormat:@"%@",date] substringWithRange:NSMakeRange(5, 11)];
        cell1.time.text = time;
        cell1.commend.text = [@"评论 " stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)newsModel.commentCount]];
        return cell1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataArray[indexPath.row];
    if (model.image1 == nil) {
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.detailAPI = [NSString stringWithFormat:@"http://api.m.mtime.cn/News/Detail.api?newsId=%ld",(long)model.identifier];
    detailVC.itemTitle = model.title;
        detailVC.image = model.image;
        detailVC.title2 = model.title2;
        detailVC.identifier = model.identifier;
        detailVC.commentCount = model.commentCount;
    [self.navigationController pushViewController:detailVC animated:YES];
}
    else{
        PicScrollViewController *picScroll = [[PicScrollViewController alloc]init];
        picScroll.itemTitle = model.title;
        picScroll.title2 = model.title2;
        picScroll.image = model.image;
        picScroll.picAPI = [NSString stringWithFormat:@"http://api.m.mtime.cn/News/Detail.api?newsId=%ld",(long)model.identifier];
        picScroll.identifier = model.identifier;
        picScroll.commentCount = model.commentCount;
        [self.navigationController pushViewController:picScroll animated:YES];
    }
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
