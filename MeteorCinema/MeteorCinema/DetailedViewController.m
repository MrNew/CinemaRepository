//
//  DetailedViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

/*
 @property(nonatomic,strong)NSString *image;//影院图片
 @property(nonatomic,strong)NSString *name;//影院名
 @property(nonatomic,strong)NSString *hallCount;//影厅数量
 @property(nonatomic,strong)NSString *address;//地址
 @property(nonatomic,strong)NSString *tel;//电话号码
 @property(nonatomic,strong)NSString *rating;//评分
 @property(nonatomic,strong)NSString *open;//开放时间
 */

#import "DetailedViewController.h"
#import "RoundView.h"
#import "NetWorkRequestManager.h"
#import "Detailed.h"
#import "feature.h"
#import "Comment.h"
#import "UIImageView+WebCache.h"

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface DetailedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *DetailedViewController;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)NSMutableArray *DetailedDataArray;
@property(nonatomic,strong)NSMutableArray *featureDataArray;
@property(nonatomic,strong)NSMutableArray *CommentDataArray;

@property(nonatomic,strong)UITableView *featureTableView;


@property(nonatomic,strong)UIImageView *imageVCinema;//影院图片
@property(nonatomic,strong)UILabel *titiLabel;//标题名
@property(nonatomic,strong)UILabel *hallCountLabel;//影厅数量
@property(nonatomic,strong)UILabel *addressLabel;//观影地址
@property(nonatomic,strong)UILabel *telLabel;//电话号码
@property(nonatomic,strong)UILabel *ratingLabel;//影评
@property(nonatomic,strong)UILabel *open;//开放时间

@end

@implementation DetailedViewController
//头界面的数组
-(NSMutableArray *)DetailedDataArray
{
    if (!_DetailedDataArray) {
        
        self.DetailedDataArray = [NSMutableArray array];
    }
    return _DetailedDataArray;
}
//特色设施的数组
-(NSMutableArray *)featureDataArray
{
    if (!_featureDataArray) {
        
        self.featureDataArray = [NSMutableArray array];
    }
    return _featureDataArray;
}
//评论区的数组
-(NSMutableArray *)CommentDataArray
{
    if (!_CommentDataArray) {
        
        self.CommentDataArray = [NSMutableArray array];
    }
    return _CommentDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self DetailedWithViewController];
    [self DetailedModules];
    [self requestData];
    [self featureAndTableView];
    [self CommentrequestData];
}
#pragma -mark UIScrollViewController
-(void)DetailedWithViewController
{
    _DetailedViewController = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _DetailedViewController.contentSize =CGSizeMake(ScreenWidth, ScreenHeight*3);
    _DetailedViewController.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_DetailedViewController];
}
//数据接口
-(void)requestData
{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Cinema/Detail.api?cinemaId=%ld",self.cinemaIdNUM] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //头界面的解析
        Detailed *send = [[Detailed alloc] init];
        [send setValuesForKeysWithDictionary:diction];
        [self.DetailedDataArray addObject:send];
        //特色设施的解析
        NSDictionary *featureDic = [diction objectForKey:@"feature"];
        feature *feat = [[feature alloc] init];
        [feat setValuesForKeysWithDictionary:featureDic];
        [self.featureDataArray addObject:feat];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self DetailedModules];
            [_featureTableView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
}
//
//
////评论区解析
-(void)CommentrequestData
{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Cinema/Comment.api?cinemaId=%ld&pageIndex=1",self.cinemaIdNUM] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        //对专递过来的数据进行解析
        NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        NSArray *listArray = [diction objectForKey:@"list"];
        
        for (NSDictionary *Commentdic in listArray) {
            Comment *com = [[Comment alloc] init];
            [com setValuesForKeysWithDictionary:Commentdic];
            
            [self.CommentDataArray addObject:com];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_featureTableView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
}

#pragma -maek详情模块
-(void)DetailedModules
{
    
    
    for (Detailed *detailed in self.DetailedDataArray) {
        
        
        
        //大图
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        self.imageView.alpha = 0.6;
        //_imageView.image = [UIImage imageNamed:@"q2.jpg"];
        NSURL *url = [NSURL URLWithString:detailed.image];
        [self.imageView sd_setImageWithURL:url];
        [_DetailedViewController addSubview:_imageView];
        
        //切割线
        RoundView *view = [[RoundView alloc] initWithFrame:CGRectMake(0, 110, ScreenWidth, 170)];
        //  view.backgroundColor = [UIColor brownColor];
        [self.imageView addSubview:view];
        
        //毛玻璃效果
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        //visualView.backgroundColor = [UIColor redColor];
        visualView.frame = self.imageView.frame;
        visualView.alpha = 0.4;
        [_imageView addSubview:visualView];
        
        //影院图片
        _imageVCinema = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60, 120, 150)];
        NSURL *urltwo = [NSURL URLWithString:detailed.image];
        [_imageVCinema sd_setImageWithURL:urltwo];
        [_DetailedViewController addSubview:_imageVCinema];
        
        //标题
        _titiLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 80, 250, 35)];
        _titiLabel.text = detailed.name;
        //[_titiLabel sizeToFit];
        _titiLabel.font = [UIFont boldSystemFontOfSize:25];//系统25号字加粗效果
        _titiLabel.textColor = [UIColor whiteColor];
        
        _titiLabel.backgroundColor = [UIColor orangeColor];
        [_DetailedViewController addSubview:_titiLabel];
        
        //影厅数量
        _hallCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 130, 50, 35)];
        NSString *hallstr = [NSString stringWithFormat:@"%@",detailed.hallCount];
        _hallCountLabel.text = hallstr;
        _hallCountLabel.backgroundColor = [UIColor redColor];
        [_DetailedViewController addSubview:_hallCountLabel];
        
        //几个影厅
        UILabel *hallLabel =[[UILabel alloc] initWithFrame:CGRectMake(220, 130, 80, 35)];
        hallLabel.text = @"个影厅";
        
        hallLabel.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:hallLabel];
        
        
        
        
        
        UILabel *Viewingeffect =[[UILabel alloc] initWithFrame:CGRectMake(160, 170, 80, 35)];
        Viewingeffect.text = @"观影效果:";
        
        // Viewingeffect.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:Viewingeffect];
        
        UILabel *General =[[UILabel alloc] initWithFrame:CGRectMake(233, 170, 40, 35)];
        General.text = @"一般";
        General.textColor = [UIColor orangeColor];
        //General.backgroundColor = [UIColor brownColor];
        [_DetailedViewController addSubview:General];
        
        
        UILabel *ServiceQuality =[[UILabel alloc] initWithFrame:CGRectMake(280, 170, 80, 35)];
        ServiceQuality.text = @"服务质量:";
        
        // ServiceQuality.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:ServiceQuality];
        
        UILabel *Generaltwo =[[UILabel alloc] initWithFrame:CGRectMake(353, 170, 40, 35)];
        Generaltwo.text = @"一般";
        Generaltwo.textColor = [UIColor orangeColor];
        //Generaltwo.backgroundColor = [UIColor purpleColor];
        [_DetailedViewController addSubview:Generaltwo];
        
        //详细地址
        UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 80)];
        addressView.backgroundColor = [UIColor purpleColor];
        [_DetailedViewController addSubview:addressView];
        
        _addressLabel = [[UILabel alloc] initWithFrame:addressView.bounds];
        _addressLabel.numberOfLines = 4;
        _addressLabel.text = detailed.address;
        [addressView addSubview:_addressLabel];
        
        
        //电话号码
        UIView *telLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 80)];
        telLabelView.backgroundColor = [UIColor cyanColor];
        [_DetailedViewController addSubview:telLabelView];
        
        _telLabel = [[UILabel alloc] initWithFrame:telLabelView.bounds];
        _telLabel.font = [UIFont boldSystemFontOfSize:25];//系统25号字加粗效果
        _telLabel.text = detailed.tel;
        [telLabelView addSubview:_telLabel];
        
        
    }
    
}

