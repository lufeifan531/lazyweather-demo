//
//  TableViewController2.h
//  lazyweather
//
//  Created by 陆非凡 on 15/9/11.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell2.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "localData.h"
@interface TableViewController2 : UITableViewController
@property (strong,nonatomic) CLLocationManager *locationManager;
@property(nonatomic, strong)  CLLocation *currLocation;
@end
