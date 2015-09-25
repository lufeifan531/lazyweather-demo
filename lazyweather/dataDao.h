//
//  dataDao.h
//  lazyweather
//
//  Created by 陆非凡 on 15/9/12.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "localData.h"
@interface dataDao : NSObject
@property (strong,nonatomic)NSString *city;
-(void)startRequest;
@end
