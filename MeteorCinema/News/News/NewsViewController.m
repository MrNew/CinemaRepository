//
//  NewsViewController.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsViewController.h"

#import "NewsModel.h"

#import "HeaderModel.h"

#import "BaseTableView.h"

#import "NewsTableViewCell.h"

#import "TableViewCellFactory.h"

#import "RootViewController.h"

#import "Refresh.h"

// 轮播图
#import "CarouselImageView.h"


#import "NewsDetailViewController.h"

#import "PlayerViewController.h"






@interface NewsViewController () < UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,NSXMLParserDelegate,CarouselImageViewDelete >

@property (nonatomic, strong) BaseTableView * tableView;

// 装数据 (主体数据)
@property (nonatomic, strong) NSMutableArray * dataArray;


// 装数据 (表头数据)
@property (nonatomic, strong) NSMutableArray * headArray;
// 表头轮播图(网址)的 数据
@property (nonatomic, strong) NSMutableArray * headImageArray;
// 表头轮播图(图片)
@property (nonatomic, strong) NSMutableArray * headImage;
// 表头播放视屏地址
@property (nonatomic, strong) NSMutableArray * MP4Array;



@property (nonatomic, strong) NSMutableArray * headMessagArray;



// 临时变量
@property (nonatomic, strong) NSString * tempStr;


// 下拉刷新表头视图
@property (nonatomic, strong) Refresh * headView;

@property (nonatomic, strong) Refresh * foot;
// 标记是否下拉刷新
@property (nonatomic, assign) BOOL headerRefresh;
// 标记是否上拉刷新
@property (nonatomic, assign) BOOL footerRefresh;


// 计算可打开多少页数据
@property (nonatomic, assign) NSInteger page;
// 记录了加载到哪一页的数据
@property (nonatomic, assign) NSInteger readPage;






@end

@implementation NewsViewController


#pragma mark- 懒加载
// 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(NSMutableArray *)headImageArray{
    if (!_headImageArray) {
        self.headImageArray = [[NSMutableArray alloc] init];
    }
    return _headImageArray;
}

-(NSMutableArray *)headImage{
    if (!_headImage) {
        self.headImage = [[NSMutableArray alloc] init];
    }
    return _headImage;
}

-(NSMutableArray *)headMessagArray{
    if (!_headMessagArray) {
        self.headMessagArray = [NSMutableArray array];
    }
    return _headMessagArray;
}

-(NSMutableArray *)MP4Array{
    if (!_MP4Array) {
        self.MP4Array = [NSMutableArray array];
    }
    return _MP4Array;
}

-(void)viewWillAppear:(BOOL)animated{
//    self.tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 50) style:UITableViewStylePlain];
//    self.tableView.frame = CGRectMake(0, 50, ScreenWidth, self.view.frame.size.height - 50);
    
}


#pragma mark- 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    // 下拉刷新 记录了加载到哪一页的数据
    self.readPage = 1;
    
    self.tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 50) style:UITableViewStylePlain];
//    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 50);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    // 为tableView 添加表头
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"Refresh" owner:nil options:nil] lastObject];
//    self.headView = [[Refresh alloc] initWithFrame:CGRectMake(0, - 50, ScreenWidth, 50)];
    self.headView.frame = CGRectMake(0, - 80, ScreenWidth, 80);
    self.headView.backgroundColor = COLOR(41, 149, 170, 1);
    
    // 创建添加表尾
    _foot = [[[NSBundle mainBundle] loadNibNamed:@"Refresh" owner:nil options:nil] lastObject];
    _foot.backgroundColor = COLOR(41, 149, 170, 1);
    
    
    [self.tableView addSubview:self.headView];
    
//    self.headView.alpha = 0.3;
    

    [self listener];
}


-(void)updata{
    [self requestData:1 alertAppear:NO];
}


