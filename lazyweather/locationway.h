//
//  locationway.h
//  lazyweather
//
//  Created by 陆非凡 on 15/9/19.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
@interface locationway : NSObject<CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *locationManager;
@property(nonatomic, strong)  CLLocation *currLocation;
-(void)dingwei;
@end
