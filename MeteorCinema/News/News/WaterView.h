//
//  WaterView.h
//  News
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WaterView : UIView
//{
//
//float _currentLinePointY;
//
//}

@property (nonatomic, assign) CGFloat currentLinePointY;


-(void)starAnimation;


-(void)stopAnimation;

@end
