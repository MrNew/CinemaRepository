//
//  AddCollectionViewController.h
//  News
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCollectionViewControllerDelegate <NSObject>

-(void)passboardArray:(NSArray *)boardArray;

@end


@interface AddCollectionViewController : UICollectionViewController

// 属性传值
@property (nonatomic, strong) NSMutableArray * boardArray;


@property (nonatomic, assign) id < AddCollectionViewControllerDelegate > delegate;

@end
