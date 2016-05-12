//
//  CollectionViewController.m
//  News
//
//  Created by lanou on 16/5/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "CollectionViewController.h"

//#import "BaseTableView.h"

#import "DataBaseUtil.h"

#import "BaseTableViewCell.h"

#import "NewsDetailViewController.h"

@interface CollectionViewController () < UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UITableView * tableView;



@property (nonatomic, strong) NSMutableArray * historyArray;

@property (nonatomic, strong) NSMutableArray * collectionArray;


@property (nonatomic, strong) UIView * moveView;

@property (nonatomic, strong) UIImageView * moveImageView;



// 记录显示 的东西
@property (nonatomic, strong) NSString * show;

@end

@implementation CollectionViewController


#pragma mark- 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (ScreenHeight - 64) / 10, ScreenWidth, (ScreenHeight - 64) / 10 * 8) style:UITableViewStylePlain];
    }
    return _tableView;
}

-(NSMutableArray *)historyArray{
    if (!_historyArray) {
        self.historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

-(NSMutableArray *)collectionArray{
    if (!_collectionArray) {
        self.collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.show = @"历史";
    [self.historyArray addObjectsFromArray:[[DataBaseUtil share] selectTableWithName:@"history"]];
    [self.collectionArray addObjectsFromArray:[[DataBaseUtil share] selectTableWithName:@"collection"]];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    //    self.navigationItem.title = @"收藏/历史记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButton)];
    
    UIImage * rubbish = [UIImage imageNamed:@"rubbish"];
    rubbish = [rubbish imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rubbish style:UIBarButtonItemStylePlain target:self action:@selector(rubbishButton:)];
    
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 10)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, view.frame.size.width / 2, view.frame.size.height);
    [view addSubview:leftButton];
    leftButton.tag = 10;
    [leftButton setTitle:@"历史记录" forState:UIControlStateNormal];
    [leftButton setBackgroundColor:COLOR(20, 30, 50, 1)];
    [leftButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(view.frame.size.width / 2, 0, view.frame.size.width / 2, view.frame.size.height);
    [view addSubview:rightButton];
    rightButton.tag = 12;
    [rightButton setTitle:@"收藏" forState:UIControlStateNormal];
    [rightButton setBackgroundColor:COLOR(30, 150, 130, 1)];
    [rightButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moveView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height / 20 * 19, view.frame.size.width / 2, view.frame.size.height / 20)];
    self.moveView.backgroundColor = COLOR(200, 190, 160, 1);
    //    [view addSubview:self.moveView];
    
    self.moveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.height / 2, view.frame.size.height / 2)];
    self.moveImageView.center = CGPointMake(view.frame.size.height / 2 , view.frame.size.height / 2);
    self.moveImageView.image = [UIImage imageNamed:@"left"];
    [view addSubview:self.moveImageView];
    
    [self setExtraCellLineHidden:self.tableView];
    
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    UILabel * bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (ScreenHeight - 64) / 10 * 9, ScreenWidth, (ScreenHeight - 64) / 10)];
    bottomLabel.backgroundColor = COLOR(60, 80, 160, 1);
    [self.view addSubview:bottomLabel];
    bottomLabel.text = @"清空记录";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rubbishButton:)];
    [bottomLabel addGestureRecognizer:tap];
    
    bottomLabel.userInteractionEnabled = YES;
}


#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}










#pragma mark- 点击方法
-(void)rubbishButton:(UIButton *)button{
    
    NSString * show =[[NSString alloc] init];
    if ([self.show isEqualToString:@"历史"]) {
        show = @"history";
    }else if ([self.show isEqualToString:@"收藏"]){
        show = @"collection";
    }
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"是否清空%@记录",self.show] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DataBaseUtil share] deleteTableWithName:show];
        
        [self.historyArray removeAllObjects];
        [self.collectionArray removeAllObjects];
        [self.historyArray addObjectsFromArray:[[DataBaseUtil share] selectTableWithName:@"history"]];
        [self.collectionArray addObjectsFromArray:[[DataBaseUtil share] selectTableWithName:@"collection"]];
        
        [self.tableView reloadData];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sure];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}


-(void)backBarButton{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)button:(UIButton *)button{
    if (button.tag == 10) {
        self.show = @"历史";
        
        [UIView animateWithDuration:1 animations:^{
            self.moveView.frame = CGRectMake(0, ScreenHeight / 10 / 20 * 19, ScreenWidth / 2, ScreenHeight / 10 / 20);
            self.moveImageView.center = CGPointMake(ScreenHeight / 10 / 2 , ScreenHeight / 10 / 2);
            self.moveImageView.image = [UIImage imageNamed:@"left"];
        } completion:^(BOOL finished) {
            [self.tableView reloadData];
        }];
        
    }else if (button.tag == 12){
        self.show = @"收藏";
        [UIView animateWithDuration:1 animations:^{
            
            self.moveView.frame = CGRectMake(ScreenWidth / 2, ScreenHeight / 10 / 20 * 19, ScreenWidth / 2, ScreenHeight / 10 / 20);
            self.moveImageView.center = CGPointMake(ScreenWidth - ScreenHeight / 10 / 2 , ScreenHeight / 10 / 2);
            self.moveImageView.image = [UIImage imageNamed:@"right"];
        } completion:^(BOOL finished) {
            [self.tableView reloadData];
        }];
    }
}



#pragma mark- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.show isEqualToString:@"历史"]) {
        return self.historyArray.count;
    }else if ([self.show isEqualToString:@"收藏"]){
        return self.collectionArray.count;
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenHeight / 8;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"cell";
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if ([self.show isEqualToString:@"历史"]) {
        
        NewsModel * news = self.historyArray[self.historyArray.count - 1 - indexPath.item];
        cell.textLabel.text = news.title;
        
    }else if ([self.show isEqualToString:@"收藏"]){
        NewsModel * news = self.collectionArray[self.collectionArray.count - 1 - indexPath.item];
        cell.textLabel.text = news.title;
    }
    
    cell.backgroundColor = COLOR(240, 240, 240, 0.9);
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsDetailViewController * vc = [[NewsDetailViewController alloc] init];
    
    
    if ([self.show isEqualToString:@"历史"]) {
        NewsModel * news = self.historyArray[indexPath.item];
        
        vc.news = news;
        
        
    }else if ([self.show isEqualToString:@"收藏"]){
        NewsModel * news = self.collectionArray[indexPath.item];
        
        vc.news = news;
        
    }
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
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