#pragma mark- 处理数据
-(void)requestData:(NSInteger)page alertAppear:(BOOL)alert{
    
    if ([self.boardString isEqualToString:@"推荐"]) {
        [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://news.roboo.com/news/recommendJson.htm?uid=&p=%ld&ps=15&isapp=yes",page] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
            
            NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSInteger number = [[dataDic objectForKey:@"total"] integerValue];
            self.page = number / 15 + 1;
            
            
            NSArray * array = [dataDic objectForKey:@"items"];
            // 需要建立model
            
            // 记录相同的array
            NSInteger same = 0;
            
            NSMutableArray * titleArray = [NSMutableArray array];
            
            for (NewsModel * news in _dataArray) {
                
           
                    
                    [titleArray addObject:news.title];
               
                
            }
            
            
            
            for (NSDictionary * dic in array) {
                // 需要建立model
                NewsModel * news = [[NewsModel alloc] init];
                [news setValuesWithDic:dic];
                
                if (alert) {
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray insertObject:news atIndex:0];
                    }else{
                        same++;
                    }
                }else{
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray addObject:news];
                    }else{
                        
                    }
                }
            }
            
            if(same == array.count && alert){
                [self alertViewappear];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.view addSubview:self.tableView];
                [self.tableView reloadData];

            });
            
            
        } error:^(NSError *error) {
            
        }];
    }else if ([self.boardString isEqualToString:@"热点"]){
        
//        // 加载表头数据
        [NetWorkRequestManager requestWithType:Get URLString:@"http://int.m.joy.cn/pps/s.py?pg=c&gd=22&cd=48057&cacheflag=1" parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
            // sax 解析,系统自带的,内存占用较少,速度慢,逐行解析
            // 解析下载下来的
            
            // 1.创建 解析类
            NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
            // 2. 授权
            parser.delegate = self;
            // 3. 开始解析
            [parser parse];
            // 4. 走代理方法
            
            
            for (HeaderModel * head in self.headArray) {
                if (![self.headMessagArray containsObject:head.ftitle]) {
                    [self.headImageArray addObject:head.fbPicUrl];
//                    [self.headMessagArray addObject:head.ftitle];
                }
            }
            
            for (NSString * string in self.headImageArray) {
                NSInteger number = [self.headImageArray indexOfObject:string];
                
                NSURL * url = [NSURL URLWithString:string];
                
                NSData * data = [NSData dataWithContentsOfURL:url];
                
                UIImage * image = [UIImage imageWithData:data];
                
                if (image != nil) {
                    HeaderModel * head = self.headArray[number];
//                    [self.headMessagArray addObject:head.ftitle];
                    
                    
                    if (![self.headMessagArray containsObject:head.ftitle]) {
                        [self.headImage addObject:image];
//                        [self.headImageArray addObject:head.fbPicUrl];
                        [self.headMessagArray addObject:head.ftitle];
                        [self.MP4Array addObject:head.fplayurlsm];
                    }
                    
                }
                
                
            }
            

            
            // 返回主线程
            dispatch_async(dispatch_get_main_queue(), ^{
              
//                NSLog(@"%@",self.headImage);
                if (self.headImage.count > 0) {
                    CarouselImageView * carousel = [[CarouselImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 5) imageArray:self.headImage messageArray:self.headMessagArray time:2];
                    
                    carousel.delegate = self;
                    
                    self.tableView.tableHeaderView = carousel;
                    
                }
                
//                [self.view addSubview:self.tableView];
            });
            
            
            
        } error:^(NSError *error) {
//            NSLog(@"%@",error);
        }];
    
        
        
        // 加载主体数据
        [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://news.roboo.com/news/hotJson.htm?uid=&p=%ld&ps=15&isapp=yes",page] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
            
            NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSInteger number = [[dataDic objectForKey:@"total"] integerValue];
            self.page = number / 15 +1;
            
            
            NSArray * array = [dataDic objectForKey:@"items"];
            // 记录相同的array
            NSInteger same = 0;
            
            NSMutableArray * titleArray = [NSMutableArray array];
            for (NewsModel * news in _dataArray) {
                
                
                [titleArray addObject:news.title];
            }
            
            
            
            for (NSDictionary * dic in array) {
                // 需要建立model
                NewsModel * news = [[NewsModel alloc] init];
                [news setValuesWithDic:dic];
                
                if (alert) {
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray insertObject:news atIndex:0];
                        
                       
                        
                    }else{
                        same++;
                    }
                }else{
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray addObject:news];
                    }else{
                        
                    }
                }
            }
            
            if(same == array.count && alert){
                [self alertViewappear];
            }
           
            
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.view addSubview:self.tableView];
                [self.tableView reloadData];

            });
            
            
        } error:^(NSError *error) {
            
        }];
        
    }else{
        NSString * urlString = [NSString stringWithFormat:@"http://news.roboo.com/news/categoryJson.htm?uid=&c=%@&p=%ld&ps=15&isapp=yes",_boardString,page];
        
        [NetWorkRequestManager requestWithType:Get URLString:urlString parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
            NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSInteger number = [[dataDic objectForKey:@"total"] integerValue];
            self.page = number / 15 +1;
            
            
            NSArray * array = [dataDic objectForKey:@"items"];
            // 记录相同的array
            NSInteger same = 0;
            
            NSMutableArray * titleArray = [NSMutableArray array];
            for (NewsModel * news in _dataArray) {
                
                
                [titleArray addObject:news.title];
            }
            
            
            
            for (NSDictionary * dic in array) {
                // 需要建立model
                NewsModel * news = [[NewsModel alloc] init];
                [news setValuesWithDic:dic];
                
                if (alert) {
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray insertObject:news atIndex:0];
                    }else{
                        same++;
                    }
                }else{
                    if (![titleArray containsObject:news.title]) {
                        [self.dataArray addObject:news];
                    }else{
                        
                    }
                }
            }
            
            if(same == array.count && alert){
                [self alertViewappear];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view addSubview:self.tableView];
