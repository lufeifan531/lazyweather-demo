//
//  CollectionViewController2.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/14.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "CollectionViewController2.h"
#import "CollectionViewCell2.h"
#import "localData.h"
@interface CollectionViewController2 ()
@end

@implementation CollectionViewController2
{
    NSMutableArray *xianshiData;
    NSMutableIndexSet *indexSet;
    NSMutableArray *selected;
    NSMutableArray *indexSetArray;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
//     self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 20, 20)];
    imageview3.image = [UIImage imageNamed:@"close_hover"];
    [self.view addSubview:imageview3];
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closepresent)];
    [imageview3 addGestureRecognizer:gesture1];
    imageview3.userInteractionEnabled=YES;
    xianshiData = [self.objects mutableCopy];
    localData *save = [localData sharedManager];
    selected = [save readDataCanshu:1];
    indexSet = [[NSMutableIndexSet alloc]init];
    // Do any additional setup after loading the view.
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

#pragma mark ------------------------UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
        return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    cell.label.text = [self.objects[indexPath.row+2] valueForKey:@"picName"];
    cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.objects[indexPath.row+2] valueForKey:[NSString stringWithFormat:@"pic"]]]];
    cell.imageview2.image = [UIImage imageNamed:@"checkmark"];
    if([selected[indexPath.row]  isEqual: @"NO"])
        cell.imageview2.hidden = NO;
    else
        cell.imageview2.hidden = YES;
    return cell;
}

#pragma mark ------------------------UICollectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------------%ld",(long)indexPath.row);
    CollectionViewCell2 *cell = (CollectionViewCell2 *)[collectionView cellForItemAtIndexPath:indexPath];
    if(cell.imageview2.hidden == YES){
        [cell.imageview2 setHidden:NO];
        [indexSet removeIndex:indexPath.row+2];
        selected[indexPath.row] = [NSString stringWithFormat:@"NO"];
        NSLog(@"%@",indexSet);
    }
    else{
        [cell.imageview2 setHidden:YES];
        [indexSet addIndex:indexPath.row+2];
        selected[indexPath.row] = [NSString stringWithFormat:@"YES"];
        NSLog(@"%@",indexSet);
    }
}

#pragma mark  ---------------collectionview DelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 115);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(60, 30, 60, 45);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 60;
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

//通知获得数据
-(void)picData:(NSNotification *)notification
{
    self.objects = [notification object];
}

//关闭按钮实现
-(void)closepresent
{
     localData *save = [localData sharedManager];
    [save saveData:selected canshu:1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"picData" object:selected];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
