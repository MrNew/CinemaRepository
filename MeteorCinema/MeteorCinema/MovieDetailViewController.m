//
//  MovieDetailViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieDetailViewController.h"

#import "NetWorkRequestManager.h"

#import "UIImageView+WebCache.h"

#import "RoundView.h"

#import "TopView.h"

#import "ConnectedCollectionViewCell.h"

#import "ConnectedModel.h"

#import "NewsDetailViewController.h"

#import "CommentViewController.h"

#import "CompanyViewController.h"

#import "MoreDetailViewController.h"


// 新闻标题
#define ExtendConnectedURL @"http://api.m.mtime.cn/Movie/News.api?pageIndex=1&movieId="

#define MovieCommentURL @"http://api.m.mtime.cn/Showtime/MovieComments.api?pageIndex=1&movieId="




//#define HotLongCommentURL @"http://api.m.mtime.cn/Movie/HotLongComments.api?pageIndex=1&movieId="

//#define CompanyURL @"http://api.m.mtime.cn/Movie/CompanyList.api?MovieId="

//#define MoreURL @"http://api.m.mtime.cn/Movie/MoreDetail.api?MovieId="




#define Width self.view.bounds.size.width

#define Height (self.view.bounds.size.height - 49 - 64)

@interface MovieDetailViewController () < UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate >




// 周边资讯
@property (nonatomic, strong) UICollectionView * connectedCollectionView;

// 网友短评
@property (nonatomic, strong) UITableView * tableView;

// 更多信息
@property (nonatomic, strong) TopView * moreView;




//额外事情 (内涵 相关新闻的 id)
//@property (nonatomic, strong) NSMutableArray * extendConnectedArray;
// 相关新闻
@property (nonatomic, strong) NSMutableArray * connectedNewsArray;

// 长影评数组
@property (nonatomic, strong) NSMutableArray * hotLongCommentArray;
// 网友短评数组
@property (nonatomic, strong) NSMutableArray * movieCommentArray;


@end

@implementation MovieDetailViewController

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize = CGSizeMake(Width, Height * 1.3);
    }
    return _scrollView;
}

-(UICollectionView *)connectedCollectionView{
    if (!_connectedCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        layout.itemSize = CGSizeMake(Width / 3, Height / 3);
        
        self.connectedCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Width, Height / 3) collectionViewLayout:layout];
        self.connectedCollectionView.backgroundColor = [UIColor whiteColor];
        self.connectedCollectionView.showsHorizontalScrollIndicator = NO;
        
        self.connectedCollectionView.bounces = NO;
    }
    return _connectedCollectionView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


-(NSMutableArray *)connectedNewsArray{
    if (!_connectedNewsArray) {
        self.connectedNewsArray = [NSMutableArray array];
    }
    return _connectedNewsArray;
}

