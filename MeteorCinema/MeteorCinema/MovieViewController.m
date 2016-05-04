//
//  MovieViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieViewController.h"

#import "LocationViewController.h"

#import "FirsView.h"

@interface MovieViewController () < LocationViewControllerDelegate >

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"广州" style:UIBarButtonItemStylePlain target:self action:@selector(selectorLocation:)];
    
    //***************** 定位的模式 ********************//
    
    // 先判断是否进入 算地点界面
    NSString * locationName = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultLocation"];
    // 判断是否进入选地点的页面
    if (locationName.length > 0) {
        self.navigationItem.leftBarButtonItem.title = locationName;
    }else{
        LocationViewController * location = [[LocationViewController alloc] init];
        
        location.delegate = self;
        
        [self.navigationController pushViewController:location animated:YES];
        
    }
    // 等通知 通知( 比较通知信息 与 原来存的 地点是否吻合来决定是否 更新信息 )
    [self listener];
    
    //***********************前景图*********************//
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [user stringForKey:@"标记"];
    
    if (![string isEqualToString:@"you"]) {
        
        
        FirsView *fir = [[FirsView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
        
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        
        [window addSubview:fir];
        
    }
    
    
    
}

-(void)selectorLocation:(UIButton *)button{
    
    LocationViewController * location = [[LocationViewController alloc] init];
    
    location.delegate = self;
    
    [self.navigationController pushViewController:location animated:YES];
    
    
}


-(void)passLocationCity:(CityMessage *)city{
//    NSLog(@"%@",city.name);
    
    
    
    self.navigationItem.leftBarButtonItem.title = city.name;
}

#pragma mark- 接受 刚获取的地点通知
-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"kNotificationLocation" object:nil];
}


- (void) recvBcast:(NSNotification *)notify
{

    //    static int index;

    //    NSLog(@"recv bcast %d", index++);
    // 取得广播内容

    NSDictionary *dict = [notify userInfo];

    NSString * cityName = [dict objectForKey:@"TureLocation"];

//    self.locationView.cityNaemLabel.text = cityName;

//    [[NSUserDefaults standardUserDefaults] setValue:cityName forKey:@"cityName"];

    // 先判断是否进入 算地点界面
    NSString * locationName = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultLocation"];
  
    if (locationName.length > 0) {
        
        if (![cityName isEqualToString:locationName]) {
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"检测到不是定位城市" message:@"是否切换" preferredStyle:UIAlertControllerStyleAlert];
            
            // 执行相应操作
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action1];
            
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //
                [[NSUserDefaults standardUserDefaults] setValue:cityName forKey:@"defaultLocation"];
                
                self.navigationItem.leftBarButtonItem.title = cityName;
            }];
            [alert addAction:action2];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
    
        }else{
        
    
        }
        
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
