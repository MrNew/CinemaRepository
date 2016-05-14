//
//  WebViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "WebViewController.h"

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface WebViewController ()
@property(nonatomic,strong)UIWebView *MyWebview;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"暴风影音";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.MyWebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.MyWebview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.MyWebview];
    
        //第一种加载web的方式
    
        //1,创建URL
//        NSURL *url = [NSURL URLWithString:@"http://feature.mtime.cn/mobile/movie/2016/yin6/index.html"];
    NSURL *url = [NSURL URLWithString:@"http:www.baofeng.com"];

        //2,创建一个request
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        //3,加载request
        [_MyWebview loadRequest:request];
    
    
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
