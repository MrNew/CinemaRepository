//
//  MySelfViewControllrt.m
//  MeteorCinema
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MySelfViewControllrt.h"

#import "BottomView.h"

#import "UIImage+ImageEffects.h"

#import "HotMovieCollectionViewController.h"

@interface MySelfViewControllrt () < UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate >

@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UILabel * headLabel;

//@property (nonatomic, strong) NSMutableArray * array;



// 意见反馈视图
@property (nonatomic, strong) UIView * opinion;


@end

@implementation MySelfViewControllrt

-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self setExtraCellLineHidden:self.tableView];
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor grayColor];
    
//    self.array = [NSMutableArray array];
//    [self.array addObjectsFromArray:@[[UIImage imageNamed:@"myMovie"],[UIImage imageNamed:@"myCiname"],[UIImage imageNamed:@"myShoucang"]]];
//    UIImage * image = [UIImage imageNamed:@"myMovie.png"];
//    [self.array addObject:image];
//    [self.array addObject:[UIImage imageNamed:@"myCiname.png"]];
//    [self.array addObject:[UIImage imageNamed:@"myShoucang.png"]];
    
    [self.view addSubview:self.tableView];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3)];
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, backView.bounds.size.height / 3 * 2)];
    
    UIImage * image3 = [UIImage imageNamed:@"myHead.jpg"];
    
//    image = [image applyExtraLightEffect];
    
    backImageView.image = image3;
    
    //四种模糊效果
    /* [imageClear applyExtraLightEffect];
     [imageClear applyLightEffect];
     [imageClear applyTintEffectWithColor:<#(UIColor *)#>];
     */
    
    
    backImageView.backgroundColor = [UIColor grayColor];
    backImageView.userInteractionEnabled = YES;
    
    [backView addSubview:backImageView];
    
