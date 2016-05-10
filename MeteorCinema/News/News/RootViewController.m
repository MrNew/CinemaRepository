
//  RootViewController.m
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "RootViewController.h"

#import "AddCollectionViewController.h"

#import "NewsViewController.h"

#import "BaseButton.h"

@interface RootViewController () < UIScrollViewDelegate,AddCollectionViewControllerDelegate >

// 总的scrollView
@property (nonatomic, strong) UIScrollView * scrollView;

// 总的ViewController控制 数组
@property (nonatomic, strong) NSMutableArray * controllerArray;


@end



@implementation RootViewController

-(InformationBar *)info{
    if (!_info) {
        self.info = [[InformationBar alloc] init];
    }
    return _info;
}


// 懒加载
-(NSMutableArray *)boardArray{
    if (!_boardArray) {
        self.boardArray = [NSMutableArray array];
        
    }
    return _boardArray;
}

-(NSMutableArray *)controllerArray{
    if (!_controllerArray) {
        self.controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSArray * array = [user objectForKey:@"board"];
    [self.boardArray removeAllObjects];
    [self.boardArray addObjectsFromArray:array];
    if (self.boardArray.count == 0) {
        self.boardArray = [NSMutableArray arrayWithObjects:@"热点",@"国内",@"科技数码",@"互联网+",@"it公司", nil];
    }
    
    
    
    // 创建信息栏
    [self createInfo];
    // 创建 scrollView
    [self createScrollView];
    // 创建 子控制器
//    self.controllerArray = [self createChildViewController:self.boardArray withScrollView:self.scrollView];
    for (NSString * string in self.boardArray) {
        NewsViewController * vc =  [self createChildViewController:string];
        [self.controllerArray addObject:vc];
    }
    
    
    
    //
    NewsViewController * zero = _controllerArray[0];
    [self.scrollView addSubview:zero.view];
    
    
    // 添加info 的按钮点击方法
    for (BaseButton * button in self.info.array) {
        [button addTarget:self action:@selector(buttonControlChild:) forControlEvents:UIControlEventTouchUpInside];
    }
  
    
}

-(void)buttonControlChild:(BaseButton *)button{
    CGPoint point = self.scrollView.contentOffset;
    point.x = ScreenWidth * button.tag;
    
        self.scrollView.contentOffset = point;
    // 记录翻到的页面
    NSInteger flage = point.x / ScreenWidth;
//    NewsViewController * news = _controllerArray[flage];
    
    // 需要设置 页面的大小
    NewsViewController * vc = [self fineNewsControllerAtArray:self.controllerArray withPage:flage withboardArray:self.boardArray];
    [self setFrameForChildViewController:vc WithPage:flage WithScrollView:self.scrollView];
    [self.scrollView addSubview:vc.view];
    
    
}



#pragma mark- 创建scrollview并创建对应的ViewController
-(void)createScrollView{
    
    self.scrollView.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight - 50);
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * _boardArray.count, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    
    
    [self.view addSubview:self.scrollView];
    
    
    
   
}


// 创建 newsvc
-(NewsViewController *)createChildViewController:(NSString *)boardName{
    NewsViewController * news = [[NewsViewController alloc] init];
    news.view.backgroundColor = COLOR(arc4random()%250, arc4random()%250, arc4random()%250, 1);
    news.boardString = boardName;
    [news updata];
    
    
    [self addChildViewController:news];
    
    return news;
}


