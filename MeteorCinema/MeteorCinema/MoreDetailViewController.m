//
//  MoreDetailViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/8.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MoreDetailViewController.h"

#import "TabBarViewController.h"

#import "NetWorkRequestManager.h"

#define MoreURL @"http://api.m.mtime.cn/Movie/MoreDetail.api?MovieId="

@interface MoreDetailViewController () < UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, strong) NSString * timeString;

@property (nonatomic, strong) NSArray * nameArray;

@property (nonatomic, strong) NSString * captureDateString;

@property (nonatomic, strong) NSString * languageString;

@property (nonatomic, strong) NSArray * releaseListArray;


@end

@implementation MoreDetailViewController

-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
    }
    return _tableView;
}


-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
    [(TabBarViewController *)self.tabBarController hidenBottomView];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self requestData:self.identifier];
}


-(void)requestData:(NSInteger)identifier{




    NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",MoreURL,identifier]);

    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"%@%ld",MoreURL,identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {



        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.timeString = [dic objectForKey:@"length"];
        
        self.nameArray = [dic objectForKey:@"name"];
        
        self.languageString = [dic objectForKey:@"language"];
        
        self.captureDateString = [dic objectForKey:@"captureDate"];
        
//        NSLog(@"%@",self.captureDateString);
        self.captureDateString = [self.captureDateString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        self.releaseListArray = [dic objectForKey:@"releaseList"];
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.view addSubview:self.tableView];
            
            
            
            
        });
        
        
    } error:^(NSError *error) {
        
    }];

    
    
    
}

#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.nameArray.count;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }else{
        return self.releaseListArray.count;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"暂无信息";
    if (indexPath.section == 0) {
        if (self.nameArray.count > 0) {
            
            cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
        }else{
            cell.textLabel.text = @"没有其他中文名了";
        }
        
    }else if (indexPath.section == 1){
        if (self.timeString.length > 0) {
            cell.textLabel.text = self.timeString;
            
        }else{
//            cell.textLabel.textLabel = @"暂无信息";
        }
    }else if (indexPath.section == 2){
        if (self.captureDateString.length >0) {
            cell.textLabel.text = self.captureDateString;
            
        }else{
//            cell.textLabel.text =
        }
    }else if (indexPath.section == 3){
        if (self.languageString.length > 0) {
            cell.textLabel.text = self.languageString;
        }
    }else{
        NSDictionary * dic = [self.releaseListArray objectAtIndex:indexPath.row];
        NSString *string = [dic objectForKey:@"locationCn"];
        if (string.length > 0) {
            cell.textLabel.text = string;
        }
        
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
       return @"更多中文名";
        
    }else if (section == 1){
        return @"片长";
    }else if (section == 2){
        return @"拍摄日期";
    }else if (section == 3){
        return @"对白语言";
    }else{
      return @"放映地点";
    }
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