//    UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 80, 80);
    
    self.button.center = CGPointMake(backImageView.bounds.size.width / 2, backImageView.bounds.size.height / 3);
    self.button.layer.cornerRadius = self.button.bounds.size.width / 2;
    self.button.layer.masksToBounds = YES;
    [backImageView addSubview:self.button];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"]) {
        
        UIImage * image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"]];
        [self.button setImage:image forState:UIControlStateNormal];
        self.button.center = CGPointMake(backImageView.bounds.size.width / 2, backImageView.bounds.size.height / 2);
        UIImage * image1 = [UIImage imageNamed:@"changeHead"];
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(buttonClik:)];
        
    }else{
        [self.button setImage:[UIImage imageNamed:@"myHeadIcon"] forState:UIControlStateNormal];
        
        self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backImageView.bounds.size.width / 2, backImageView.bounds.size.height / 3 * 2 )];
        self.headLabel.text = @"选择头像";

        [backImageView addSubview:self.headLabel];
        self.headLabel.textAlignment = NSTextAlignmentCenter;
        self.headLabel.center = CGPointMake(backImageView.bounds.size.width / 2, backImageView.bounds.size.height / 4 * 3);
    }
    
    [self.button addTarget:self action:@selector(buttonClik:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    
    BottomView * secondView = [[BottomView alloc] initWithFrame:CGRectMake(0, backView.bounds.size.height / 3 * 2, self.view.bounds.size.width, backView.bounds.size.height / 3)];
  
    [backView addSubview:secondView];
    
    [secondView.backButton addTarget:self action:@selector(backButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    
    [secondView.reflashButton addTarget:self action:@selector(reflashButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    
    [secondView.goForwardButton addTarget:self action:@selector(goForwardButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.tableView.tableHeaderView = backView;
    
    
}

#pragma mark- bottomView 按钮的方法
-(void)backButtonClik:(UIButton *)button{
    
    
    
    
    
}

-(void)reflashButtonClik:(UIButton *)button{
    
    
    
    
}


-(void)goForwardButtonClik:(UIButton *)button{
    
    
    
}



#pragma mark- 选择头像
-(void)buttonClik:(UIButton *)button{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    // 签代理
    picker.delegate = self;
    // 允许编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // 从字典中取出图片
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    
    
    [self.button setImage:image forState:UIControlStateNormal];
    self.headLabel.text = @"";
    self.button.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 3 / 3 * 2 / 2);
    
    UIImage * image1 = [UIImage imageNamed:@"changeHead"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(buttonClik:)];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSData * data = UIImageJPEGRepresentation(image, 1.0);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headImage"];
    }];
    
}

#pragma mark- 隐藏没内容的cell 的线
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

#pragma mark- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 3;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @[@"我的电影",@"我的影院",@"我的收藏"][indexPath.row];
        
        
        cell.imageView.image = @[[UIImage imageNamed:@"myMovie"],[UIImage imageNamed:@"myCiname"],[UIImage imageNamed:@"myShoucang"]][indexPath.row];
        
        
    }else{
        cell.textLabel.text = @[@"意见反馈",@"设置",@"使用说明"][indexPath.row];
    }
    
    
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:{
                
                // 我的电影
                HotMovieCollectionViewController * hotVC = [[HotMovieCollectionViewController alloc] init];
                
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:hotVC];
                
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
                
                
                
                
                
                
            }
                break;
            case 1:
                
                // 我的影院
                
                
                
                
                break;
            case 2:
                
                // 我的收藏
                
                
                break;
            default:
                break;
        }
        
        
        
        
    }else{
        
        switch (indexPath.row) {
            case 0:{
                
                self.tableView.userInteractionEnabled = NO;
                
                
                
                self.opinion = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 2, self.view.bounds.size.height / 2)];
                self.opinion.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2.5);
                self.opinion.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
                 [self.view addSubview:self.opinion];
                self.opinion.layer.cornerRadius = 5;
                self.opinion.layer.masksToBounds = YES;
                
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.opinion.frame.size.width, self.opinion.frame.size.height / 8)];
                label.text = @"意见反馈";
                label.textAlignment = NSTextAlignmentCenter;
                [self.opinion addSubview:label];
                
                
                UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.opinion.frame.size.height / 8, self.opinion.frame.size.width, self.opinion.frame.size.height / 8 * 6)];
                [self.opinion addSubview:textView];
                textView.backgroundColor = [UIColor grayColor];
                textView.text = @"为了更好的服务各位用户，有以下想法的，可以在愉快的使用本软件。\n\n  一、对软件存在的漏洞,不符合用户使用的设置、请及时提出批评指正。\n  二、对本软件的各项发展提出宝贵的建议。\n  三、对本软件的质量、使用感受进行评价。\n\n  此外，在您发表您的各种观点的同时，请遵守国家、政府的各项法律法规，文明用语。\n\n  本软件将定期整理集中用户的意见，及时改动软件，以让用户拥有个好的使用感受.\n\n\n  联系方式:13288602793@163.com(小陈)";
        
                textView.editable = NO;
                
                UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
                leftButton.frame = CGRectMake(0, self.opinion.frame.size.height / 8 * 7, self.opinion.frame.size.width / 2, self.opinion.frame.size.height / 8);
                [self.opinion addSubview:leftButton];
                [leftButton setTitle:@"取消" forState:UIControlStateNormal];
                [leftButton addTarget:self action:@selector(dismissButton:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
                rightButton.frame = CGRectMake(self.opinion.frame.size.width / 2, self.opinion.frame.size.height / 8 * 7, self.opinion.frame.size.width / 2, self.opinion.frame.size.height / 8);
                [self.opinion addSubview:rightButton];
                [rightButton setTitle:@"确定" forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(dismissButton:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                
                
                
               
                
            }
                break;
            case 1:
                
                
                
                
                
                break;
            case 2:
                
                
                
                
                
                break;
            default:
                break;
        }
        
    }
    
    
    
}


-(void)dismissButton:(UIButton *)button{
    
    [self.opinion removeFromSuperview];
    self.tableView.userInteractionEnabled = YES;
    
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
