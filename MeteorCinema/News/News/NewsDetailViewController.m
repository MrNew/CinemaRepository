//
//  NewsDetailViewController.m
//  News
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "NetWorkRequestManager.h"

#define NewsDetailURL @"http://news.roboo.com/news/detailJson.htm?id=%@&index=%@"

#import "BottomView.h"


// 数据库
#import "DataBaseUtil.h"

@interface NewsDetailViewController () < UIWebViewDelegate >

@property (nonatomic, strong) UIWebView * web;

@end

@implementation NewsDetailViewController

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<!-- 顶部 start  -->" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@"<!-- 顶部 end  -->" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBack:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:nil];
    
//    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 15 )];
//    titleView.backgroundColor = COLOR(240, 240, 240, 1);
//    [self.web addSubview:titleView];
//    
//    UIButton * backButton = [UIButton buttonWithType: UIButtonTypeCustom];
//    backButton.frame = CGRectMake(0, 20, titleView.frame.size.height / 2 , titleView.frame.size.height / 2);
//    backButton.center = CGPointMake(titleView.frame.size.height / 1.5, titleView.frame.size.height / 2 );
//    [titleView addSubview:backButton];
//    [backButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(returnBack:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    shareButton.frame = CGRectMake(0, 20, titleView.frame.size.height / 2 , titleView.frame.size.height / 2 );
//    shareButton.center = CGPointMake(titleView.frame.size.width / 15 * 14, titleView.frame.size.height / 2 );
//    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [titleView addSubview:shareButton];
    
    NSString * scanStyle = [[NSUserDefaults standardUserDefaults] objectForKey:@"scaneStyle"];
    if ([scanStyle isEqualToString:@"有痕模式"]) {
        if (self.news) {
            if (![[DataBaseUtil share] isContentNewsWith:@"history" WithTitle:self.news.title]) {
                [[DataBaseUtil share] insertTableWithName:@"history" withNews:self.news];
            }
            
        }else if (self.searchNews){
            if (![[DataBaseUtil share] isContentNewsWith:@"history" WithTitle:self.searchNews.title]) {
                [[DataBaseUtil share] insertTableWithName:@"history" withSearchNews:self.searchNews];
            }
        }
        
    }
    
//    NSLog(@"%@",self.news);
//    
//    NSLog(@"%@",self.searchNews);
    
    
    
    
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, - 49, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.web.delegate = self;

    [self.view addSubview:self.web];
    self.web.scrollView.bounces = NO;
    
//    NSLog(@"%@",self.news.link);

    if (self.news) {
        [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:NewsDetailURL,self.news.identifier,self.news.index] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
            
            
            NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSString * string = [dataDic objectForKey:@"detailPath"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSURL * url = [NSURL URLWithString:string];
                
               
                NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
                
//                NSURL * url1 = [NSURL URLWithString:str];
                
//                NSString *tempString = [NSString stringWithFormat:
//                                        @"var testa = document.getElementByclass('top-main');"
//                                        "testa.parentNode.removeChild(testa)"];
//                [self.web stringByEvaluatingJavaScriptFromString:tempString];
                
                NSURLRequest * request = [NSURLRequest requestWithURL:url];
//                str = [self filterHTML:str];
                
                NSLog(@"%@",str);
//                [self.web loadHTMLString:str baseURL:nil];
                
                [self.web loadRequest:request];
                
            });
            
            
        } error:^(NSError *error) {
            
        }];
    }else{
        //
//        NSLog(@"%@",self.searchNews.link);
        NSURL * url = [NSURL URLWithString:self.searchNews.link];
        
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        [self.web loadRequest:request];
    }
    
    self.web.scrollView.showsVerticalScrollIndicator = NO;
    
//    self.web.paginationMode = UIWebPaginationModeLeftToRight;
    // 交互(是否允许键盘出现)模式
