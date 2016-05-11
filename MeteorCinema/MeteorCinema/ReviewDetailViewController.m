//
//  ReviewDetailViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/9.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "ReviewDetailViewController.h"
#import "NetWorkRequestManager.h"
#import "UIImageView+WebCache.h"
@interface ReviewDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *content;
@end

@implementation ReviewDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self detailNetwork];
}
//
-(void)detailNetwork{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Review/Detail.api?reviewId=%ld",self.identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.content = dic[@"content"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-size:15px;}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "</body>"
                               "</html>",self.content];
            self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64)];
            self.webView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:self.webView];
            [self.webView loadHTMLString:htmls baseURL:nil];
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(UIScreenHeight/3-20, 0, 0, 0);
            self.webView.scrollView.bounces = NO;
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, -UIScreenHeight/3+20, UIScreenWidth - 20, UIScreenHeight/3-20)];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight/9)];
            titleLabel.text = dic[@"title"];
            titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
            NSLog(@"=ff==%@",titleLabel.text);
            titleLabel.numberOfLines = 2;
            [backView addSubview:titleLabel];
            UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, UIScreenHeight/9 + 5, 50, 50)];
            userImage.layer.cornerRadius = 25;
            userImage.layer.masksToBounds = YES;
            [userImage sd_setImageWithURL:[NSURL URLWithString:dic[@"userImage"]]];
            [backView addSubview:userImage];
        UILabel *nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, UIScreenHeight/9 + 5, 200, 20)];
            nickNameLabel.text = dic[@"nickname"];
            nickNameLabel.font = [UIFont systemFontOfSize:15];
            [backView addSubview:nickNameLabel];
        UILabel *movieName = [[UILabel alloc]initWithFrame:CGRectMake(68,UIScreenHeight/9 + 30,100, 20)];
            movieName.textColor = [UIColor darkGrayColor];
            movieName.font = [UIFont systemFontOfSize:15];
          movieName.text = [[@"评《" stringByAppendingString:dic[@"relatedObj"][@"title"]] stringByAppendingString:@"》   "];
            [movieName sizeToFit];
            [backView addSubview:movieName];
        UILabel *rating = [[UILabel alloc]initWithFrame:CGRectMake(movieName.frame.origin.x + movieName.frame.size.width , UIScreenHeight/9 + 30, 30, 20)];
            rating.textAlignment = NSTextAlignmentCenter;
            rating.backgroundColor =  [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            rating.text = dic[@"rating"];
            [backView addSubview:rating];
        UIImageView *poster = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth - 95, UIScreenHeight/9, 70, 110)];
            [poster sd_setImageWithURL:[NSURL URLWithString:dic[@"relatedObj"][@"image"]]];
            [backView addSubview:poster];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, UIScreenHeight/3 - 70, 150, 50)];
            timeLabel.text = dic[@"time"];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.font = [UIFont systemFontOfSize:14];
            [backView addSubview:timeLabel];
            UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(10, UIScreenHeight/9 + 75, UIScreenWidth - 105, 0.5)];
            horizontal.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
            [backView addSubview:horizontal];
            [self.webView.scrollView insertSubview:backView atIndex:0];
        });
    } error:nil];
    
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
