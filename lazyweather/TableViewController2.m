//
//  TableViewController2.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/11.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "TableViewController2.h"

@interface TableViewController2 ()<CLLocationManagerDelegate>

@end

@implementation TableViewController2
{
    NSMutableArray *arry2;
    NSArray *arry1;
    NSArray *arry3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arry1 = [[NSArray alloc]initWithObjects:@"提醒",@"设置",@"关于", nil];
    arry3 = [[NSArray alloc]initWithObjects:@"reminder",@"setting_right",@"contact", nil];
    localData *save = [localData sharedManager];
    arry2 = [save readDataCanshu:2];
    self.view.backgroundColor = [UIColor blackColor];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------- Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 3;
    else
        return [arry2 count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell2" forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        cell.label.text = arry1[indexPath.row];
        cell.image1.image = [UIImage imageNamed:arry3[indexPath.row]];
    }
    else{
        if(indexPath.row == 0){
            cell.label.text = arry2[indexPath.row];
            cell.image1.image = [UIImage imageNamed: @"addcity"];
        }
        else{
            cell.label.text = arry2[indexPath.row];
            cell.image1.image = [UIImage imageNamed:@"city"];
        }
    }
    if(!(indexPath.section == 1 && indexPath.row != 0)){
        cell.button1.hidden = YES;
    }
    cell.button1.tag = indexPath.row;
    [cell.button1 addTarget:self action:@selector(buttonDelete:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if(section == 1)
        return @"城市管理";
    else
        return nil;
}

//删除按钮点击事件
- (void)buttonDelete:(UIButton *)button
{
    UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"删除" message: @"是否删除这个城市" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [arry2 removeObjectAtIndex:button.tag];
        localData *save = [localData sharedManager];
        [save saveData:arry2 canshu:2];
        [self.tableView reloadData];
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    //显示
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark -------------------- Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    if(indexPath.section == 1){
       if(indexPath.row == 0)
        [self dingwei];
       else{
         localData *save = [localData sharedManager];
         [save saveData2:arry2[indexPath.row] cahshu:0];
       }
    }
    if(indexPath.section == 0)
       [[NSNotificationCenter defaultCenter] postNotificationName:@"rightsend" object:nil];
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//定位服务
-(void)dingwei
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:self.currLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       if ([placemarks count] > 0) {
                           
                           CLPlacemark *placemark = [placemarks lastObject];
                           
                           NSDictionary *addressDictionary =  placemark.addressDictionary;
                           
                           NSString *city = [addressDictionary
                                             objectForKey:(NSString *)kABPersonAddressCityKey];
                           city = city == nil ? @"": city;
                           NSLog(@"%@",city);
                           NSRange range = [city rangeOfString:@"市"];
                           NSString *cccc = [city substringToIndex:range.location];
                            NSLog(@"%@",cccc);
                           localData *save = [localData sharedManager];
                           [save saveData2:cccc cahshu:0];
                           if(![arry2 containsObject:cccc]){
                              [arry2 addObject:cccc];
                               [save saveData:arry2 canshu:2];
                               [self.tableView reloadData];
                           }
                       }
                       
                   }];
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark --------------------Core Location委托方法用于实现位置的更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currLocation = [locations lastObject];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Authorized");
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"AuthorizedWhenInUse");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Denied");
    } else if (status == kCLAuthorizationStatusRestricted) {
        NSLog(@"Restricted");
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"NotDetermined");
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止定位
    [self.locationManager stopUpdatingLocation];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
