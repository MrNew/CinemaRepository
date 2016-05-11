//
//  AddCollectionViewCell.m
//  News
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "AddCollectionViewCell.h"

@implementation AddCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
    
    
    self.label.frame = self.contentView.bounds;
    self.label.textAlignment = NSTextAlignmentCenter;
    
//    self.label.backgroundColor = COLOR(200, 200, 200, 1);
    self.label.layer.borderWidth = 1;
    self.label.layer.borderColor = COLOR(190, 190, 190, 1).CGColor;
    self.label.layer.cornerRadius = 5;
    self.label.layer.masksToBounds = YES;
    
    self.imageView.frame = CGRectMake(self.contentView.bounds.size.width - self.contentView.bounds.size.height  / 2, 0, self.contentView.bounds.size.height  / 2, self.contentView.bounds.size.height  / 2);
    self.imageView.center = CGPointMake(self.contentView.bounds.size.width - self.contentView.bounds.size.height  / 4, self.contentView.bounds.size.height / 2);
    self.imageView.image = [UIImage imageNamed:@"delete"];
    
    self.imageView.hidden = YES;
    
}




@end
