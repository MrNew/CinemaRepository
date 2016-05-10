//
//  LocationViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

// 城市数据
#import "CityMessage.h"

@protocol LocationViewControllerDelegate <NSObject>

-(void)passLocationCity:(CityMessage *)city;

@end


@interface LocationViewController : UIViewController

//
//@property (nonatomic, strong) NSString * location;

// 代理传值
@property (nonatomic, weak) id < LocationViewControllerDelegate > delegate;





@end