-(NSMutableArray *)movieCommentArray{
    if (!_movieCommentArray) {
        self.movieCommentArray = [NSMutableArray array];
    }
    return _movieCommentArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    
    [self.view addSubview:self.scrollView];
    if (self.hotMovie) {
        
        self.navigationItem.title = self.hotMovie.title;

    }else{
        
        self.navigationItem.title = self.future.title;
    }
    
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height / 5 * 3)];
    [self.scrollView addSubview:backImageView];
    
    if (self.hotMovie) {
        
        [backImageView sd_setImageWithURL:[NSURL URLWithString:self.hotMovie.img]];
    }else{
        [backImageView sd_setImageWithURL:[NSURL URLWithString:self.future.image]];
    }
    backImageView.alpha = 0.3;
    
    
    RoundView * view = [[RoundView alloc] initWithFrame:CGRectMake(0, backImageView.frame.size.height / 3, backImageView.frame.size.width, backImageView.frame.size.height /  3 * 2)];
    
    [self.scrollView addSubview:view];
    
    
    UIImageView * fontImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Width / 15, 0, Width / 3, backImageView.frame.size.height / 2)];
    fontImageView.center = CGPointMake(fontImageView.center.x, view.frame.size.height / 4 );
    [view addSubview:fontImageView];
    
    if (self.hotMovie) {
        
        [fontImageView sd_setImageWithURL:[NSURL URLWithString:self.hotMovie.img]];
    }else{
        [fontImageView sd_setImageWithURL:[NSURL URLWithString:self.future.image]];
    }
    
    
    UILabel * sumTime = [[UILabel alloc] initWithFrame:CGRectMake( Width / 15 * 2 + Width / 3, view.frame.size.height / 6, view.frame.size.width - Width / 15 * 3 - Width / 3, view.frame.size.height / 15)];
    [view addSubview:sumTime];
    sumTime.textColor = [UIColor grayColor];
    if (self.hotMovie) {
        
        sumTime.text = self.hotMovie.sumtime;
    }else{
//        sumTime.text = self.future.title;
    }
    
    UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(sumTime.frame.origin.x, sumTime.frame.origin.y + sumTime.frame.size.height + 5,view.frame.size.width - Width / 15 * 3 - Width / 3, view.frame.size.height / 15)];

    [view addSubview:typeLabel];
    typeLabel.textColor = [UIColor grayColor];
    if (self.hotMovie) {
        
        typeLabel.text = self.hotMovie.typeString;
    }else{
        typeLabel.text = self.future.typeString;
    }
    
    
    
    
    
    
    UILabel * playLabel = [[UILabel alloc] initWithFrame:CGRectMake(sumTime.frame.origin.x, typeLabel.frame.origin.y + typeLabel.frame.size.height + 5,view.frame.size.width - Width / 15 * 3 - Width / 3, view.frame.size.height / 15)];
    [view addSubview:playLabel];
    playLabel.textColor = [UIColor grayColor];
    if (self.hotMovie) {
        
        playLabel.text = self.hotMovie.time;
    }else{
        playLabel.text = self.future.releaseDate;
    }
    

    // 在一个button 在view上
    UIButton * cinemaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:cinemaButton];
    [cinemaButton setTitle:@"查询播放影院" forState:UIControlStateNormal];
    cinemaButton.frame = CGRectMake(fontImageView.frame.origin.x, fontImageView.frame.origin.y + fontImageView.frame.size.height + view.frame.size.height / 15 + 5, Width - fontImageView.frame.origin.x * 2, view.frame.size.height / 5);
    cinemaButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cinemaButton.layer.cornerRadius = cinemaButton.frame.size.height / 2;
    cinemaButton.layer.masksToBounds = YES;
    cinemaButton.backgroundColor = [UIColor orangeColor];
    
    
    
    
//    NSLog(@"%ld     %ld",self.cityID,self.movieID);

    // 相关新闻
    UILabel * connectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + view.frame.size.height, Width , Height / 12)];
    [self.scrollView addSubview:connectedLabel];
    connectedLabel.text = @"   剧照 / 资讯";
    connectedLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
//    UIScrollView * connectedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, connectedLabel.frame.origin.y + connectedLabel.frame.size.height, Width, Height / 3)];
//    connectedScrollView.backgroundColor = [UIColor yellowColor];
//    connectedScrollView.contentSize = CGSizeMake(Width * 3, connectedScrollView.frame.size.height);
//    [self.scrollView addSubview:connectedScrollView];
    
    
    self.connectedCollectionView.frame = CGRectMake( 0, connectedLabel.frame.origin.y + connectedLabel.frame.size.height, Width, Height / 3);
    [self.scrollView addSubview:self.connectedCollectionView];
