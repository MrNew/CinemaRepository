//
//  WorldViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "WorldViewController.h"
#import "BoxViewController.h"
@interface WorldViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrolView;
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,strong)NSString *timeT;
@end

@implementation WorldViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text =@"全球票房榜";
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createVC];
    [self initWith_segment];
    [self createScrolView];
    
    [self scrollViewDidEndScrollingAnimation:self.scrolView];
}
-(void)initWith_segment{
    _seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"北美",@"香港", @"日本", @"韩国", @"台湾", @"内地",  nil]];
    _seg.frame = CGRectMake(0, 0, UIScreenWidth, 35);
    _seg.tintColor = [UIColor clearColor];
    //修改_segment 的字体的默认颜色与选中颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[UIColor blackColor] colorWithAlphaComponent:0.7],NSForegroundColorAttributeName,  [UIFont fontWithName:@"Helvetica" size:16] ,NSFontAttributeName,nil];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:237/255.0 green:17/255.0 blue:74/255.0 alpha:1],NSForegroundColorAttributeName,  [UIFont fontWithName:@"Helvetica-bold" size:16] ,NSFontAttributeName,nil];
    [_seg setTitleTextAttributes:dic1 forState:UIControlStateSelected];
    [_seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    _seg.selectedSegmentIndex = 0;
    [self.view addSubview:_seg];
    [_seg addTarget:self action:@selector(do_seg:) forControlEvents:UIControlEventValueChanged];
}
///////////
-(void)createScrolView{
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, UIScreenWidth, UIScreenHeight-64-35)];
    [self.view addSubview:self.scrolView];
    self.scrolView.contentSize = CGSizeMake(UIScreenWidth*6, 0);
    self.scrolView.pagingEnabled = YES;
    self.scrolView.bounces = NO;
    self.scrolView.delegate = self;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/UIScreenWidth;
    UIViewController *willShowVC = self.childViewControllers[index];
    if ([willShowVC isViewLoaded])return;
    willShowVC.view.frame = CGRectMake(offsetX, 0, UIScreenWidth, UIScreenHeight-64-35);
    [self.scrolView addSubview:willShowVC.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    _seg.selectedSegmentIndex = scrollView.contentOffset.x/UIScreenWidth;
}
#pragma mark - _seg执行方法
-(void)do_seg:(UISegmentedControl *)segment{
    [self.scrolView setContentOffset:CGPointMake(segment.selectedSegmentIndex *UIScreenWidth , 0)  animated:YES];
}

-(void)createVC{
    
    BoxViewController *tab1 = [BoxViewController initWithString:@"2015"];
    BoxViewController *tab2 = [BoxViewController initWithString:@"2016"];
    BoxViewController *tab3 = [BoxViewController initWithString:@"2017"];
    BoxViewController *tab4 = [BoxViewController initWithString:@"2018"];
    BoxViewController *tab5 = [BoxViewController initWithString:@"2019"];
    BoxViewController *tab6 = [BoxViewController initWithString:@"2020"];
    [self addChildViewController:tab1];
    [self addChildViewController:tab2];
    [self addChildViewController:tab3];
    [self addChildViewController:tab4];
    [self addChildViewController:tab5];
    [self addChildViewController:tab6];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareFor_segue:(UIStoryboard_segue *)_segue sender:(id)sender {
    // Get the new view controller using [_segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
