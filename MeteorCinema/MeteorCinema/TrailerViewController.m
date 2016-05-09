//
//  NewsViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TrailerViewController.h"
#import "NetWorkRequestManager.h"
#import "TrailerModel.h"
#import "HeadModel.h"
#import "UIImageView+WebCache.h"
#import "TrailerTableViewCell.h"
#import "DetailViewController.h"
@interface TrailerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *pageIndex;
}
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TrailerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadImage];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64) style:UITableViewStylePlain];
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
-(void)loadData{
    [NetWorkRequestManager requestWithType:Get URLString:TrailerList_URL parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"trailers"];
        for (NSDictionary *dic0 in array) {
            TrailerModel *trailersModel = [[TrailerModel alloc]init];
            [trailersModel setValuesForKeysWithDictionary:dic0];
            [self.dataArray addObject:trailersModel];
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
        NSDictionary *dic0 = dic[@"trailer"];
        HeadModel *headModel = [[HeadModel alloc]init];
        [headModel setValuesForKeysWithDictionary:dic0];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, -210, UIScreenWidth, 210);
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, UIScreenWidth, 30)];
            label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [button addSubview:label];
            [self.tab insertSubview:button atIndex:0];
            if ([headModel.imageUrl  isEqual: @""]) {
                [button setImage:[UIImage imageNamed:@"1112.jpg"] forState:UIControlStateNormal];

            }else{
                [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headModel.imageUrl]]] forState:UIControlStateNormal];
            }
            label.text = headModel.title;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:16];
        });
        
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//////////
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
////////
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    TrailerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TrailerTableViewCell" owner:self options:nil]lastObject];
    }
    TrailerModel *model = self.dataArray[indexPath.row];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.coverImg]];
    cell.title.text = model.movieName;
    cell.detail.text = model.summary;
    return cell;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TrailerModel *model = self.dataArray[indexPath.row];

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
