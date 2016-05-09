//
//  SecondViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
#import "MovIs.h"
#import "studio.h"
@protocol SecondViewControllerDelegate <NSObject>

@end
@interface SecondViewController : UIViewController



//写个属性接收传过来的值 直接传一部电影过来
@property(nonatomic,strong)Cinema *cinamea;
//@property(nonatomic,strong)MovIs *movis;




//@property(nonatomic,strong)NSString *titlee;//标题
//@property(nonatomic,strong)NSString *length;//多少分钟
//@property(nonatomic,strong)NSString *type;//电影类型
//@property(nonatomic,strong)NSString *img;//图片

@property(nonatomic,assign)NSInteger cinemaIdtwo;//影院ID

@property(nonatomic,assign)id<SecondViewControllerDelegate>delegate;
@end