//    self.web.keyboardDisplayRequiresUserAction = NO;
    // 是否设置缩放到适合屏幕大小
    self.web.scalesPageToFit = YES;
//    设置某些数据变为链接形式，这个枚举可以设置如电话号，地址，邮箱等转化为链接
    self.web.dataDetectorTypes = UIDataDetectorTypeAll;

    
    




//[self.web stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
// "script.type = 'text/javascript';"
// "script.text = \"function myFunction() { "
// "var field = document.getElementsByName('q')[0];"
// "field.value='朱祁林';"
// "document.forms[0].submit();"
// "}\";"
// "document.getElementsByTagName('head')[0].appendChild(script);"];
//[self.web stringByEvaluatingJavaScriptFromString:@"myFunction();"];



    
    UISwipeGestureRecognizer * left =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gogogo:)];
    
    [self.web addGestureRecognizer:left];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer * right =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gogogo:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.web addGestureRecognizer:right];
    
    

    
    
    BottomView * refresh = [[BottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 11 * 10 - 64 - 15, ScreenWidth, ScreenHeight / 11 + 15)];
    refresh.backgroundColor = COLOR(250, 250, 250, 1);
    
    [self.view addSubview:refresh];
    
    
    [refresh.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [refresh.reflashButton addTarget:self action:@selector(refreshButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [refresh.goForwardButton addTarget:self action:@selector(goForwardButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [refresh.collectionButton addTarget:self action:@selector(collectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [refresh.collectionButton setImage:[UIImage imageNamed:@"shoucang-0"] forState:UIControlStateNormal];
    if ([[DataBaseUtil share] isContentNewsWith:@"collection" WithTitle:self.news.title]) {
        
        [refresh.collectionButton setImage:[UIImage imageNamed:@"shoucang-1"] forState:UIControlStateNormal];
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]){
        // 设置 网页背景色
        NSString *js =@"window.onload = function(){"
        
        "document.body.style.backgroundColor = 'gray';"
        
        
        "}";
        
        [self.web stringByEvaluatingJavaScriptFromString:js];
        
        refresh.backgroundColor = [UIColor grayColor];
        self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    }
    
}


-(void)returnBack:(UIButton *)button{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}


-(void)gogogo:(UISwipeGestureRecognizer *)swip{
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.web goForward];
    }else if (swip.direction == UISwipeGestureRecognizerDirectionRight){
        [self.web goBack];
    }
}




-(void)backButton:(UIButton *)button{
    [self.web goBack];
}


-(void)refreshButton:(UIButton *)button{
    [self.web reload];
}

-(void)goForwardButton:(UIButton *)button{
    [self.web goForward];
}

-(void)collectionButton:(UIButton *)button{
   
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
  
    if (![[DataBaseUtil share] isContentNewsWith:@"collection" WithTitle:self.news.title]) {
        
          
            [button setImage:[UIImage imageNamed:@"shoucang-1"] forState:UIControlStateNormal];
        
        if (self.news) {
                [[DataBaseUtil share] insertTableWithName:@"collection" withNews:self.news];
        }else if (self.searchNews){
                [[DataBaseUtil share] insertTableWithName:@"collection" withSearchNews:self.searchNews];
        }
        
        
        
        
        [alert setTitle:@"收藏成功"];
    }else{
            [[DataBaseUtil share] deleteTableWithName:@"collection" WithTitle:self.news.title];
            [button setImage:[UIImage imageNamed:@"shoucang-0"] forState:UIControlStateNormal];
        [alert setTitle:@"取消收藏"];
    }
    
    [self presentViewController:alert animated:YES completion:^{
       [alert dismissViewControllerAnimated:YES completion:^{
           
       }];
    }];
    
    
}

#pragma mark- 通过javaScript操作web数据
- (NSString*)stringByEvaluatingJavaScriptFromString:(NSString*)script{
    
    
    return @"document.getElementsByTagName('body')[0].style.background='gray'";
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
