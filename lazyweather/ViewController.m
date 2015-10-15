//
//  ViewController.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/7.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "presentViewController.h"
#import "TableViewController2.h"
#import "dataDao.h"
#import "CollectionViewController2.h"
#import "localData.h"
#import "MJRefresh.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview1;
@property (strong, nonatomic) TableViewController *tableview1;
@property (strong,nonatomic) TableViewController2 *tableview2;
@property (strong,nonatomic) NSArray *objects;
@property (strong,nonatomic) UIRefreshControl *rc;
@property (strong,nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController
{
    NSArray *images;
    UIImageView *imageview0;
    CGFloat pianyi;
    UITapGestureRecognizer *gesture2;
    NSMutableArray *picData;
    NSMutableArray *xianshiData;
    NSMutableIndexSet *indexSet;
    NSMutableArray *selected;
    UIView *blackview;
    UIColor *Color1;
    UIColor *Color2;
    UIColor *Color3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //定位服务初始化并弹出用户授权对话框
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    //主页面collectionview初始化，设置代理
    self.collectionview1.frame = CGRectMake(0, 0, 320, 1000);
//    self.collectionview1.backgroundColor = [UIColor colorWithRed:240.0/255 green:128.0/255 blue:128.0/255 alpha:0.7];
    _collectionview1.delegate = self;
    _collectionview1.dataSource = self;
    imageview0 = [[UIImageView alloc]initWithFrame:CGRectMake(85, 145, 150, 150)];
    imageview0.image = [UIImage imageNamed:@"a0"];
    [self.collectionview1 addSubview:imageview0];
    
    //滑动手势初始化设置
    UIPanGestureRecognizer *gesture1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestures1:)];
    [self.view addGestureRecognizer:gesture1];
//    self.collectionview1.userInteractionEnabled=NO;
    
    //点击手势初始化设置
    gesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestures2:)];
    [self.collectionview1 addGestureRecognizer:gesture2];
    [gesture2 setEnabled:NO];
    
    //添加左右页面
    self.tableview1 = [self.storyboard instantiateViewControllerWithIdentifier:@"leftTable"];
    self.tableview1.view.frame = CGRectMake(-40, 0, 320, 568);
    [self.view insertSubview:self.tableview1.view belowSubview:self.collectionview1];
    self.tableview2 = [self.storyboard instantiateViewControllerWithIdentifier:@"rightTable"];
    self.tableview2.view.frame = CGRectMake(80, 0, 320, 568);
    [self.view insertSubview:self.tableview2.view belowSubview:self.collectionview1];
    blackview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
//    blackview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"晴-"]];
    [self.view insertSubview:blackview belowSubview:self.collectionview1];
    
    //查询网络数据
    dataDao *dao = [[dataDao alloc]init];
    [dao startRequest];
    
    //下拉刷新
    self.collectionview1.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [dao startRequest];
        [self.collectionview1.header endRefreshing];
    }];
    
    //注册通知
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(hahaha:)
               name:@"leftsend"
             object:nil];
    [nc addObserver:self
           selector:@selector(hahaha1:)
               name:@"rightsend"
             object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(picData:) name:@"picData" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chaxunData:) name:@"leftData" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //将所有通知注销
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//添加页面返回增减cell
-(void)picData:(NSNotification *)notification
{
    indexSet = [[NSMutableIndexSet alloc]init];
    xianshiData = [picData mutableCopy];
    selected = [notification object];
    for(int i=0;i<9;i++){
        if([selected[i]  isEqual: @"YES"]){
            [indexSet addIndex:i+2];
        }
    }
    [xianshiData removeObjectsAtIndexes:indexSet];
    [self.collectionview1 reloadData];
}

//左页面通知
-(void)hahaha:(NSNotification *)num
{
    NSMutableArray *leftArray = [num object];
    [self performSegueWithIdentifier:@"tableToPresent" sender:leftArray];
}

