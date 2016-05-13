//
//  MovieWebViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieWebViewController.h"

@interface MovieWebViewController () < UIWebViewDelegate >

@property (nonatomic, strong) UIWebView * web;

@end

@implementation MovieWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
    [self.view addSubview:self.web];
    self.web.delegate = self;
    self.web.backgroundColor = [UIColor whiteColor];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.head.url]];
    [self.web loadRequest:request];
    
    
    NSString * string = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.head.url] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",string);
    
    self.web.scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, self.view.bounds.size.width, 50)];
    label.text = self.head.title;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.web.scrollView insertSubview:label atIndex:0];


    // 是否使用内置播放器播放视频
    self.web.allowsInlineMediaPlayback = YES;
    // 视频是否制动播放
    self.web.mediaPlaybackRequiresUserAction = YES;
    
    // 是否支持 air player 音频播放器
    self.web.mediaPlaybackAllowsAirPlay = YES;
    
    
    
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 需要在执行完 加载数据后删除(某一段数据,例如广告)
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('mod_app_top_btn')[0].style.display = 'none'"];
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