//                NSLog(@"%@",_dataArray);
                [self.tableView reloadData];
//                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            });
        } error:^(NSError *error) {
            
        }];
        
        
        
    }
    
 
    
   
}

#pragma mark- xml sax 解析
// 使用代理方法 (开始解析,搜索节点)
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    // 当发现 pic 节点的时候,初始化数组 和 表头模型
    if ([elementName isEqualToString:@"focusPic"]) {
        _headArray = [NSMutableArray array];
    }else if ([elementName isEqualToString:@"pic"]){
        
        HeaderModel * head = [[HeaderModel alloc] init];
        
        [_headArray addObject:head];
        
    }
    
    
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // 记录临时变量
    _tempStr = string;
  
}

// 结束搜索节点
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // 从数组中取出 诸侯一个表头模型 赋值
    HeaderModel * head = [_headArray lastObject];
    
    
    
    
    //赋值
    
    [head setValue:_tempStr forKey:elementName];
    
}


#pragma mark- 编写tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier0 = @"noimage";
    static NSString * identifier1 = @"oneimage";
    static NSString * identifier2 = @"threemoreimage";
    
    NewsModel * news = _dataArray[indexPath.row];
    
    // 判断模式
    if ([TableViewCellFactory share].state) {
        //NSLog(@"无图");
        NewsWithoutImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil) {
            cell = [TableViewCellFactory createNewsWithoutImageTableViewCell];
        }
        cell.news = news;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else{
        //NSLog(@"有图");
        
        // 判断 数据的图片数据
        if (news.imgSids.count == 0) {
            NewsWithoutImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
            if (cell == nil) {
                cell = [TableViewCellFactory createNewsWithoutImageTableViewCell];
            }
            cell.news = news;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (news.imgSids.count >= 1 && news.imgSids.count < 3){
            NewsWithOneImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (cell == nil) {
                cell = [TableViewCellFactory createNewsWithOneImageTableViewCell];
            }
            cell.news = news;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            NewsWithThreeMoreImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (cell == nil) {
                cell = [TableViewCellFactory createNewsWithThreeMoreTableViewCell];
            }
            cell.news = news;
            

            return cell;
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel * news = _dataArray[indexPath.row];
    if ([TableViewCellFactory share].state) {
        return ScreenHeight / 8;
    }else{
    
        if (news.imgSids.count == 0) {
        
            return ScreenHeight / 8;
    
        }else if (news.imgSids.count >= 1 && news.imgSids.count < 3){
        
            return ScreenHeight / 6;
    
        }else{
            return ScreenHeight / 4;

        }
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel * news = _dataArray[indexPath.row];
    
    if (![news.index isEqualToString:@"ads"]) {
    
    
        NewsDetailViewController * vc = [[NewsDetailViewController alloc] init];
    
   
        vc.news = news;
//        NSLog(@"%@",news.link);
    
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        nav.navigationBar.translucent = NO;
        
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    [self.parentViewController presentViewController:nav animated:YES completion:^{
        
    }];
    
    }
    
    
    
    
    
}



#pragma mark- 文字模式,图片模式转换
-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"text" object:nil];
}


- (void) recvBcast:(NSNotification *)notify
{
    [self.tableView reloadData];
    
}


#pragma mark- 上拉刷新 下拉刷新
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewY = scrollView.contentOffset.y;

    // 下拉刷新工具
    if (scrollViewY <0 && scrollViewY >= -80) {
        // 判断是否在 被拖动,还是在恢复原状
        if (scrollView.decelerating) {
//            self.headView.label.text = @"正在加载";
        }else{
            self.headView.label.text = @"下拉刷新";
        }
    }
    
    if (scrollViewY < -80) {
        if (!scrollView.decelerating){
            self.headView.label.text = @"松手刷新";
        }
    }
    
    
    
    // 上拉加载
    // 1.判断是否滑到最底部
    if (scrollView.frame.size.height + scrollViewY >= scrollView.contentSize.height + 80) {
        // 判断是否在 被拖动,还是在恢复原状
        if (scrollView.decelerating) {
           
            
        }else{
        _foot.label.text = @"松手加载更多";
        }
    }else if (scrollView.frame.size.height + scrollViewY >= scrollView.contentSize.height && scrollView.frame.size.height + scrollViewY < scrollView.contentSize.height + 80){
        // 判断是否在 被拖动,还是在恢复原状
        if (scrollView.dragging) {
            _foot.label.text = @"上拉加载更多";
        }

    }
    _foot.frame = CGRectMake(0, scrollView.contentSize.height, ScreenWidth, 80);
    [self.tableView addSubview:_foot];
    
        
  
    
    
    
    
}

