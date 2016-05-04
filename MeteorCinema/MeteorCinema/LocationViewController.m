//
//  LocationViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "LocationViewController.h"


#define ScreenWidth [

@interface LocationViewController () < UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UITableView * allCityTableView;

@property (nonatomic, strong) UITableView * searchTableView;

@end

@implementation LocationViewController


-(UITableView *)TableView{
    if (!_allCityTableView) {
        self.allCityTableView = [[UITableView alloc] init];
    }
    return _allCityTableView;
}


-(UITableView *)searchTableView{
    if (!_searchTableView) {
        self.searchTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _searchTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    
    
    self.allCityTableView.frame = CGRectMake(0, 0, 375, 100);
    [self.view addSubview:self.allCityTableView];
    self.allCityTableView.backgroundColor = [UIColor redColor];
    
    
}

-(void)backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
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
