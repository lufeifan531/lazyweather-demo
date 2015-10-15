//
//  TableViewController.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/10.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
@interface TableViewController ()
@property (strong,nonatomic)NSMutableArray *objects;

@end

@implementation TableViewController
{
    NSArray *weekday;
    UIColor *Color1;
    UIColor *Color2;
    UIColor *Color3;
    NSString *weatherColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    weekday = [[NSArray alloc]initWithObjects:@"昨天",@"今天",@"明天",@"周六",@"周日",@"周一", nil];
    self.view.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chaxunData:) name:@"leftData" object:nil];
    [self initColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell" forIndexPath:indexPath];
    cell.label1.text = [self.objects[indexPath.row] valueForKey:@"week"];
    cell.label2.text = [self.objects[indexPath.row] valueForKey:@"days"];
    cell.label3.text = [self.objects[indexPath.row] valueForKey:@"weather"];
    cell.label4.text = [self.objects[indexPath.row] valueForKey:@"temperature"];
    UIImageView *view1 = [[UIImageView alloc]initWithFrame:CGRectMake(155, 21.8, 100, 80)];
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius = 20;
    [cell.contentView insertSubview:view1 atIndex:0];
    NSString *panduan = [self wenzichuli:[self.objects[indexPath.row] valueForKey:@"weather"]];
    if([panduan  isEqual: @"晴"])
        view1.image = [self createImageWithColor:Color1];
    if([panduan  isEqual: @"多云"])
        view1.image = [self createImageWithColor:Color2];
    if([panduan rangeOfString:@"雨"].location != NSNotFound)
        view1.image = [self createImageWithColor:Color3];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

#pragma mark  ---------------tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113.6f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *anumber = [NSNumber numberWithInteger:indexPath.row];
    [self.objects addObject:anumber];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leftsend" object:self.objects ];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//通知传回数据
-(void)chaxunData:(NSNotification *)notification
{
    self.objects = [notification object];
    NSLog(@"%@",[self.objects[0] valueForKey:@"week"]);
    weatherColor = [self wenzichuli:[self.objects[0] valueForKey:@"weather"]];
    NSLog(@"%@",weatherColor);
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
//将UIColor转化为UIIamge
- (UIImage*) createImageWithColor: (UIColor*) color

{
    
    CGRect rect=CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    UIImage *senderImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return senderImage;
    
}
//初始化颜色
-(void)initColor
{
    Color1= [UIColor colorWithRed:240.0/255 green:128.0/255 blue:128.0/255 alpha:1];
    Color2= [UIColor colorWithRed:0.0/255 green:191.0/255 blue:225.0/255 alpha:1];
    Color3= [UIColor colorWithRed:138.0/255 green:43.0/255 blue:226.0/255 alpha:1];
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