//特色模块
-(void)featureAndTableView
{
    _featureTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 380, ScreenWidth, _DetailedViewController.frame.size.height+1500) style:UITableViewStylePlain];
    
    _featureTableView.delegate = self;
    _featureTableView.dataSource = self;
    
    _featureTableView.scrollEnabled = NO;
    
    _featureTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_DetailedViewController addSubview:_featureTableView];
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //必须与数组长度结合
    if (section == 0) {
        return  5;
    }else{
        return self.CommentDataArray.count;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建静态标示符
    static NSString *identifier  =@"cell";
    //根据标示符  从重用池取出一个cell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果没有获取到标示符  就创建一个新的cell
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    for (feature *feat in self.featureDataArray) {
        
        if (indexPath.row == 0 && indexPath.section == 0) {
            cell.textLabel.text = feat.serviceTicketContent;
            cell.textLabel.numberOfLines = 3;
        }else if (indexPath.row == 1 && indexPath.section ==0){
            cell.textLabel.text = feat.featureFoodContent;
            cell.textLabel.numberOfLines = 3;
        }else if (indexPath.row == 2 && indexPath.section == 0){
            cell.textLabel.text = feat.feature3DContent;
            cell.textLabel.numberOfLines = 3;
        }else if (indexPath.row == 3 && indexPath.section == 0){
            cell.textLabel.text = feat.featureLeisureContent;
            cell.textLabel.numberOfLines = 3;
        }else if (indexPath.row == 4 && indexPath.section == 0){
            cell.textLabel.text = feat.featureParkContent;
            cell.textLabel.numberOfLines = 3;
        }else if (indexPath.row == 5 && indexPath.section == 0){
            cell.textLabel.text = feat.featureVIPContent;
            cell.textLabel.numberOfLines = 3;
        }else{
            //        cell.textLabel.text = feat.featureGameContent;
            //        cell.textLabel.numberOfLines = 3;
        }
    }
    
    
    
    
    if (indexPath.section == 1) {
        Comment *comm = [self.CommentDataArray objectAtIndex:indexPath.row];
        cell.imageView.layer.cornerRadius = 30;
        cell.imageView.layer.masksToBounds = YES;
        NSURL *url = [NSURL URLWithString:comm.userImage];
        [cell.imageView sd_setImageWithURL:url];
        
        cell.textLabel.text = comm.nickname;
        cell.detailTextLabel.text = comm.content;
        
        
    }
    
    
    
    
    
    
    cell.backgroundColor = [UIColor grayColor];
    
    // 右边小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType =UITableViewCellAccessoryDetailButton;
    
    
    return cell;
    
    
}

//控制行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

//点击cell执行的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你点了第%ld分区的第%ld行",indexPath.section+1,indexPath.row+1);
    
}

//控制分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//分区高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
    
}

//分区标题
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return @"呵呵";
//    }else if (section == 1){
//        return @"哒哒";
//    }else {
//        return @"嚒嚒";
//    }
//
//}
//自定义分区
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    view.backgroundColor = [UIColor greenColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.backgroundColor = [UIColor yellowColor];
    [view addSubview:label];
    
    if (section == 0) {
        label.text =@"特色设施";
    }else if (section == 1){
        label.text = @"评论区";
    }else{
        label.text = @"滴滴哒";
        
    }
    return view;
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"你点了第%ld分区的第%ld行的辅助视图",indexPath.section+1,indexPath.row+1);
    
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
