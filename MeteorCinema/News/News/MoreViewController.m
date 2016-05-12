//
//  MoreViewController.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "MoreViewController.h"

#import "WaterView.h"

#import "WaterWaveView.h"

#import "UIImageView+WebCache.h"

#import "SDImageCache.h"



@interface MoreViewController () < WaterWaveViewDelegate >

@property (nonatomic, strong) WaterView * waterView;

@property (nonatomic, strong) WaterWaveView * water;

@property (nonatomic, strong) UIButton * button;

@end

@implementation MoreViewController

-(WaterView *)waterView{
    if (!_waterView) {
        self.waterView = [[WaterView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3)];
    }
    return _waterView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR(240, 240, 240, 1);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSLog(@"%@",string);
    
    CGFloat caches = [self folderSizeAtPath:string];
    NSLog(@"%0.2f",caches);
    
    if (caches > 10) {
        self.water = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3) WithAppearType:AppearTypeDefault WithdENDPercent:0.8];
        
    }else if(caches < 5){
        self.water = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3) WithAppearType:AppearTypeDefault WithdENDPercent:0.2];
        
    }else{
        self.water = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3) WithAppearType:AppearTypeDefault WithdENDPercent:0.2 + (caches - 5) / 5 * 0.6];
    }
    
    [self.view addSubview:self.water];
    [self.water starAnimation];
    self.water.changeHeight = 0.5;
    self.water.delegate = self;
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 100, 30);
    self.button.layer.cornerRadius = 5;
    self.button.layer.masksToBounds = YES;
    
    [self.view addSubview:self.button];
    
    self.button.backgroundColor = COLOR(60, 130, 190, 0.9);
    
    
    
    
//    NSString * string = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
////    NSLog(@"%@",string);
//    
//    CGFloat caches = [self folderSizeAtPath:string];
//    NSLog(@"%0.2f",caches);
    if (caches > 0) {
        
        [self.button setTitle:[NSString stringWithFormat:@"  狠心清除%0.2fM缓存  ",caches] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(cleanCache) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.button setTitle:@"  暂无缓存  " forState:UIControlStateNormal];
    }
    [self.button sizeToFit];
    self.button.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 4 * 3);
//
//    if (caches > 10) {
//        self.water = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3) WithAppearType:AppearTypeDefault WithdENDPercent:0.8];
//        
//    }else{
//        self.water = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth , ScreenHeight / 4 * 3) WithAppearType:AppearTypeDefault WithdENDPercent:caches / 10];
//        
//    }
//    
//    [self.view addSubview:self.water];
//    [self.water starAnimation];
//    self.water.changeHeight = 0.5;
//    self.water.delegate = self;
    
}






-(void)cleanCache{

    [self.water stopAnimation];
    self.water.appearType = AppearTypeDown;
    [self.water starAnimation];
    
    
    [[SDImageCache sharedImageCache] clearMemory];
    
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
   
    [fileManager removeItemAtPath:string error:nil];
    
    // 清除缓存 (图片等资源)
    // 无图模式的优化
    
}

// 计算单个文件大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//
//
// 计算目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}






// 代理方法(监听是否 下降完毕)
-(void)didFinishDown:(BOOL)state{
    
    if (state) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"缓存已删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
          
            [alert dismissViewControllerAnimated:YES completion:^{
                
                
                [self.button setTitle:@"  已清除缓存  " forState:UIControlStateNormal];
                [self.button sizeToFit];
                self.button.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 4 * 3);
                
                
                
            }];
        }];
        
        
        
    }else{
        
    }
    
    
}



-(void)backButton:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
