//
//  AddCollectionViewController.m
//  News
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "AddCollectionViewController.h"

#import "AddCollectionViewCell.h"


@interface AddCollectionViewController ()
// 用来传接过来的 数组
@property (nonatomic, strong) NSMutableArray * board;

@property (nonatomic, strong) NSMutableArray * moreArray;

// section 的控件
@property (nonatomic, strong) UILabel * labelOfSectionOne;

@property (nonatomic, strong) UILabel * labelOfSectionTwo;

@property (nonatomic, strong) UIButton * button;

// 记录 编辑状态
@property (nonatomic, assign) BOOL isEdit;

@end

@implementation AddCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


// 懒加载
-(NSMutableArray *)boardArray{
    if (!_boardArray) {
        self.boardArray = [NSMutableArray array];
        
    }
    return _boardArray;
}

-(NSMutableArray *)board{
 
    if (!_board) {
        _board = [NSMutableArray array];
    }
    return _board;
}

-(NSMutableArray *)moreArray{
    if (!_moreArray) {
        self.moreArray = [NSMutableArray array];

    }
    return _moreArray;
}

-(UILabel *)labelOfSectionOne{
    if (!_labelOfSectionOne) {
        self.labelOfSectionOne = [[UILabel alloc] init];
    }
    return _labelOfSectionOne;
}

-(UILabel *)labelOfSectionTwo{
    if (!_labelOfSectionTwo) {
        self.labelOfSectionTwo = [[UILabel alloc] init];
    }
    return _labelOfSectionTwo;
}

-(UIButton *)button{
    if (!_button) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    return _button;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]) {
        self.view.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    
    // 存进userdefault
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * more = [NSMutableArray array];
    more = [user objectForKey:@"more"];
    
    [self.moreArray removeAllObjects];
    
    [self.moreArray addObjectsFromArray:more];
    
    
    if (!self.moreArray.count) {
        [self.moreArray addObjectsFromArray:@[@"娱乐",@"体育",@"军事",@"跑车推荐",@"财经",@"时事",@"电影",@"人文",@"手机",@"教育",@"健康",@"美食",@"汽车",@"智能家居",@"游戏",@"反腐倡廉"]];
    }
    
    
    
    
    
    
    
    for (NSString * string in self.boardArray) {
        if ([self.moreArray containsObject:string]) {
            [self.moreArray removeObject:string];
        }
    }
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    
//    [self createBackButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    
    self.installsStandardGestureForInteractiveMovement = NO;

    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 60);
    
    
    // Register cell classes
    [self.collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    self.isEdit = NO;
    
  
}

-(void)createBackButton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 15, 32, 32);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)backButton:(UIButton *)button{
    
   
    [self.board addObjectsFromArray:self.boardArray];
    [self.delegate passboardArray:self.board];
    
    
    // 存进 沙盒中
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setValue:self.moreArray forKey:@"more"];
    
    [user setValue:self.board forKey:@"board"];
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}





