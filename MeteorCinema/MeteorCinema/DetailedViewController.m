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
#import "featureTableViewCell.h"
#import "CommentTableViewCell.h"
#import "introductionViewController.h"

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface DetailedViewController ()<UITableViewDataSource,UITableViewDelegate,introductionViewControllerDelegate>
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
   // _DetailedViewController.contentSize =CGSizeMake(ScreenWidth, ScreenHeight*3);
   // _DetailedViewController.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_DetailedViewController];
}
//数据接口
-(void)requestData
{
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Cinema/Detail.api?cinemaId=%ld",(long)self.cinemaIdNUM] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
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
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"http://api.m.mtime.cn/Cinema/Comment.api?cinemaId=%ld&pageIndex=1",(long)self.cinemaIdNUM] parDic:@{@"client":@"1"} HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
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
            
            //  self.ScrollViewController.contentSize = CGSizeMake(ScreenWidth,self.SendcondTabelView.frame.origin.y + 80*self.studioDataArray.count+110);
            
            [self featureAndTableView];
            
            self.DetailedViewController.contentSize = CGSizeMake(ScreenWidth,self.featureTableView.frame.origin.y+self.featureTableView.bounds.size.height);
            
             
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
        _imageVCinema = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth/5)/(ScreenWidth/5)+10, 60, 120, 170)];
        NSURL *urltwo = [NSURL URLWithString:detailed.image];
        [_imageVCinema sd_setImageWithURL:urltwo];
        [_DetailedViewController addSubview:_imageVCinema];
        
        //标题
        _titiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageVCinema.frame.origin.x+_imageVCinema.frame.size.width, 60,200, 80)];
        _titiLabel.text = detailed.name;
        _titiLabel.numberOfLines = 4;
       // [_titiLabel sizeToFit];
        _titiLabel.font = [UIFont boldSystemFontOfSize:25];//系统25号字加粗效果
       // _titiLabel.textColor = [UIColor whiteColor];
        
       // _titiLabel.backgroundColor = [UIColor orangeColor];
        [_DetailedViewController addSubview:_titiLabel];
        
        //影厅数量
        _hallCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageVCinema.frame.origin.x+_imageVCinema.frame.size.width+10, 130, 20, 35)];
        NSString *hallstr = [NSString stringWithFormat:@"%@",detailed.hallCount];
        _hallCountLabel.text = hallstr;
        _hallCountLabel.textAlignment = NSTextAlignmentCenter;
        //_hallCountLabel.backgroundColor = [UIColor redColor];
        [_DetailedViewController addSubview:_hallCountLabel];
        
        //几个影厅
        UILabel *hallLabel =[[UILabel alloc] initWithFrame:CGRectMake(_hallCountLabel.frame.origin.x+_hallCountLabel.frame.size.width, 130, 80, 35)];
        hallLabel.text = @"个影厅";
        
      //  hallLabel.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:hallLabel];
        
        
        
        
        
        UILabel *Viewingeffect =[[UILabel alloc] initWithFrame:CGRectMake(_imageVCinema.frame.origin.x+_imageVCinema.frame.size.width+10, 170, 80, 35)];
        Viewingeffect.text = @"观影效果:";
        
        // Viewingeffect.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:Viewingeffect];
        
        UILabel *General =[[UILabel alloc] initWithFrame:CGRectMake(Viewingeffect.frame.origin.x+Viewingeffect.frame.size.width-5, 170, 40, 35)];
        General.text = @"一般";
        General.textColor = [UIColor orangeColor];
        //General.backgroundColor = [UIColor brownColor];
        [_DetailedViewController addSubview:General];
        
        
        UILabel *ServiceQuality =[[UILabel alloc] initWithFrame:CGRectMake(_imageVCinema.frame.origin.x+_imageVCinema.frame.size.width+10, Viewingeffect.frame.origin.y+Viewingeffect.frame.size.height, 80, 35)];
        ServiceQuality.text = @"服务质量:";
        
        // ServiceQuality.backgroundColor = [UIColor greenColor];
        [_DetailedViewController addSubview:ServiceQuality];
        
        UILabel *Generaltwo =[[UILabel alloc] initWithFrame:CGRectMake(Viewingeffect.frame.origin.x+Viewingeffect.frame.size.width-5, Viewingeffect.frame.origin.y+Viewingeffect.frame.size.height, 40, 35)];
        Generaltwo.text = @"一般";
        Generaltwo.textColor = [UIColor orangeColor];
        //Generaltwo.backgroundColor = [UIColor purpleColor];
        [_DetailedViewController addSubview:Generaltwo];
        
        
        
      
        
        
        //详细地址
        UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 80)];
     //   addressView.backgroundColor = [UIColor purpleColor];
        [_DetailedViewController addSubview:addressView];
        
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 35, 35)];
        addImage.image = [UIImage imageNamed:@"dizhizhi"];
      //  addImage.backgroundColor = [UIColor grayColor];
        [addressView addSubview:addImage];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(addImage.frame.origin.x+addImage.frame.size.width+20, 20, ScreenWidth-(addImage.frame.origin.x+addImage.frame.size.width+20), 50)];
        _addressLabel.numberOfLines = 4;
     //   _addressLabel.backgroundColor = [UIColor blueColor];
        _addressLabel.text = detailed.address;
        [addressView addSubview:_addressLabel];
        
