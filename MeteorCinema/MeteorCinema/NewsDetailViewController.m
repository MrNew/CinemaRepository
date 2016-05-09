//
//  NewsDetailViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "NetWorkRequestManager.h"




//新闻详情
#define ConnectedURL @"http://api.m.mtime.cn/News/Detail.api?newsId="

@interface NewsDetailViewController ()

@property (nonatomic, strong) UIWebView * web;


@property (nonatomic, strong) NSString * headTitle;

@property (nonatomic, strong) NSString * content;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 10)];
    titleLabel.text = self.model.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [self.view addSubview:titleLabel];
    
    
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 49 - titleLabel.frame.size.height - 64)];
    [self.view addSubview:self.web];
    self.web.backgroundColor = [UIColor whiteColor];
    
    [self requestData:self.model.identifier];

    
    
    
    
}


-(void)requestData:(NSInteger)identifier{
    
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"%@%ld",ConnectedURL,identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
       
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.headTitle = [dataDic objectForKey:@"title"];
        self.content = [dataDic objectForKey:@"content"];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            
            self.content = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>%@",self.view.frame.size.width - 20, self.content];
            [self.web loadHTMLString:self.content baseURL:nil];
            
        });
        
        
    } error:^(NSError *error) {
        
        
        
        
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