// 减速
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat scrollViewY = scrollView.contentOffset.y;
    
    // 下拉加载
    if (scrollViewY <= -80) {

        [UIView animateWithDuration:0.1 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
        } completion:^(BOOL finished) {

        }];
        
        self.headView.label.text = @"正在加载中";
        // 判断是否在 被拖动,还是在恢复原状
        if (scrollView.decelerating) {
            
        }else{
//            self.headView.label.text = @"正在加载";
            // 载入加载状态
            self.headerRefresh = YES;
   
        }
    }
    
    
    // 上拉加载
    // 上拉加载
    // 1.判断是否滑到最底部
    if (scrollView.frame.size.height + scrollViewY >= scrollView.contentSize.height + 80) {
        
        [UIView animateWithDuration:0.1 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        } completion:^(BOOL finished) {
            
        }];
        
       
        _foot.label.text = @"正在加载";
        // 判断是否在 被拖动,还是在恢复原状
        if (scrollView.decelerating) {
        }else{
            // 标记 上拉刷新
            _footerRefresh = YES;
            
            
        }
    }
  
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

   // 下拉加载
    [UIView animateWithDuration:1 animations:^{
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        if (self.headerRefresh) {
            [self requestData:1 alertAppear:YES];
            self.headerRefresh = NO;
        }
        
        if(self.footerRefresh){
            if (self.readPage <= self.page) {
                [self requestData:self.readPage alertAppear:NO];
                self.readPage++;
            }
            self.footerRefresh = NO;
        }
        
    }];
    
    
    // 上拉加载
   
}







#pragma mark- 新数据信息重复处理(弹出提示窗)
-(void)alertViewappear{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"没有更多内容" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    
    
    
}


#pragma mark- 轮播图的代理方法
-(void)touchImageIndex:(NSInteger)index{
    
    NSString * string = [self.MP4Array objectAtIndex:index];
    
    PlayerViewController * player = [[PlayerViewController alloc] init];
    
    player.URLString = string;
    
    NSLog(@"%@",player.URLString);
    
    [self presentViewController:player animated:YES completion:^{
        
    }];
    
    
}





#pragma mark- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
