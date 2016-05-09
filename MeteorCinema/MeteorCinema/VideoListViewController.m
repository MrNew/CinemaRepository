//
//  VideoListViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "VideoListViewController.h"

#import "ConnectedCollectionViewCell.h"

#import "UIImageView+WebCache.h"

#import "PlayerViewController.h"

#define Width self.view.frame.size.width

#define Height (self.view.frame.size.height - 49)



@interface VideoListViewController () < UICollectionViewDataSource,UICollectionViewDelegate >


@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation VideoListViewController




-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layout.itemSize = CGSizeMake( Width / 4, Height / 5);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - 64) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        self.collectionView.bounces = NO;
        
        
        
        [self.collectionView registerClass:[ConnectedCollectionViewCell class] forCellWithReuseIdentifier:@"connected"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor colorWithRed:217/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    
    
    NSLog(@"%@",self.videoArray);
    
    [self.view addSubview:self.collectionView];
    
    
    
    
    
    
}

#pragma mark- collectionView 代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.connectedNewsArray.count;
    return self.videoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectedCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"connected" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    
    NSDictionary * dic = [self.videoArray objectAtIndex:indexPath.item];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]]];
    
    cell.hasVedio = YES;
    

//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
//    cell.model = model;
    
    
    return cell;
    
   
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSDictionary * dic = [self.videoArray objectAtIndex:indexPath.item];
    
    
    PlayerViewController * player = [[PlayerViewController alloc] init];
    
    player.URLString = [dic objectForKey:@"hightUrl"];
    
    player.dataDic = dic;
    
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:player animated:YES];
    
    
    
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
