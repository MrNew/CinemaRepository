//
//  PicScrollViewController.m
//  MeteorCinema
//
//  Created by mcl on 16/5/8.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "PicScrollViewController.h"
#import "NetWorkRequestManager.h"
#import "PicModel.h"
#import "UIImageView+WebCache.h"
@interface PicScrollViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *picScroll;
@property(nonatomic,strong)UILabel *bottomLabel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *descTitle;

@end

@implementation PicScrollViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}

-(NSMutableArray *)dataArray{
    if ((!_dataArray)) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
///////////
   
    [self network];
    
}
-(void)initCustonScrollView{
    
}
-(void)network{
    [NetWorkRequestManager requestWithType:Get URLString:self.picAPI parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"images"];
        self.newsTitle = dic[@"title"];
        self.descTitle = array[0][@"desc"];
        for (NSDictionary *dic0 in array) {
            PicModel *model = [[PicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic0];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ////////
            self.picScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight/3)];
            self.picScroll.center = self.view.center;
            [self.view addSubview:self.picScroll];
            self.picScroll.contentSize = CGSizeMake(UIScreenWidth*self.dataArray.count, 0);
            self.picScroll.pagingEnabled = YES;
            self.picScroll.bounces = NO;
            self.picScroll.delegate = self;
            for (int i = 0; i < self.dataArray.count; i++) {
                PicModel *models = self.dataArray[i];
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*i, 0, UIScreenWidth, UIScreenHeight/3)];
                [self.picScroll addSubview:imageV];
                [imageV sd_setImageWithURL:[NSURL URLWithString:models.url1]];
            }
            ////////////
            self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenHeight*2/3, UIScreenWidth, 20)];
            [self.view addSubview:self.bottomLabel];
            self.bottomLabel.font = [UIFont boldSystemFontOfSize:17];
            self.bottomLabel.textColor = [UIColor whiteColor];
            self.bottomLabel.text = self.newsTitle;
            ////////////
            self.desc = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenHeight*2/3+25, UIScreenWidth, UIScreenHeight/3 - 20)];
            self.desc.font = [UIFont systemFontOfSize:14];
            self.desc.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
            [self.view addSubview:self.desc];
            self.desc.text = self.descTitle;
            self.desc.numberOfLines = 0;
           // self.desc.lineBreakMode = NSLineBreakByCharWrapping;
            NSDictionary *attribute = @{NSFontAttributeName:self.desc.font};
            CGSize size = [self.desc.text boundingRectWithSize:CGSizeMake(UIScreenWidth, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
            self.desc.frame = CGRectMake(0, UIScreenHeight*2/3+25, size.width, size.height);
            

        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - scroll 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/UIScreenWidth;
    PicModel *model = self.dataArray[index];
    self.desc.text = model.desc;
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
