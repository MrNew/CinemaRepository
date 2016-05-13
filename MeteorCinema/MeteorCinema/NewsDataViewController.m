//
//  NewsDataViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsDataViewController.h"
#import "NewsDataBaseUtil.h"
#import "NewsCollectModel.h"
#import "UIImageView+WebCache.h"
#import "NewsCollectTableViewCell.h"
@interface NewsDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation NewsDataViewController
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
self.navigationItem.title = @"我的收藏";
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tab];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 120;
    [self setExtraCellLineHidden:self.tab];

    [self.tab reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(doBarButton)];
    self.dataArray = [[NewsDataBaseUtil shareDataBase]selectFromTable:@"collects"];

}
#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
-(void)doBarButton{
[[NewsDataBaseUtil shareDataBase]deleteWithTable:@"collects"];
    [self.dataArray removeAllObjects];
    [self.tab reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NewsCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
    
    cell = [[NewsCollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NewsCollectModel *model = [[NewsCollectModel alloc]init];
    model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.itemTitle;
    cell.detailLabel.text = model.summary;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image]];
    return cell;
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
