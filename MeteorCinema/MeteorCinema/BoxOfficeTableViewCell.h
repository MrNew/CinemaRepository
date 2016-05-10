//
//  BoxOfficeTableViewCell.h
//  MeteorCinema
//
//  Created by mcl on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxOfficeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImageV;
@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *nameEn;
@property (weak, nonatomic) IBOutlet UILabel *weekBoxOffice;
@property (weak, nonatomic) IBOutlet UILabel *totalBoxOffice;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UIButton *buy;

@end
