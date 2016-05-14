//
//  introductionViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/14.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feature.h"
#import "Comment.h"
@protocol introductionViewControllerDelegate <NSObject>

@end
@interface introductionViewController : UIViewController
@property(nonatomic,strong)feature *fear;
@property(nonatomic,strong)Comment *comment;


@property(nonatomic,assign)id<introductionViewControllerDelegate>delegate;
@end