#pragma mark- collectionView 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        return self.boardArray.count;
    }else{
        return self.moreArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.hidden = YES;
    
    if (indexPath.section == 0) {
        if (self.isEdit) {
            cell.imageView.hidden = NO;
        }else{
            cell.imageView.hidden = YES;
        }
        cell.label.text = _boardArray[indexPath.item];
      
    }else{
        cell.label.text = _moreArray[indexPath.item];
        
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(ScreenWidth - 20, ScreenHeight / 15);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
//        header.backgroundColor = COLOR(205, 220, 254, 1);
    
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]) {
//            header.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//        }else{
//            header.backgroundColor = COLOR(205, 220, 254, 1);
//        }
        
        if (indexPath.section == 0) {
            self.labelOfSectionOne.frame = CGRectMake(10, 0, (ScreenWidth - 20) / 4, ScreenHeight / 15);
            self.labelOfSectionOne.text = @"我的订阅";
            [header addSubview:self.labelOfSectionOne];
            self.button.frame = CGRectMake((ScreenWidth - 20) / 5 * 4, 0, (ScreenWidth - 20) / 4, ScreenHeight / 15);
            
//            [_button setTitle:@"编辑" forState:UIControlStateNormal];
            
            [_button addTarget:self action:@selector(editBoard:) forControlEvents:UIControlEventTouchUpInside];
            
            [_button setBackgroundColor:COLOR(221, 224, 229, 1)];
            [header addSubview:_button];
        }else if(indexPath.section == 1){
            
            self.labelOfSectionTwo.frame = CGRectMake(10, 0, (ScreenWidth - 20) / 5 * 4, ScreenHeight / 15);
            self.labelOfSectionTwo.text = @"更多推荐";
            if (self.moreArray.count == 0) {
                self.labelOfSectionTwo.text = @"老板你订阅了所有版块了";
            }
            [header addSubview:self.labelOfSectionTwo];
            
        }
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]) {
            header.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
            _button.backgroundColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
            
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
            
        }else{
            header.backgroundColor = COLOR(205, 220, 254, 1);
        }
        
        return header;
    }else{
        return nil;
    }
    
}




-(void)editBoard:(UIButton *)button{
    
//    self.installsStandardGestureForInteractiveMovement = YES;
    self.installsStandardGestureForInteractiveMovement = !button.selected;
    if (button.selected) {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"正在编辑" forState:UIControlStateNormal];
        NSLog(@"%d",button.selected);
    }
    
    button.selected = !button.selected;
    self.isEdit = button.selected;

    if (self.boardArray.count == 1) {
        self.installsStandardGestureForInteractiveMovement = NO;
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        
        button.selected = NO;
        
        self.isEdit = NO;
    }
    
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.1 animations:^{
        
    } completion:^(BOOL finished) {
        
        [self.collectionView reloadData];
    }];
    
//    [button sizeToFit];
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [self.boardArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        
    }else if (sourceIndexPath.section == 0 && destinationIndexPath.section == 1){

        if (self.moreArray.count <= sourceIndexPath.item) {
            [self.moreArray addObject:self.boardArray[sourceIndexPath.item]];
        }else{
            
        [self.moreArray insertObject:self.boardArray[sourceIndexPath.item] atIndex:sourceIndexPath.item];
        }
        
        [self.boardArray removeObjectAtIndex:sourceIndexPath.item];
        
    }else if (sourceIndexPath.section == 1 && destinationIndexPath.section == 0){
        
        if (self.boardArray.count <= sourceIndexPath.item) {
            [self.boardArray addObject:self.moreArray[sourceIndexPath.item]];
        }else{
            
            [self.boardArray insertObject:self.moreArray[sourceIndexPath.item] atIndex:sourceIndexPath.item];
        }

        [self.moreArray removeObjectAtIndex:sourceIndexPath.item];
        
        
    }else if (sourceIndexPath.section == 1 && destinationIndexPath.section == 1){
        [self.moreArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
    
    [collectionView reloadData];
    
    if (self.boardArray.count == 1) {
        self.isEdit = NO;
        self.installsStandardGestureForInteractiveMovement = NO;
        [self.button setTitle:@"编辑" forState:UIControlStateNormal];
        self.button.selected = NO;
        
    }
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        [self.boardArray addObject:self.moreArray[indexPath.item]];
        [self.moreArray removeObjectAtIndex:indexPath.item];
    }
    
    if (self.isEdit) {
        if (indexPath.section == 0) {
            [self.moreArray addObject:self.boardArray[indexPath.item]];
            [self.boardArray removeObjectAtIndex:indexPath.item];
        }
    }
    

    [collectionView reloadData];
    
    if (self.boardArray.count == 1) {
        self.isEdit = NO;
        self.installsStandardGestureForInteractiveMovement = NO;
        [self.button setTitle:@"编辑" forState:UIControlStateNormal];
        
        self.button.selected = NO;
    }

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