//右页面通知
-(void)hahaha1:(NSNotification *)num
{
    [self performSegueWithIdentifier:@"tableToPresent2" sender:nil];
}

//点击事件
-(void)gestures2:(UITapGestureRecognizer *)gesture
{
    [self translation:0];
    pianyi = 0.0f;
    [gesture setEnabled:NO];
}

//滑动页面事件具体实现
-(void)gestures1:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan){
        if(pianyi == 0){
            if([gesture translationInView:gesture.view].x > 0)
                [self.tableview2.view setHidden:YES];
            if([gesture translationInView:gesture.view].x < 0)
                [self.tableview2.view setHidden:NO];
        }
    }

    if(gesture.state == UIGestureRecognizerStateChanged){
        if(pianyi + [gesture translationInView:gesture.view].x > 0)
            [self.tableview2.view setHidden:YES];
        if(pianyi + [gesture translationInView:gesture.view].x < 0)
            [self.tableview2.view setHidden:NO];
        self.collectionview1.transform = CGAffineTransformMakeTranslation(pianyi+[gesture translationInView:gesture.view].x,0);
        blackview.transform = CGAffineTransformMakeTranslation(pianyi+[gesture translationInView:gesture.view].x,0);
    }
    if(gesture.state == UIGestureRecognizerStateEnded){
        if(pianyi == 0){
            if([gesture translationInView:gesture.view].x > 0){
                [self translation:240];
                pianyi = 240;
                [gesture2 setEnabled:YES];
            }
            else{
                [self translation:-240];
                pianyi = -240;
                [gesture2 setEnabled:YES];
            }
        }
        
        if(pianyi == 240){
            if([gesture translationInView:gesture.view].x > 0){
                [self translation:240];
                pianyi = 240;
                [gesture2 setEnabled:YES];
            }
            else{
                [self translation:0];
                pianyi = 0;
                [gesture2 setEnabled:NO];
            }
        }
        
        if(pianyi == -240){
            if([gesture translationInView:gesture.view].x > 0){
                [self translation:0];
                pianyi = 0;
                [gesture2 setEnabled:NO];
            }
            else{
                [self translation:-240];
                pianyi = -240;
                [gesture2 setEnabled:YES];
            }
        }
        
        
    }
}



#pragma mark  ---------------collectionview dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [xianshiData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    UIImageView *imageview1 = (UIImageView *)[cell viewWithTag:1];
    imageview1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[xianshiData[indexPath.row] valueForKey:[NSString stringWithFormat:@"pic"]]]];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    label1.text = [xianshiData[indexPath.row] valueForKey:@"picName"];
    return cell;
}

#pragma mark  ---------------collectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------------%ld",(long)indexPath.row);
    if(indexPath.row == [xianshiData count]-1)
        [self performSegueWithIdentifier:@"collectionToCollection2" sender:picData];
}

#pragma mark  ---------------collectionview DelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75, 120);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(440, 60, 30, 60);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 50;
}

//动画实现
-(void)translation:(CGFloat)x
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"moveview" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.collectionview1.transform = CGAffineTransformMakeTranslation(x, 0);
    blackview.transform = CGAffineTransformMakeTranslation(x, 0);
    [UIView commitAnimations];
    
}

//storyboard 跳转准备
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"tableToPresent"]){
    presentViewController *presentview = segue.destinationViewController;
    presentview.objects = sender;
    }
    if([segue.identifier isEqual:@"collectionToCollection2"]){
        CollectionViewController2 *collectionview = segue.destinationViewController;
        collectionview.objects = sender;
    }
}


