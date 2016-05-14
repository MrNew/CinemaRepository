//
//  NewsViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "ReviewViewController.h"
#import "NetWorkRequestManager.h"
#import "ReviewModel.h"
#import "HeadModel.h"
#import "UIImageView+WebCache.h"
#import "ReviewTableViewCell.h"
#import "ReviewDetailViewController.h"
@interface ReviewViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *title2;
@property(nonatomic,strong)NSString *image;
@end

@implementation ReviewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData1];
    [self loadImage1];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.contentInset = UIEdgeInsetsMake(210, 0, 0, 0);
    [self.tab reloadData];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - 第一个 tableview 数据
-(void)loadData1{
    [NetWorkRequestManager requestWithType:Get URLString:Review_URL parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in array) {
            ReviewModel *model = [[ReviewModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            model.movieName = dic[@"relatedObj"][@"title"];
            model.image = dic[@"relatedObj"][@"image"];
            model.movieRating = dic[@"relatedObj"][@"rating"];
            model.identifier = [dic[@"id"]integerValue];
            [self.dataArray addObject:model];
        }
        NSLog(@"hahaha===%ld",self.dataArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tab reloadData];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - 第一个tableView顶部view
-(void)loadImage1{
    [NetWorkRequestManager requestWithType:Get URLString:BigImage_URL parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic0 = dic[@"review"];
        self.itemTitle = dic0[@"title"];
        self.title2 = dic0[@"movieName"];
        self.image = dic0[@"imageUrl"];
        HeadModel *headModel = [[HeadModel alloc]init];
        [headModel setValuesForKeysWithDictionary:dic0];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, -210, UIScreenWidth, 210);
            button.tag = [dic[@"review"][@"reviewID"]integerValue];
            UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, UIScreenWidth, 5)];
            label0.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 165, UIScreenWidth, 20)];
            label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 185, UIScreenWidth, 20)];
            label2.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 205, UIScreenWidth, 5)];
            label3.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
            [button addSubview:label0];
            [button addSubview:label];
            [button addSubview:label2];
            [button addSubview:label3];
            [button addTarget:self action:@selector(doBtn:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 112, 60, 90)];
            imageV.layer.borderColor = [UIColor whiteColor].CGColor;
            imageV.layer.borderWidth = 1;
            [button addSubview:imageV];
            [self.tab insertSubview:button atIndex:0];
            [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headModel.imageUrl]]] forState:UIControlStateNormal];
            label.text = [@"                        " stringByAppendingString:headModel.movieName];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:16];
            label2.text = [@"                         “" stringByAppendingString:headModel.title];
            label2.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
            label2.font = [UIFont systemFontOfSize:13];

            [imageV sd_setImageWithURL:[NSURL URLWithString:headModel.posterUrl]];
        });
        
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - button
-(void)doBtn:(UIButton *)btn{
    ReviewDetailViewController *detailVC = [[ReviewDetailViewController alloc]init];
    detailVC.itemTitle = self.itemTitle;
    detailVC.image = self.image;
    detailVC.summary = self.title2;
    detailVC.identifier = btn.tag;
    [self.navigationController pushViewController:detailVC animated:YES];

}
#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//////////
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 126;
}
////////
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ReviewTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    ReviewModel *model = self.dataArray[indexPath.row];
    cell.title.text = model.title;
    cell.summary.text = model.summary;
    [cell.movieImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.userImage.layer.cornerRadius = 12.0;
    cell.userImage.layer.masksToBounds = YES;
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:model.userImage]];
    cell.username.text = [model.nickname stringByAppendingString:@" - 评"];
    cell.moviename.text = [[@"《" stringByAppendingString:model.movieName] stringByAppendingString:@"》"];
    cell.userRating.text = model.rating;
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReviewModel *model = self.dataArray[indexPath.row];
    ReviewDetailViewController *detailVC = [[ReviewDetailViewController alloc]init];
    detailVC.identifier = model.identifier;
    detailVC.itemTitle = model.title;
    detailVC.summary = model.summary;
    detailVC.image = model.image;
    [self.navigationController pushViewController:detailVC animated:YES];
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