//    self.connectedCollectionView.backgroundColor = [UIColor grayColor];
    self.connectedCollectionView.delegate = self;
    self.connectedCollectionView.dataSource = self;
    [self.connectedCollectionView registerClass:[ConnectedCollectionViewCell class] forCellWithReuseIdentifier:@"connected"];
    
    
    
    // 网友评论
    UILabel * commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.connectedCollectionView.frame.origin.x, self.connectedCollectionView.frame.origin.y + self.connectedCollectionView.frame.size.height, Width, Height / 12)];
    [self.scrollView addSubview:commentLabel];
    commentLabel.text = @"   网友短评";
    commentLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    [self.scrollView addSubview:self.tableView];
    self.tableView.frame = CGRectMake( 0, commentLabel.frame.origin.y + commentLabel.frame.size.height, Width, 0);
    
    self.tableView.scrollEnabled = NO;
    
    
    
    
    self.moreView = [[TopView alloc] initWithFrame:CGRectMake( 0, self.tableView.frame.size.height + self.tableView.frame.origin.y, Width, Height / 9)];
    
    [self.scrollView addSubview:self.moreView];
    self.moreView.backgroundColor = [UIColor grayColor];
    self.moreView.selectButtonTitleColor = [UIColor colorWithRed:230/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.moreView setTitleButton:@[@"制作发行",@"更多资料"]];
    [self.moreView.bottomView removeFromSuperview];
    [self.moreView setTitleButtonColor:[UIColor colorWithRed:235/255.0 green:96/255.0 blue:54/255.0 alpha:1]];
    
    [self requestDataWithMovieID:self.movieID];
    
    
    for (UIButton * button in self.moreView.buttonArray) {
        [button addTarget:self action:@selector(moreMessageButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
}

#pragma mark- 申请数据

-(void)requestDataWithMovieID:(NSInteger)movieID{
 
    [self.connectedNewsArray removeAllObjects];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",ExtendConnectedURL,movieID]);
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"%@%ld",ExtendConnectedURL,movieID] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {

        
           NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//           NSLog(@"%@",dataDic);
        
        NSArray * array = [dataDic objectForKey:@"newsList"];
        for (NSDictionary * dic in array) {
            ConnectedModel * model = [[ConnectedModel alloc] init];
            [model setValueWithDataDic:dic];
//            NSLog(@"%ld",model.identifier);
            
            
            [self.connectedNewsArray addObject:model];
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.connectedCollectionView reloadData];
            
            
            
            
        });
        
        
    } error:^(NSError *error) {
        
    }];
    
    
    
    [self.movieCommentArray removeAllObjects];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",MovieCommentURL,movieID]);
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"%@%ld",MovieCommentURL,movieID] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 
        NSArray * array = [dataDic objectForKey:@"cts"];
        
        for (NSDictionary * dic in array) {
            
            ConnectedModel * model = [[ConnectedModel alloc] init];
            [model setMovieWithDataDic:dic];
            
            [self.movieCommentArray addObject:model];
            
            
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            

            CGRect frame = self.tableView.frame;
            frame.size.height = Height / 5 * self.movieCommentArray.count;
            self.tableView.frame = frame;
            
            
            self.moreView.frame = CGRectMake( 0, self.tableView.frame.size.height + self.tableView.frame.origin.y, Width, Height / 9);
            
            self.scrollView.contentSize = CGSizeMake(Width, self.moreView.frame.size.height + self.moreView.frame.origin.y);
            
            [self.tableView reloadData];
            [UIView animateWithDuration:0.1 animations:^{
                
            } completion:^(BOOL finished) {
                [self.tableView reloadData];
                [UIView animateWithDuration:0.1 animations:^{
                    
                } completion:^(BOOL finished) {
                    [self.tableView reloadData];
                }];
            }];
        });
        
        
    } error:^(NSError *error) {
        
    }];
    
    
}


#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieCommentArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    ConnectedModel * model = [self.movieCommentArray objectAtIndex:indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"headHolder"]];
    
//    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height / 4;
//    cell.imageView.layer.masksToBounds = YES;
    
    cell.textLabel.text = model.name;
    

    
    cell.detailTextLabel.text = model.title;
    cell.detailTextLabel.numberOfLines = 3;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  Height / 5;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ConnectedModel * model = [self.movieCommentArray objectAtIndex:indexPath.row];
    
    CommentViewController * comment = [[CommentViewController alloc] init];
    
    comment.model = model;
    
    [self.navigationController pushViewController:comment animated:YES];
    
    
}

#pragma mark- collectionView 代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.connectedNewsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectedCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"connected" forIndexPath:indexPath];
    
    ConnectedModel * model = [self.connectedNewsArray objectAtIndex:indexPath.item];
    

    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    cell.model = model;
    
    
    return cell;
    
   
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectedModel * model = [self.connectedNewsArray objectAtIndex:indexPath.item];
    
    NewsDetailViewController * news = [[NewsDetailViewController alloc] init];
    
    news.model = model;
    
    
    [self.navigationController pushViewController:news animated:YES];
    
    
    
}


#pragma mark- 点击跟多信息的方法 ( 制作发行 更多资料 )
-(void)moreMessageButtonClik:(UIButton *)button{
    
    if ([button isEqual:self.moreView.buttonArray[0]]) {
        
        CompanyViewController * company = [[CompanyViewController alloc] init];
        
        company.identifier = self.movieID;
        NSLog(@"%ld",self.movieID);
        
        
        [self.navigationController pushViewController:company animated:YES];
        
    }else{
        
        MoreDetailViewController * moreDetail = [[MoreDetailViewController alloc] init];
        
        
        moreDetail.identifier = self.movieID;
        
        [self.navigationController pushViewController:moreDetail animated:YES];
        
        
        
    }
    
    
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
