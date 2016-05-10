//
//  FindViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "FindViewController.h"
#import "NewsViewController.h"
#import "TrailerViewController.h"
#import "TopListViewController.h"
#import "ReviewViewController.h"
@interface FindViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UISegmentedControl *seg;
@end

@implementation FindViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNavigation];//导航上面加 segment
    [self addChildViewControllers];
    //创建 scrollview
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的contentSize--可滚动区域
    // 注意这里的width要用屏幕的宽度，因为这时候加载出来的self.contentScrollView.frame.size.width是XIB的初始宽度600.
    // 由于self.view.autoresizingMask的原因使得控制器的view的宽度随着父控制器的frame的改变而改变。所以显示出来以后，self.scrollView.frame.size.width为正常的屏幕的宽度
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth*4, 0);
    //必须写代理
    self.scrollView.delegate = self;
    //默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}
#pragma mark - 添加子控制器
-(void)addChildViewControllers{
    //创建四个控制器
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    TrailerViewController *trailerVC =[[TrailerViewController alloc]init];
    TopListViewController *topVC = [[TopListViewController alloc]init];
    ReviewViewController *reviewVC = [[ReviewViewController alloc]init];
    //添加子控制器
    [self addChildViewController:newsVC];
    [self addChildViewController:trailerVC];
    [self addChildViewController:topVC];
    [self addChildViewController:reviewVC];
}
#pragma mark - 当scrollView结束了滚动动画以后就会调用这个方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat scrollViewWidth = scrollView.frame.size.width;
    CGFloat scrollViewHeight = scrollView.frame.size.height;
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger index = offSetX/scrollViewWidth;
    // 取出需要显示的控制器
    UIViewController *willShowVC = self.childViewControllers[index];
    // 如果当前位置的控制器的view已经显示过了，就直接返回
    if ([willShowVC isViewLoaded]) {
        return;
    }
    //当前控制器的 view 的 frame
    willShowVC.view.frame = CGRectMake(offSetX, 0, scrollViewWidth, scrollViewHeight);
    // 添加控制器的view到contentScrollView中
    [self.scrollView addSubview:willShowVC.view];
}
#pragma mark - 手动拖动scrollView松开后停止减速完毕后才会调用这个方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    _seg.selectedSegmentIndex = scrollView.contentOffset.x/UIScreenWidth;

}
#pragma mark - 导航栏加 segment 的方法
-(void)initNavigation{
    //创建 segment
    _seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"新闻",@"预告片",@"排行榜",@"影评",nil]];
    _seg.frame = CGRectMake(0, 0, UIScreenWidth, 44);
    _seg.tintColor = [UIColor clearColor];
    //修改segment 的字体的默认颜色与选中颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:171/255.0 green:220/255.0 blue:253/255.0 alpha:1],NSForegroundColorAttributeName,  [UIFont fontWithName:@"Helvetica" size:18] ,NSFontAttributeName,nil];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,  [UIFont fontWithName:@"Helvetica-bold" size:18] ,NSFontAttributeName,nil];
    [_seg setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [_seg setTitleTextAttributes:dic forState:UIControlStateNormal];
   // seg.backgroundColor = [UIColor colorWithRed:44/255.0 green:136/255.0 blue:203/255.0 alpha:1];
    _seg.backgroundColor = [UIColor colorWithRed:237/255.0 green:17/255.0 blue:74/255.0 alpha:1];

    _seg.selectedSegmentIndex = 0;//默认第0个被选中
    //添加到导航上面
  //  [self.navigationController.navigationBar addSubview:seg];
    self.navigationItem.titleView = _seg;
    //segment 点击事件
    [_seg addTarget:self action:@selector(doSeg:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark - 选择segment 执行方法
-(void)doSeg:(UISegmentedControl *)segment{
    [self.scrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex *UIScreenWidth , 0)  animated:YES];

}
////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