//通知获得数据并对数据进行处理
-(void)chaxunData:(NSNotification *)notification
{
    self.objects = [notification object];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[self.objects[0] valueForKey:@"weather"] forKey:@"pic"];
    [dic setValue:[self.objects[0] valueForKey:@"weather"] forKey:@"picName"];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:[self.objects[0] valueForKey:@"temperature"] forKey:@"picName"];
    [dic1 setValue:@"温度" forKey:@"pic"];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setValue:@"pm25" forKey:@"pic"];
    [dic2 setValue:@"空气 优" forKey:@"picName"];
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setValue:@"windy" forKey:@"pic"];
    [dic3 setValue:[self.objects[0] valueForKey:@"wind"] forKey:@"picName"];
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setValue:@"humidity" forKey:@"pic"];
    [dic4 setValue:@"湿度62%" forKey:@"picName"];
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setValue:@"sunrise" forKey:@"pic"];
    [dic5 setValue:@"日出05:41" forKey:@"picName"];
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc]init];
    [dic6 setValue:@"sunset" forKey:@"pic"];
    [dic6 setValue:@"日落18:05" forKey:@"picName"];
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc]init];
    [dic7 setValue:@"yundong" forKey:@"pic"];
    [dic7 setValue:@"适合运动" forKey:@"picName"];
    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc]init];
    [dic8 setValue:@"xiche" forKey:@"pic"];
    [dic8 setValue:@"适合洗车" forKey:@"picName"];
    NSMutableDictionary *dic9 = [[NSMutableDictionary alloc]init];
    [dic9 setValue:@"liangshai" forKey:@"pic"];
    [dic9 setValue:@"不宜晾晒" forKey:@"picName"];
    NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]init];
    [dic10 setValue:@"fishing" forKey:@"pic"];
    [dic10 setValue:@"适合钓鱼" forKey:@"picName"];
    NSMutableDictionary *dic11 = [[NSMutableDictionary alloc]init];
    [dic11 setValue:@"add" forKey:@"pic"];
    [dic11 setValue:@"添加更多" forKey:@"picName"];
    picData = [[NSMutableArray alloc]init];
    [picData addObject:dic];
    [picData addObject:dic1];
    [picData addObject:dic2];
    [picData addObject:dic3];
    [picData addObject:dic4];
    [picData addObject:dic5];
    [picData addObject:dic6];
    [picData addObject:dic7];
    [picData addObject:dic8];
    [picData addObject:dic9];
    [picData addObject:dic10];
    [picData addObject:dic11];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"leftData" object:nil];
    xianshiData = [picData mutableCopy];
    localData *save = [localData sharedManager];
    selected = [save readDataCanshu:1];
    indexSet = [[NSMutableIndexSet alloc]init];
    for(int i=0;i<9;i++){
        if([selected[i]  isEqual: @"YES"]){
            [indexSet addIndex:i+2];
        }
    }
    [xianshiData removeObjectsAtIndexes:indexSet];
    [self.collectionview1 reloadData];
    imageview0.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@+",[picData[0] valueForKey:[NSString stringWithFormat:@"pic"]]]];
    NSString *panduan = [self wenzichuli:[self.objects[0] valueForKey:@"weather"]];
    if([panduan  isEqual: @"晴"])
        self.collectionview1.backgroundColor = [UIColor colorWithRed:240.0/255 green:128.0/255 blue:128.0/255 alpha:0.7];
    if([panduan  isEqual: @"多云"])
        self.collectionview1.backgroundColor = [UIColor colorWithRed:0.0/255 green:191.0/255 blue:225.0/255 alpha:0.7];
    if([panduan rangeOfString:@"雨"].location != NSNotFound)
        self.collectionview1.backgroundColor = [UIColor colorWithRed:138.0/255 green:43.0/255 blue:226.0/255 alpha:0.7];
    blackview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-",panduan]]];
    
}

//文字处理
-(NSString *)wenzichuli:(NSString *)string
{
    if([string rangeOfString:@"转"].location != NSNotFound){
        NSRange range = [string rangeOfString:@"转"];
        NSString *aaaa = [string substringFromIndex:range.location+1];
        NSString *cccc = [NSString stringWithFormat:@"%@",aaaa];
        return cccc;
    }
    else{
        NSString *cccc = [NSString stringWithFormat:@"%@",string];
        return cccc;
    }
}

@end






