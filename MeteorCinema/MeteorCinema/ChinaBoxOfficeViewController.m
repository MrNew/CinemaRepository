#import "ChinaBoxOfficeViewController.h"
#import "ChinaBoxTableViewCell.h"
#import "NetWorkRequestManager.h"
#import "BoxOfficeModel.h"
#import "UIImageView+WebCache.h"
@interface ChinaBoxOfficeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *timeText;

@end

@implementation ChinaBoxOfficeViewController
#pragma mark - 懒加载数组
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
   self.tabBarController.view.subviews.lastObject.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.view.subviews.lastObject.hidden = NO;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 175;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(175, 0, 0, 0);
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0, -180, UIScreenWidth, 180)];
    UILabel *board = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 45)];
    board.text = @"   内地票房榜";
    board.textColor = [UIColor blackColor];
    board.font = [UIFont fontWithName:@"Helvetica-bold" size:18];
    [content addSubview:board];
    //创建票房统计时间的 label
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, UIScreenWidth, 23)];
    _timeLabel.textColor  = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:13];
        [content addSubview:_timeLabel];
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, 116)];
    pic.image = [UIImage imageNamed:@"11.jpg"];
    [content addSubview:pic];
    [self.tableView insertSubview:content atIndex:0];
}
#pragma mark - 下载网络数据
-(void)loadData{
    [NetWorkRequestManager requestWithType:Get URLString:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=2020&locationId=%7B2%7D" parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.timeText = dic[@"topList"][@"summary"];
        NSLog(@"=%@",self.timeText);
        
        NSArray *array = dic[@"movies"];
        for (NSDictionary *dico in array) {
            BoxOfficeModel *model = [[BoxOfficeModel alloc]init];
            [model setValuesForKeysWithDictionary:dico];
            NSLog(@"%@",model.weekBoxOffice);
            
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeLabel.text = [@"    " stringByAppendingString:self.timeText];
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ChinaBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[ChinaBoxTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    BoxOfficeModel *model = self.dataArray[indexPath.row];
    [cell.poster sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    cell.rating.text = [NSString stringWithFormat:@"%.1f",model.rating];
    
    cell.rank.text = [NSString stringWithFormat:@"%ld",model.rankNum];
    cell.name.text = [model.name stringByAppendingString:@" "];
    cell.nameEn.text = model.nameEn;
    NSString *str = [model.weekBoxOffice stringByReplacingOccurrencesOfString:@"\n" withString:@": "];
    NSString *str1 = [model.totalBoxOffice stringByReplacingOccurrencesOfString:@"\n" withString:@": "];

    cell.weekBox.text = str;
    cell.totalBox.text = str1;
    NSLog(@"%@",cell.totalBox.text);
    cell.director.text = [@"导演: " stringByAppendingString:model.director];
    cell.actor.text = [@"主演: " stringByAppendingString:model.actor];
    cell.releaseTime.text =[ [@"上映日期: " stringByAppendingString:model.releaseDate] stringByAppendingString:@" 中国"];
    return cell;
}

////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
