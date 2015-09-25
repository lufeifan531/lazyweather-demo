//
//  locationway.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/19.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "locationway.h"

@implementation locationway
-(void)dingwei
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [self.locationManager startUpdatingLocation];
    NSLog(@"12312313132");
    [geocoder reverseGeocodeLocation:self.currLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       if ([placemarks count] > 0) {
                           
                           CLPlacemark *placemark = placemarks[0];
                           
                           NSDictionary *addressDictionary =  placemark.addressDictionary;
                           
                           NSString *city = [addressDictionary
                                             objectForKey:(NSString *)kABPersonAddressCityKey];
                           city = city == nil ? @"": city;
                           NSLog(@"%@",city);
                           
                       }
                       
                   }];
//    [self.locationManager stopUpdatingLocation];

}

#pragma mark Core Location委托方法用于实现位置的更新
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
@end
