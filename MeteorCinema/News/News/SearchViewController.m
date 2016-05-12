//
//  SearchViewController.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "SearchViewController.h"

#import "BaseTableView.h"

#import "SearchNews.h"

#import "TableViewCellFactory.h"

#import "NewsTableViewCell.h"



#import "NewsDetailViewController.h"


#define SearchURL @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news?title=%@"

@interface SearchViewController () < UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate >

@property (nonatomic, strong) BaseTableView * tableView;

@property (nonatomic, strong) UISearchBar * searchBar;


@property (nonatomic, strong) NSMutableArray * dataArray;



// 记录搜索结果 总信息数 和总页数
@property (nonatomic, assign) NSInteger allNum;

@property (nonatomic, assign) NSInteger allPages;

@end

@implementation SearchViewController

#pragma mark- 懒加载
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 20)];
        self.searchBar.placeholder = @"请输入关键词";
        self.searchBar.barStyle = UIBarStyleDefault;
    }
    return _searchBar;
}



-(BaseTableView *)tableView{
    if (!_tableView) {
        self.tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 20, ScreenWidth, ScreenHeight / 20 * 19 - 64) style:UITableViewStylePlain];
        self.tableView.bounces = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    

    self.navigationItem.title = @"新闻搜索";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButton:)];
    
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    
    [self setExtraCellLineHidden:self.tableView];
    
    
    
    
    
}

-(void)backBarButton:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}



#pragma mark- UISearchBar 代理方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.dataArray removeAllObjects];
    
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:SearchURL,searchBar.text] parDic:nil HTTPHeader:@{@"apikey":@"128bf44c945041e708d6f53dbb9dc4da"} finish:^(NSData *data, NSURLResponse *response) {
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary * dic0 = [dataDic objectForKey:@"showapi_res_body"];
        
        NSDictionary * dic1 = [dic0 objectForKey:@"pagebean"];
        
        self.allNum = [[dic1 objectForKey:@"allNum"] integerValue];;
        
        self.allPages = [[dic1 objectForKey:@"allPages"] integerValue];
        
        
        NSArray * array = [dic1 objectForKey:@"contentlist"];
        
        for (NSDictionary * dic in array) {
            SearchNews * news = [[SearchNews alloc] init];
            [news setSearchNewsWithDic:dic];
            
            [self.dataArray addObject:news];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                [self.view addSubview:self.tableView];
            });
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            [self.tableView reloadData];
        });
        
        
    } error:^(NSError *error) {
        
        
        NSLog(@"%@",error);
    }];
}



#pragma mark- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count >= 1) {
        
        return self.dataArray.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier0 = @"noimage";
    static NSString * identifier1 = @"oneimage";
    
    
    if (self.dataArray.count >= 1) {

        SearchNews * news = self.dataArray[indexPath.row];

        if (news.imageurls.count == 0) {
        
            NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];

            if (cell == nil) {
           
                cell = [TableViewCellFactory createNewsWithoutImageTableViewCell];
        
            }

            cell.searchNews = news;

            return cell;
    
        }else{
       
            NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
       
            if (cell == nil) {
            cell = [TableViewCellFactory createNewsWithOneImageTableViewCell];
        }

            cell.searchNews = news;

            return cell;
    }
    }else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"没有搜索结果";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count >= 1) {
        SearchNews * news = self.dataArray[indexPath.row];

        if (news.imageurls.count == 0) {
 
            return ScreenHeight / 8;

        }else{

            return ScreenHeight / 6;

        }
    }else{
        return 50;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count >= 1) {
        SearchNews * news = self.dataArray[indexPath.row];
        NewsDetailViewController * vc = [[NewsDetailViewController alloc] init];
        vc.searchNews = news;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.translucent = NO;
     [self presentViewController:nav animated:YES completion:^{
        
     }];
    }
    
    
    
    
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
