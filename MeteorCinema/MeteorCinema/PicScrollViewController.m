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
@end
@implementation PicScrollViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithRed:237/255.0 green:17/255.0 blue:74/255.0 alpha:1];
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
        self.navigationItem.leftBarButtonItem.customView.hidden = NO;
        self.bottomLabel .hidden = NO;
        self.desc.hidden = NO;
        self.button.hidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
       [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        self.navigationItem.leftBarButtonItem.customView.hidden = YES;
        self.bottomLabel .hidden = YES;
        self.desc.hidden = YES;
        self.button.hidden = YES;
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
            self.picScroll.contentSize = CGSizeMake(UIScreenWidth*self.dataArray.count, 0);
            self.picScroll.pagingEnabled = YES;
            self.picScroll.bounces = NO;
            self.picScroll.delegate = self;
            Tool *tool = [[Tool alloc]init];
            for (int i = 0; i < self.dataArray.count; i++) {
                PicModel *models = self.dataArray[i];
                CGFloat imageHeight = [tool getImageHeight:models.url1];
                self.picScroll.frame = CGRectMake(0, 0, UIScreenWidth, imageHeight);
                self.picScroll.center = CGPointMake(UIScreenWidth/2, UIScreenHeight/2 - 64);
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*i, 0, UIScreenWidth, imageHeight)];
                [self.picScroll addSubview:imageV];
                [imageV sd_setImageWithURL:[NSURL URLWithString:models.url1]];
            }
            ////////////
            CGFloat labHeight = [tool getLabelHeight:self.newsTitle font:[UIFont boldSystemFontOfSize:17]];
            CGFloat labelHeight = [tool getLabelHeight:self.descTitle font:[UIFont systemFontOfSize:14]];
            self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenHeight - labelHeight - labHeight - 12 - 64 - 49, UIScreenWidth, labHeight)];
            self.bottomLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [self.view addSubview:self.bottomLabel];
            self.bottomLabel.font = [UIFont boldSystemFontOfSize:17];
            self.bottomLabel.textColor = [UIColor whiteColor];
            self.bottomLabel.text = self.newsTitle;
            ////////////
            self.desc = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenHeight - labelHeight -10 - 64 - 49, UIScreenWidth, labelHeight + 3)];
            self.desc.font = [UIFont systemFontOfSize:14];
            self.desc.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
            self.desc.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            [self.view addSubview:self.desc];
            self.desc.text = self.descTitle;
            self.desc.numberOfLines = 0;

//            NSDictionary *attribute = @{NSFontAttributeName:self.desc.font};
//            CGSize size = [self.desc.text boundingRectWithSize:CGSizeMake(UIScreenWidth, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
//            self.desc.frame = CGRectMake(0, UIScreenHeight*2/3+25, size.width, size.height);
            //////
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            _button.frame = CGRectMake(UIScreenWidth - 80, UIScreenHeight - 100, 80, 20);
            [self.view addSubview:_button];
            _button.backgroundColor =  [[UIColor blackColor]colorWithAlphaComponent:0.3];
            _button.titleLabel.font = [UIFont systemFontOfSize:14];
            [_button setTitle:@"查看全文" forState: UIControlStateNormal];
            [_button addTarget:self action:@selector(doJump:) forControlEvents:UIControlEventTouchUpInside];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - button
-(void)doJump:(UIButton *)btn{
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.detailAPI = self.picAPI;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
