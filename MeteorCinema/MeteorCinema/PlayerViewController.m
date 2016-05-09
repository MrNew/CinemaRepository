//
//  PlayerViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "PlayerViewController.h"

#import "TabBarViewController.h"

#import "LMVideoPlayerOperationView.h"

@interface PlayerViewController ()

@property (nonatomic, strong) LMVideoPlayerOperationView *playView;

@end

@implementation PlayerViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];


    [(TabBarViewController *)self.tabBarController hidenBottomView];
    self.tabBarController.tabBar.hidden = YES;
    


   
    
}

-(void)viewWillDisappear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;
    
    [(TabBarViewController *)self.tabBarController showBottonView];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    // 退出画面后停止播放
    [self.playView dismiss];
    
    
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    

    
    
    _playView = [[LMVideoPlayerOperationView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 5, self.view.frame.size.width, self.view.bounds.size.height / 3) videoURLString:self.URLString];
    [_playView play];
//    [_playView fullScreenButtonClick];
    [self.view addSubview:_playView];
    
    
    
    UIButton * backButton = [UIButton buttonWithType: UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, self.view.bounds.size.width / 8, self.view.bounds.size.width / 8);
    backButton.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 3 * 2);
    [self.view addSubview:backButton];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor colorWithRed:60/255.0 green:50/255.0 blue:23/255.0 alpha:1]];
    backButton.layer.cornerRadius = backButton.frame.size.width / 2;
    backButton.layer.masksToBounds = YES;
    [backButton addTarget:self action:@selector(backButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:backButton belowSubview:_playView];
    
    
    
    
    
    
    
}


-(void)backButtonClik:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
