//
//  CommentViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CommentViewController.h"

#import "UIImageView+WebCache.h"

#define Width self.view.frame.size.width

#define Height (self.view.frame.size.height - 64)

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width / 4, Width / 4)];
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(Width / 2, Height / 7);
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.masksToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@"headHolder"]];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, Height / 10)];
    name.text = self.model.name;
    name.textAlignment = NSTextAlignmentCenter;
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:name];
    name.center = CGPointMake(Width / 2, imageView.frame.origin.y + imageView.frame.size.height + Height / 20);
    
    UITextView * conentText = [[UITextView alloc] initWithFrame:CGRectMake(0, name.frame.origin.y + name.frame.size.height + Height / 20, Width / 5 * 4, Height - name.frame.origin.y + name.frame.size.height)];
    [self.view addSubview:conentText];
    conentText.text = self.model.title;
    conentText.font = [UIFont systemFontOfSize:15];
    conentText.textColor = [UIColor grayColor];
    conentText.center = CGPointMake(Width / 2, conentText.center.y);
    conentText.backgroundColor = self.view.backgroundColor;
    conentText.editable = NO;
    conentText.textAlignment = NSTextAlignmentCenter;
    
    
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
