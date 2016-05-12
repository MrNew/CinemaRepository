//
//  CinemaCollectionViewController.m
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CinemaCollectionViewController.h"
#import "Cinema.h"
#import "CiCollTableViewCell.h"
#import "CinemaDataBaseUtil.h"
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface CinemaCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *cicollTableView;
@property(nonatomic,strong)NSArray *cicollarray;
@end

@implementation CinemaCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"影院收藏夹";
   
    _cicollTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _cicollTableView.delegate = self;
    _cicollTableView.dataSource = self;
    [self.view addSubview:_cicollTableView];
    
    
    self.cicollarray = [[CinemaDataBaseUtil shareDataBase] selectWithCinema];
    
    
}
#pragma -mark UITabelView代理方法
//控制cell的个数 也就是有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //必须与数组长度结合
    return  self.cicollarray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建静态标示符
    static NSString *identifier  =@"cell";
    //根据标示符  从重用池取出一个cell
    
    CiCollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果没有获取到标示符  就创建一个新的cell
    if (cell==nil) {
        
        cell = [[CiCollTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Cinema *cine = [self.cicollarray objectAtIndex:indexPath.row];
    //对cell进行赋值,系统cell只能显示4部分(图片,两个label,一个标识)
    cell.TitleLabel.text = cine.cinameName;
    cell.addressLabel.text = cine.address;
    
    return cell;
    
    
}

//控制行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return  80;
}

//点击cell执行的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma -mark 删除
//点击编辑按钮执行的方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    //打开或关闭table的编辑状态
    [_cicollTableView setEditing:editing animated:animated];
    
}

//是否允许编辑?
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//控制编辑模式(控制删除还是插入)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;//默认删除
    //return UITableViewCellEditingStyleInsert;//插入
    
}

//修改删除按钮的名字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    
}

//控制删除和插入
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    Cinema *cine = [self.cicollarray objectAtIndex:indexPath.row];
    [[CinemaDataBaseUtil shareDataBase] deleteCarWithTitle:cine.cinameName];
    self.cicollarray = [[CinemaDataBaseUtil shareDataBase] selectWithCinema];
     [_cicollTableView reloadData];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
