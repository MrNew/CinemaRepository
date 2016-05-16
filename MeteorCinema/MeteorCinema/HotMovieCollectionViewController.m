//
//  HotMovieCollectionViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "HotMovieCollectionViewController.h"

#import "MovieCollectionDataBaseUtil.h"

#import "HotMovieCollectionViewCell.h"

#import "HotMovieModel.h"

#import "UIImageView+WebCache.h"

#import "MovieDetailViewController.h"


#define Width self.view.bounds.size.width

#define Height self.view.bounds.size.height

@interface HotMovieCollectionViewController () < UICollectionViewDataSource,UICollectionViewDelegate >

@property (nonatomic, strong) UICollectionView * collectionView;


@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) MovieDetailViewController * movie;


@end

@implementation HotMovieCollectionViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        
        layout.itemSize = CGSizeMake(Width / 3 - 10 - 10, Height / 4);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
//        [self.collectionView registerNib:[UINib nibWithNibName:@"HotMovieCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"hotMovie"];
        
        [self.collectionView registerClass:[HotMovieCollectionViewCell class] forCellWithReuseIdentifier:@"hotMovie"];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
        self.collectionView.bounces = NO;
    }
    return _collectionView;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"热映电影收藏";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClik:)];
    
    [self.view addSubview:self.collectionView];
    
    [self.dataArray removeAllObjects];
    self.dataArray = (NSMutableArray *)[[MovieCollectionDataBaseUtil share] selectTableWithName:@"movie"];
    
    
    if (self.dataArray.count == 0) {

        // 添加 无收藏时的图片
        
        
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash  target:self action:@selector(deleteButtonClik:)];
    
}

-(void)backClik:(UIButton *)button{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)deleteButtonClik:(UIButton *)button{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"是否清空电影收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.dataArray removeAllObjects];
        
        [[MovieCollectionDataBaseUtil share] deleteTableWithName:@"movie"];
        [self.collectionView reloadData];
    }];
    [alert addAction:sure];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

    
    
    
}


#pragma mark- collectionView 代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    HotMovieCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotMovie" forIndexPath:indexPath];
    
    
    HotMovieModel * hot = [self.dataArray objectAtIndex:indexPath.item];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hot.img]];
    
    cell.label.text = hot.title;
    cell.backgroundColor = [UIColor grayColor];

    
    
    
    return cell;
    
   
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    HotMovieModel * hot = [self.dataArray objectAtIndex:indexPath.item];
    
    self.movie = [[MovieDetailViewController alloc] init];
    
    self.movie.hotMovie = hot;
    self.movie.movieID = hot.identifier;
    
//    movie.view.frame = CGRectMake(0, 0, Width, Height);
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:self.movie];
    nav.navigationController.navigationBar.translucent = NO;
    
    [self presentViewController:nav animated:YES completion:^{
        self.movie.view.frame = CGRectMake(0, 64, Width, Height  + 49);
        self.movie.scrollView.frame = CGRectMake(0, 0, Width, Height);
        self.movie.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"returnBack"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonbackClik:)];
        
    }];
    
    
    
}

-(void)buttonbackClik:(UIButton *)button{
    
    [self.movie dismissViewControllerAnimated:YES completion:^{
        
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
