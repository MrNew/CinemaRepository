//
//  NewsCommentViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsCommentViewController.h"
#import "NetWorkRequestManager.h"
#import "NewsCommentModel.h"
#import "UIImageView+WebCache.h"
#import "NewsCommentTableViewCell.h"
#import "Tool.h"
#import "NewsReplyTableViewCell.h"
#import "MJRefresh.h"
@interface NewsCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageIndex;
}

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *replyArray;
@end

@implementation NewsCommentViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tab reloadData];
    [self loadCommentData];
    
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
    [self loadCommentData];
    [self.tab reloadData];
    [self.tab headerEndRefreshing];
}
#pragma mark - 上拉加载
-(void)footerRefreshingText{
    pageIndex++;
    [self loadCommentData];
    [self.tab footerEndRefreshing];
}
#pragma mark 网络请求数据
-(void)loadCommentData{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/News/Comment.api?newsId=%ld&pageIndex=%ld",(long)self.identifier,(long)pageIndex] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in array) {
            if (dic[@"replyCount"] == 0) {
                NewsCommentModel *model = [[NewsCommentModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                model.isCell = 1;
                [self.dataArray addObject:model];
            }
            else{
                NewsCommentModel *model = [[NewsCommentModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                model.isCell = 1;
                [self.dataArray addObject:model];
                for (NSDictionary *dic0 in dic[@"replies"]) {
                    NewsCommentModel *model = [[NewsCommentModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic0];
                    model.isCell = 0;
                    [self.dataArray addObject:model];

                }
            }
        }
        NSLog(@"总数是%ld",(unsigned long)self.dataArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.title = [[NSString stringWithFormat:@"%ld",(unsigned long)self.dataArray.count]stringByAppendingString:@"条评论"];
            [self.tab reloadData];
            
        });
    } error:^(NSError *error) {
        
    }];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//////////
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Tool *tool = [[Tool alloc]init];
    NewsCommentModel *model = self.dataArray[indexPath.row];
    if (model.isCell == 0){
        CGFloat height1 = [tool getSContentLabelHeight:model.content font:[UIFont systemFontOfSize:14]];
        return height1 +48;
    }else{
        CGFloat height = [tool getContentLabelHeight:model.content font:[UIFont systemFontOfSize:14]];
    return height + 83;
    }
}
////////
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    static NSString *identifier1 = @"cell1";
    NewsCommentModel *model = self.dataArray[indexPath.row];
        if (model.isCell == 1) {
            NewsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NewsCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:model.userImage]];
        cell.nickname.text = model.nickname;
        cell.content.text = model.content;
            if (model.replyCount == 0) {
                cell.tfReply.text = @"回复";
            }
            else{
                cell.tfReply.text = [NSString stringWithFormat:@"%ld",(long)model.replyCount];
            }
        NSRange range = NSMakeRange(10, 5);
        cell.timeLabel.text = [model.date substringWithRange:range];
            if (model.replyCount == 0) {
                cell.triangleView.hidden = YES;
                cell.horizonal.hidden = NO;
            }
            else{
                cell.triangleView.hidden = NO;
                cell.horizonal.hidden = YES;
            }
        return cell;
    }
    else{
            NewsReplyTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (cell1 == nil) {
                cell1 = [[NewsReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
            }
            [cell1.userImage sd_setImageWithURL:[NSURL URLWithString:model.userImage]];
            cell1.nickname.text = model.nickname;
            cell1.content.text = model.content;
            NSRange range = NSMakeRange(10, 5);
            cell1.timeLabel.text = [model.date substringWithRange:range];
            //cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.userImage]]];
            return cell1;

    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
