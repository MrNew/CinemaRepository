//
//  DetailViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "DetailViewController.h"
#import "NetWorkRequestManager.h"
#import "NewsDataBaseUtil.h"
#import "showView.h"
#import "NewsCommentViewController.h"
@interface DetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
   NSInteger isShowStatus;
}
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)showView *showView;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIView *commentView;
@end

@implementation DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [self judgeCollect];
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self network];

    self.view.backgroundColor = [UIColor whiteColor];
    [[NewsDataBaseUtil shareDataBase]creatTable];
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,32,32)];
    [_button setImage:[UIImage imageNamed:@"收藏"] forState: UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:_button];
    [_button addTarget:self action:@selector(collectItem:) forControlEvents:UIControlEventTouchUpInside];
    _showView = [[[NSBundle mainBundle]loadNibNamed:@"showView" owner:nil options:nil]lastObject];
    [self judgeCollect];
}
#pragma mark - 收藏执行方法
-(void)collectItem:(UIButton *)button{
        NSArray *array = [[NewsDataBaseUtil shareDataBase]selectTitle:self.itemTitle];
        if ([array count] == 0) {
            [[NewsDataBaseUtil shareDataBase]insertTitle:self.itemTitle title2:self.title2 image:self.image];
            _showView.label.text = @"已收藏";
        }else{
            [[NewsDataBaseUtil shareDataBase]deletewithTitle:self.itemTitle fromTable:@"collects"];
            _showView.label.text = @"已取消";
        }
        [self.view addSubview:_showView];
        [self judgeCollect];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disappear) userInfo:nil repeats:NO];
    }
/////////
-(void)disappear
{
    [_showView removeFromSuperview];
}
/////////
-(void)judgeCollect
    {
        NSArray *array = [[NewsDataBaseUtil shareDataBase]selectTitle:self.itemTitle];
        if ([array count] == 0) {
            [_button setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        }else{
            [_button setImage:[UIImage imageNamed:@"收藏(1)"] forState:UIControlStateNormal];
        }
    }
#pragma mark - 网络请求
-(void)network{
    [NetWorkRequestManager requestWithType:Get URLString:self.detailAPI parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
dispatch_async(dispatch_get_main_queue(), ^{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight -44 - 64 )];
    [self.view addSubview:self.webView];
//    //3.1
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    //3.2
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    //3.3
//    NSURL *url = [NSURL URLWithString:self.url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [_webView loadData:data MIMEType:[response MIMEType] textEncodingName:[response textEncodingName] baseURL:url];
//    }];
//    //3.4
//    [task resume];
//    _webView.scalesPageToFit = YES;//自适应屏幕的大小
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
                       "</html>",dic[@"content"]];
   
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadHTMLString:htmls baseURL:nil];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    self.webView.scrollView.bounces = NO;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, -70, UIScreenWidth, 70)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, UIScreenWidth, 60)];
    titleLabel.text = dic[@"title"];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, UIScreenWidth, 25)];
    timeLabel.text = dic[@"time"];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:timeLabel];
    [backView addSubview:titleLabel];
    [self.webView.scrollView insertSubview:backView atIndex:0];
    self.webView.scrollView.delegate = self;
    [self initCommentView];

    
});
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - 向上滚动隐藏导航的方法
/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
           [self.navigationController setNavigationBarHidden:YES animated:YES];
     //   self.navigationController.navigationBar.hidden = YES;
      //  self.commentView.frame = CGRectMake(0, UIScreenHeight - 45, UIScreenWidth, 45);
     //   self.commentView.hidden = YES;
        isShowStatus = YES;
        [self setNeedsStatusBarAppearanceUpdate];

    }
    else if (offset < 0){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        isShowStatus = NO;
        [self setNeedsStatusBarAppearanceUpdate];
     //   self.commentView.hidden = NO;//
    }
}
//隐藏状态栏的方法
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden
{
    return isShowStatus;
}
 */
-(void)initCommentView{
    self.commentView = [[UIView alloc]initWithFrame:CGRectMake(0, UIScreenHeight - 44 - 64, UIScreenWidth, 44)];
    _commentView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
    UIView *horizon = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.25)];
    horizon.backgroundColor = [UIColor lightGrayColor];
    [_commentView addSubview:horizon];
    [self.view addSubview:_commentView];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(20, 10, 25, 25);
    [commentButton setImage:[UIImage imageNamed:@"Unknown-2"] forState:UIControlStateNormal];
    [_commentView addSubview:commentButton];
    [commentButton addTarget:self action:@selector(jumpToComment:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 7, 18, 18)];
    label.backgroundColor = [UIColor redColor];
    label.layer.cornerRadius = 9;
    label.layer.masksToBounds = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%ld",self.commentCount];
    [_commentView addSubview:label];
}
-(void)jumpToComment:(UIButton *)btn{
    NewsCommentViewController *comment = [[NewsCommentViewController alloc]init];
    comment.identifier = self.identifier;
    [self.navigationController pushViewController:comment animated:YES];
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
