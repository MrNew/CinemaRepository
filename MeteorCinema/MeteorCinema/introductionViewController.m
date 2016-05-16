//
//  introductionViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/14.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "introductionViewController.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface introductionViewController ()
@property(nonatomic,strong)UIImageView *introimageV;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UITextView *content;
@end

@implementation introductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self xuehuapiaoling];

    
    _introimageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, self.view.center.y/4, 80, 80)];
    _introimageV.layer.cornerRadius = 40;
    _introimageV.layer.masksToBounds = YES;
    _introimageV.backgroundColor = [UIColor greenColor];
    NSURL *url = [NSURL URLWithString:self.comment.userImage];
    [_introimageV sd_setImageWithURL:url];
    [self.view addSubview:_introimageV];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/7+10, _introimageV.frame.origin.y+_introimageV.frame.size.height+10, ScreenWidth/1.5,40)];
    _name.numberOfLines = 4;
    _name.textAlignment = NSTextAlignmentCenter;
    _name.text = self.comment.nickname;
    //[_name sizeToFit];
    
   // _name.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_name];
    
    _content = [[UITextView alloc] initWithFrame:CGRectMake(ScreenWidth/7+10, _name.frame.origin.y+_name.frame.size.height, ScreenWidth/1.5, 300)];
   // _content.numberOfLines = 20;
    _content.font = [UIFont boldSystemFontOfSize:15];
    _content.textAlignment = NSTextAlignmentCenter;
    _content.text = self.comment.content;
     [_content setEditable:NO];
  //  _content.alpha = 0;
    // [_content sizeToFit];
    [_content setUserInteractionEnabled:NO];
    
  //  _content.backgroundColor = [UIColor redColor];
    [self.view addSubview:_content];
    
    //--------------------------雪花定时器-------------------------//

    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(xuehuapiaoling) userInfo:nil repeats:1000];

}



-(void)xuehuapiaoling
{
    int xx= arc4random()%375-10;
    int yy = arc4random()%667-20;
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(xx,0, 35, 32)];
    imageV.image = [UIImage imageNamed:@"iconfont-meiguihua.png"];
    [self.view addSubview:imageV];
    [UIView animateWithDuration:5 animations:^{
        imageV.frame = CGRectMake(xx, yy, 35, 32);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            imageV.frame = CGRectMake(xx, 650, 35, 32);
            
            [imageV removeFromSuperview];
        }];
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
