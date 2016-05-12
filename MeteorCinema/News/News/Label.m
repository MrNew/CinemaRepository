//
//  Label.m
//  News
//
//  Created by lanou on 16/4/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "Label.h"




@implementation Label


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:20];
        self.frame = frame;
        
    }
    return self;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}






@end