// 设置某个 vc 的fram
-(void)setFrameForChildViewController:(NewsViewController *)vc WithPage:(NSInteger)page WithScrollView:(UIScrollView *)scrollView{
    
    vc.view.frame = CGRectMake(ScreenWidth * page, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    
}

// 更新数组内容
// 删除不需要的视图,并调整视图在数组的位置
-(NSMutableArray *)refreshViewController:(NSMutableArray <NewsViewController *>*)vcArray WithBoardArray:(NSArray <NSString *> *)boardArray{
    
    NSMutableArray * name = [NSMutableArray array];
    
    for (NSInteger i = vcArray.count - 1; i >= 0; i--) {
        NewsViewController * vc = vcArray[i];
        if (![boardArray containsObject:vc.boardString]) {
            [vcArray removeObject:vc];
        }else{
            [name addObject:vc.boardString];
        }
    }
    
    for (NSString * string in boardArray) {
        if (![name containsObject:string]) {
            NewsViewController * vc = [self createChildViewController:string];
            [vcArray addObject:vc];
        }
    }
    return vcArray;
    
}

// 根据页数在 controllerArray 中找到响应的controller
-(NewsViewController *)fineNewsControllerAtArray:(NSMutableArray <NewsViewController *>*)vcArray withPage:(NSInteger)page withboardArray:(NSMutableArray *)boardArray{
    
    NSString * name = boardArray[page];
    
    
    for (NewsViewController * vc in vcArray) {
        if ([name isEqualToString:vc.boardString]) {
            return vc;
        }
    }
    return nil;
}


// 移动 版块
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    NSInteger page = scrollView.contentOffset.x / ScreenWidth;
    
    CGPoint point =  self.info.moveView.center;
    
    for (int i = 0; i < self.boardArray.count; i++) {
        BaseButton * button = self.info.array[i];
        if (i == page) {
            [button setTitleColor:COLOR(17, 73, 218, 1) forState:UIControlStateNormal];
            
            point.x = self.info.frame.size.height * 2.5 * page + self.info.frame.size.height * 2.5 / 2;
            [UIView animateWithDuration:0.25 animations:^{
                
                self.info.moveView.center = point;
                
            }];
            [self setMoveViewCenter:button];

            
        }else{
            [button setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
        }
    }
    
    NewsViewController * vc = [self fineNewsControllerAtArray:self.controllerArray withPage:page withboardArray:self.boardArray];
    [self setFrameForChildViewController:vc WithPage:page WithScrollView:self.scrollView];
    [self.scrollView addSubview:vc.view];

    
    
}

-(void)setMoveViewCenter:(UIButton *)button{

    //修改偏移量
    CGFloat offSetX = button.center.x - button.frame.size.width * 3 / 2;
    if (offSetX < 0) {
        offSetX = 0;
    }
    
    CGFloat maxOffSetX = self.info.scrollView.contentSize.width  - button.frame.size.width * 2.5;
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    
    [self.info.scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    
}




#pragma mark- 创建info
-(void)createInfo{
    self.info.frame = CGRectMake(0, 0, ScreenWidth, 50 );

    [self.info.addButton addTarget:self action:@selector(addBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.info addCategory:self.boardArray];
    
    NSLog(@"%@",self.boardArray);
    
    [self.view addSubview:self.info];
}


-(void)addBoard{
    
//    AddViewController * vc = [[AddViewController alloc] init];
    UICollectionViewFlowLayout * layout = [self createUICollectionViewFlowLayout];
    AddCollectionViewController * vc = [[AddCollectionViewController alloc] initWithCollectionViewLayout:layout];
    vc.delegate = self;
    [vc.boardArray removeAllObjects];
    vc.boardArray = self.boardArray;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setValue:self.boardArray forKey:@"board"];
    
    
    
    UINavigationController * na = [[UINavigationController alloc] initWithRootViewController:vc];
    
    na.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:na animated:YES completion:^{
    }];

}



-(UICollectionViewFlowLayout *)createUICollectionViewFlowLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(100, 30);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return layout;
}

-(void)passboardArray:(NSArray *)boardArray{
    [self.boardArray removeAllObjects];
    [self.boardArray addObjectsFromArray:boardArray];
    
    
    

    NSLog(@"%@",self.boardArray);
    
    [self.info deleteCategory];
    self.info.scrollView.contentSize = CGSizeMake(0, 0);
    [self createInfo];
    [self createScrollView];
    
    // 添加info 的按钮点击方法
    for (BaseButton * button in self.info.array) {
        [button addTarget:self action:@selector(buttonControlChild:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (NewsViewController * vc in self.controllerArray) {
        vc.view.frame = CGRectMake(0, - ScreenHeight, 0, 0);
        
    }

    NSLog(@"%@",self.controllerArray);
    
    
    self.controllerArray = [self refreshViewController:self.controllerArray WithBoardArray:self.boardArray];
    
    NSLog(@"%@",self.controllerArray);
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    self.info.moveView.center = CGPointMake(self.info.frame.size.height * 2.5 / 2, self.info.frame.size.height / 2);
    NewsViewController * zero = self.controllerArray[0];
    zero.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:zero.view];
   
    
 
    
}


-(void)refresh:(NSArray *)boardArray{
    [self.boardArray removeAllObjects];
    
    [self.boardArray addObjectsFromArray:boardArray];
    
    NSLog(@"%@",self.boardArray);
    
    [self.info deleteCategory];
    self.info.scrollView.contentSize = CGSizeMake(0, 0);
    [self createInfo];
    [self createScrollView];
    
    // 添加info 的按钮点击方法
    for (BaseButton * button in self.info.array) {
        [button addTarget:self action:@selector(buttonControlChild:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (NewsViewController * vc in self.controllerArray) {
        vc.view.frame = CGRectMake(0, - ScreenHeight, 0, 0);
        
    }
    
    NSLog(@"%@",self.controllerArray);
    
    
    self.controllerArray = [self refreshViewController:self.controllerArray WithBoardArray:self.boardArray];
    
    NSLog(@"%@",self.controllerArray);
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    self.info.moveView.center = CGPointMake(self.info.frame.size.height * 2.5 / 2, self.info.frame.size.height / 2);
    NewsViewController * zero = self.controllerArray[0];
    zero.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:zero.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
