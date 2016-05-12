//
//  PicScrollViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/8.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "PicScrollViewController.h"
#import "NetWorkRequestManager.h"
#import "PicModel.h"
#import "Tool.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
@interface PicScrollViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *picScroll;
@property(nonatomic,strong)UILabel *bottomLabel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *descTitle;
@property(nonatomic,assign)NSInteger isTap;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIView *backView;
@end
@implementation PicScrollViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithRed:237/255.0 green:17/255.0 blue:74/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;

}
-(NSMutableArray *)dataArray{
    if ((!_dataArray)) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,32,32)];
    UIImage *image = [UIImage imageNamed:@"返回(2)"] ;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:[UIImage imageNamed:@"返回(2)"] forState: UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(doBarBtn) forControlEvents:UIControlEventTouchUpInside];

///////////
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    [self network];
}
-(void)doBarBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doTap:(UITapGestureRecognizer *)taps{
    _isTap++;
    if (_isTap%2 == 0) {
       // self.navigationItem.leftBarButtonItem.customView.hidden = NO;
        self.backView.hidden = NO;
        self.navigationController.navigationBar.hidden = NO;
       [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
      //  self.navigationItem.leftBarButtonItem.customView.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
        self.backView.hidden = YES;
    }
}
-(void)network{
    [NetWorkRequestManager requestWithType:Get URLString:self.picAPI parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"images"];
        self.newsTitle = dic[@"title"];
        self.descTitle = array[0][@"desc"];
        for (NSDictionary *dic0 in array) {
            PicModel *model = [[PicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic0];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picScroll = [[UIScrollView alloc]init];
            [self.view addSubview:self.picScroll];
            self.picScroll.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);

            self.picScroll.contentSize = CGSizeMake(UIScreenWidth*self.dataArray.count, 0);
            self.picScroll.pagingEnabled = YES;
            self.picScroll.bounces = NO;
            self.picScroll.delegate = self;
            Tool *tool = [[Tool alloc]init];
            for (int i = 0; i < self.dataArray.count; i++) {
                PicModel *models = self.dataArray[i];
                CGFloat imageHeight = [tool getImageHeight:models.url1];
             //   self.picScroll.frame = CGRectMake(0, 0, UIScreenWidth, imageHeight);
            //    self.picScroll.center = CGPointMake(UIScreenWidth/2, UIScreenHeight/2 - 64);
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*i, UIScreenHeight/2 - imageHeight/2, UIScreenWidth, imageHeight)];
            //    imageV.center = CGPointMake(UIScreenWidth*(1/2 + i), UIScreenHeight/2 -64);
                [self.picScroll addSubview:imageV];
                [imageV sd_setImageWithURL:[NSURL URLWithString:models.url1]];
            }
            ////////////
            self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, UIScreenHeight - 70 - 64, UIScreenWidth, 70 + 64)];
            self.backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            [self.view addSubview:self.backView];
            self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, UIScreenWidth -40,30 )];
            [self.backView addSubview:self.bottomLabel];
            self.bottomLabel.font = [UIFont boldSystemFontOfSize:17];
            self.bottomLabel.textColor = [UIColor whiteColor];
            self.bottomLabel.text = self.newsTitle;
            ////////////
            self.desc = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, UIScreenWidth - 120, 40)];
            self.desc.font = [UIFont systemFontOfSize:14];
            self.desc.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
            self.desc.text = self.descTitle;
            self.desc.numberOfLines = 0;
            CGFloat labelHeight = [tool getLabelHeight:self.descTitle font:self.desc.font];
            self.desc.frame = CGRectMake(20, 30, UIScreenWidth -120, labelHeight);
            //self.desc.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [self.backView addSubview:self.desc];

//            NSDictionary *attribute = @{NSFontAttributeName:self.desc.font};
//            CGSize size = [self.desc.text boundingRectWithSize:CGSizeMake(UIScreenWidth, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
//            self.desc.frame = CGRectMake(0, UIScreenHeight*2/3+25, size.width, size.height);
            //////
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            _button.frame = CGRectMake(UIScreenWidth - 120, 40, 100, 20);
            [self.backView addSubview:_button];
            _button.titleLabel.font = [UIFont systemFontOfSize:14];
            [_button setImage:[UIImage imageNamed:@"向右"] forState: UIControlStateNormal];
            [_button setTitle:@"查看全文" forState: UIControlStateNormal];
            [_button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            [_button setImageEdgeInsets:UIEdgeInsetsMake(0, 115, 0, 0)];
            [_button addTarget:self action:@selector(doJump:) forControlEvents:UIControlEventTouchUpInside];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - button
-(void)doJump:(UIButton *)btn{
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.detailAPI = self.picAPI;
    vc.itemTitle = self.itemTitle;
    vc.title2 = self.title2;
    vc.image = self.image;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - scroll 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/UIScreenWidth;
    PicModel *model = self.dataArray[index];
    self.desc.text = model.desc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
