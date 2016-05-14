//
//  TabBarViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TabBarViewController.h"
#import "MovieViewController.h"
#import "CinemaViewController.h"
#import "FindViewController.h"
#import "MySelfViewControllrt.h"
#import "NavigationViewController.h"

@interface TabBarViewController ()

@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *selectedArray;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCustonTabBar];
    MovieViewController *moviVC = [[MovieViewController alloc] init];
    NavigationViewController *moviNav = [[NavigationViewController alloc] initWithRootViewController:moviVC];
    
    CinemaViewController *cinemaVC = [[CinemaViewController alloc] init];
    NavigationViewController *cinemaNav = [[NavigationViewController alloc] initWithRootViewController:cinemaVC];
    
    FindViewController *findVC = [[FindViewController alloc] init];
    NavigationViewController *findNav = [[NavigationViewController alloc] initWithRootViewController:findVC];
    
    MySelfViewControllrt *MyselfVC = [[MySelfViewControllrt alloc] init];
    NavigationViewController *MyselfNav = [[NavigationViewController alloc] initWithRootViewController:MyselfVC];
    self.view.layer.borderColor = [UIColor clearColor].CGColor;
    self.view.layer.borderWidth = 0.001;
    self.viewControllers = [NSArray arrayWithObjects:moviNav,cinemaNav,findNav,MyselfNav, nil];
    [[UITabBar appearance]setTranslucent:NO];
    //取消半透明
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //统一设置导航栏颜色
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:237/255.0 green:17/255.0 blue:74/255.0 alpha:1]];
    
}
-(void)initCustonTabBar
{
    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreenHeight-49, UIScreenWidth, 49)];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    _tabBarView.layer.borderColor = [UIColor grayColor].CGColor;
    _tabBarView.layer.borderWidth = 0.3;
    [self.view addSubview:_tabBarView];
    
    //因为要自定义item,这里使用buttom替代item
    //存放item上图片的数组
    self.array = [NSArray arrayWithObjects:@"电影(2)",@"影院(1)",@"发现_)(1)",@"我的(1)", nil];
    self.selectedArray = [NSArray arrayWithObjects:@"电影(1)",@"影院",@"发现_)",@"我的", nil];

    NSArray *arrayName = [NSArray arrayWithObjects:@"电影",@"影院",@"发现",@"我的", nil];
    
    for (int i = 0; i<4; i++) {
         _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(UIScreenWidth*i/4, 0,UIScreenWidth/4,49);
        _button.tag = i+1;//self.view.tag默认是0,所以一般不从0开始
        [_button addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchDown];
        [_button setTitle:arrayName[i] forState:UIControlStateNormal];
        //文字大小
        _button.titleLabel.font = [UIFont systemFontOfSize:10.0];
        
        //图标位置
        [_button setImageEdgeInsets:UIEdgeInsetsMake(0, 18, 5, 0)];
        //调整文字在按钮中的位置
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, -32, -35, 2)];
        [_tabBarView addSubview:_button];
        if (i == 0) {
             [_button setImage:[UIImage imageNamed:_selectedArray[0]] forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else{
            [_button setImage:[UIImage imageNamed:_array[i]] forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }


}

-(void)selectedItem:(UIButton *)button
{
    for (UIButton *btn in _tabBarView.subviews) {
        [btn setImage:[UIImage imageNamed:_array[btn.tag - 1]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }
    [button setImage:[UIImage imageNamed:_selectedArray[button.tag - 1]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    if (button.tag == 1) {
        self.selectedViewController = self.viewControllers[0];
    }else if (button.tag == 2){
        self.selectedViewController = self.viewControllers[1];
        button.hidden = NO;
    }else if (button.tag == 3){
        self.selectedViewController = self.viewControllers[2];
    }else if (button.tag == 4){
        self.selectedViewController = self.viewControllers[3];
    }
}




-(void)tabbarChangebuttonWith:(NSInteger)index{
    
    for (UIButton *btn in _tabBarView.subviews) {
//        [btn setImage:[UIImage imageNamed:_array[index]] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        if (btn.tag == index + 1) {
            
            [btn setImage:[UIImage imageNamed:_selectedArray[index]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else if (btn.tag == 3 + 1){
            [btn setImage:[UIImage imageNamed:_array[3]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else if (btn.tag == 0 + 1){
            [btn setImage:[UIImage imageNamed:_array[0]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
     self.selectedViewController = self.viewControllers[index];
    
    
}







-(void)hidenBottomView{
    [self.view sendSubviewToBack:self.tabBarView];
}

-(void)showBottonView{
    [self.view bringSubviewToFront:self.tabBarView];
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
