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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    weekday = [[NSArray alloc]initWithObjects:@"昨天",@"今天",@"明天",@"周六",@"周日",@"周一", nil];
    self.view.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chaxunData:) name:@"leftData" object:nil];
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
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(155, 21.8, 100, 80)];
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius = 20;
    view1.backgroundColor = [UIColor orangeColor];
    [cell.contentView insertSubview:view1 atIndex:0];
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


@end