//**************************分割线**************************//
    
             UIView *Partition = [[UIView alloc] initWithFrame:CGRectMake(70, 310, ScreenWidth, 1)];
            Partition.alpha = 0.4;
            Partition.backgroundColor = [UIColor grayColor];
            [_DetailedViewController addSubview:Partition];
        
        UIView *Partition2 = [[UIView alloc] initWithFrame:CGRectMake(0, 380, ScreenWidth, 10)];
        Partition2.alpha = 0.4;
        Partition2.backgroundColor = [UIColor grayColor];
        [_DetailedViewController addSubview:Partition2];
        
        
        
        
        //电话号码
        UIView *telLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 80)];
     //   telLabelView.backgroundColor = [UIColor cyanColor];
        [_DetailedViewController addSubview:telLabelView];
        
        
        UIImageView *addImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 35, 35)];
        addImage2.image = [UIImage imageNamed:@"dianhuahua"];
      //  addImage2.backgroundColor = [UIColor greenColor];
        [telLabelView addSubview:addImage2];
        
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 300, 40)];
        _telLabel.font = [UIFont boldSystemFontOfSize:25];//系统25号字加粗效果
       // _telLabel.backgroundColor = [UIColor redColor];
        _telLabel.text = detailed.tel;
        [telLabelView addSubview:_telLabel];
        
        
    }
    
}

//特色模块
-(void)featureAndTableView
{
    _featureTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth,self.featureTableView.frame.origin.y+100*self.featureDataArray.count+110*self.CommentDataArray.count+200) style:UITableViewStylePlain];
    
    _featureTableView.delegate = self;
    _featureTableView.dataSource = self;
    
    _featureTableView.scrollEnabled = NO;
    
  //  _featureTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    static NSString *identifier2  =@"cell";
    
    
    
    if (indexPath.section == 0) {
        
        
        
        
        
        
        
        featureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        //如果没有获取到标示符  就创建一个新的cell
        
        if (cell==nil) {
            
            
            
            cell = [[featureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
        }
        
        for (feature *feat in self.featureDataArray) {
            
            
            
            if (indexPath.row == 0 && indexPath.section == 0) {
                
                if (feat.serviceTicketContent.length>0) {
                     cell.allfeatureLabel.text = feat.serviceTicketContent;
                cell.allfeatureImageView.image = [UIImage imageNamed:@"quguan (2)"];
               // cell.allfeatureLabel.numberOfLines = 3;
                }else{
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"quguan (2)"];
                    cell.allfeatureLabel.text = @"无";
                }
               
                
            }else if (indexPath.row == 1 && indexPath.section ==0){
                
               
                if (feat.featureFoodContent.length>2) {
                    cell.allfeatureLabel.text = feat.featureFoodContent;
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"canting"];
                //    cell.allfeatureLabel.numberOfLines = 3;
                }else{
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"canting"];
                    cell.allfeatureLabel.text = @"无";
                }
                
            }else if (indexPath.row == 2 && indexPath.section == 0){
                
                if (feat.feature3DContent.length>0) {
                     cell.allfeatureLabel.text = feat.feature3DContent;
                cell.allfeatureImageView.image = [UIImage imageNamed:@"3D-1"];
               // cell.allfeatureLabel.numberOfLines = 3;
                }else{
                    
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"3D-1"];
                    cell.allfeatureLabel.text = @"无";
                }
                
               
                
            }else if (indexPath.row == 3 && indexPath.section == 0){
                
                if (feat.featureLeisureContent.length>0) {
                    cell.allfeatureLabel.text = feat.featureLeisureContent;
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"yingyuanyuan"];
                  //  cell.allfeatureLabel.numberOfLines = 3;
                }else{
                     cell.allfeatureImageView.image = [UIImage imageNamed:@"yingyuanyuan"];
                    cell.allfeatureLabel.text = @"无";
                }
                
                
            }else if (indexPath.row == 4 && indexPath.section == 0){
                
                if (feat.featureParkContent.length>0) {
                    cell.allfeatureLabel.text = feat.featureParkContent;
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"tingche"];
                 //   cell.allfeatureLabel.numberOfLines = 3;
                }else{
                    cell.allfeatureImageView.image = [UIImage imageNamed:@"tingche"];
                    cell.allfeatureLabel.text = @"无";
                }
            }else{
                
              cell.allfeatureLabel.text = @"无";
    
                
            }
        }
        
    
        cell.userInteractionEnabled = NO;
        return cell;
        
        
    }else  {
        
        CommentTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        
        if (cell == nil) {
            
            cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier2];
            
            }
        
        if (indexPath.section == 1) {
            
            Comment *comm = [self.CommentDataArray objectAtIndex:indexPath.row];
            
            cell.imageView.layer.cornerRadius = 30;
            
            cell.imageView.layer.masksToBounds = YES;
            
            NSURL *url = [NSURL URLWithString:comm.userImage];
            
            [cell.userImageView sd_setImageWithURL:url];
            
            
            
            cell.nicknameLabel.text = comm.nickname;
            
            cell.ccontentLabel.text = comm.content;
            
        }
        
    
        
  
        
        
        return cell;
        
    }
}


//控制行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 110;
    }
    
}

//点击cell执行的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"你点了第%ld分区的第%ld行",indexPath.section+1,indexPath.row+1);
    
    introductionViewController *introduc = [[introductionViewController alloc] init];
    introduc.delegate = self;
    
    introduc.comment = [self.CommentDataArray objectAtIndex:indexPath.row];
  
    
    
    [self.navigationController pushViewController:introduc animated:YES];
    
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
  //  view.backgroundColor = [UIColor greenColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    //label.backgroundColor = [UIColor yellowColor];
    [view addSubview:label];
    
    if (section == 0) {
        label.text =@"特色设施";
        label.font = [UIFont boldSystemFontOfSize:20];
    }else if (section == 1){
        label.text = @"网友评论";
        label.font = [UIFont boldSystemFontOfSize:20];
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
