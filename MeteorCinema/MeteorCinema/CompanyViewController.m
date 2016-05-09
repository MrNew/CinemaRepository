//
//  CompanyViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/8.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CompanyViewController.h"

#import "TabBarViewController.h"

#import "NetWorkRequestManager.h"

#import "Company.h"



#define CompanyURL @"http://api.m.mtime.cn/Movie/CompanyList.api?MovieId="

@interface CompanyViewController () < UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UITableView * tableView;

// 制作公司数组
@property (nonatomic, strong) NSMutableArray * productionListArray;

// 发行公司数组
@property (nonatomic, strong) NSMutableArray * distributorListArray;

@end

@implementation CompanyViewController

-(NSMutableArray *)productionListArray{
    if (!_productionListArray) {
        self.productionListArray = [NSMutableArray array];
    }
    return _productionListArray;
}


-(NSMutableArray *)distributorListArray{
    if (!_distributorListArray) {
        self.distributorListArray = [NSMutableArray array];
    }
    return _distributorListArray;
}
//-(void)hidenBottomView;
//
//-(void)showBottonView;

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


-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    [(TabBarViewController *)self.tabBarController showBottonView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setExtraCellLineHidden:self.tableView];

    [self.view addSubview:self.tableView];
    
    [self requestData:self.identifier];
    
    
}

#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

-(void)requestData:(NSInteger)identifier{
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",CompanyURL,identifier]);
    [NetWorkRequestManager requestWithType:Get URLString:[NSString stringWithFormat:@"%@%ld",CompanyURL,identifier] parDic:nil HTTPHeader:nil finish:^(NSData *data, NSURLResponse *response) {
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * array1 = [dataDic objectForKey:@"productionList"];
        for (NSDictionary * dic in array1) {
            
            Company * company = [[Company alloc] init];
            
            [company setValuesForKeysWithDictionary:dic];
            
            [self.productionListArray addObject:company];
            
        }
        
        // distributorList
        NSArray * array2 = [dataDic objectForKey:@"distributorList"];
        for (NSDictionary * dic in array2) {
            
            Company * company = [[Company alloc] init];
            
            [company setValuesForKeysWithDictionary:dic];
            
            [self.distributorListArray addObject:company];
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        
    }];
    
    
    
    
}



#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 0;
    
    if (section == 0) {
        return self.productionListArray.count;
    }else{
        return  self.distributorListArray.count;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Company * company = [[Company alloc] init];
    if (indexPath.section == 0) {
        company = [self.productionListArray objectAtIndex:indexPath.row];
    }else{
        company = [self.distributorListArray objectAtIndex:indexPath.row];
    }
    
    NSString * string = company.name;
    if (company.locationName.length > 0) {
        string = [NSString stringWithFormat:@"%@ [ %@ ]",string,company.locationName];
    }
    
    cell.textLabel.text = string;
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"制作公司";
    }else{
        return @"发行公司";
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
