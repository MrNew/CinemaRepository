//
//  MovieViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieViewController.h"

#import "LocationViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"广州" style:UIBarButtonItemStylePlain target:self action:@selector(selectorLocation:)];
    
    
    
}

-(void)selectorLocation:(UIButton *)button{
    
    LocationViewController * location = [[LocationViewController alloc] init];
    
    
    
    [self.navigationController pushViewController:location animated:YES];
    
    
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
