//
//  dataDao.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/12.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "dataDao.h"

@implementation dataDao

//获取网络数据
-(void)startRequest
{
    localData *save = [localData sharedManager];
    self.city = [save readData2Canshu:0];
    if(self.city == nil)
    self.city = @"南京";
    NSString *ss = [self.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [[NSString alloc] initWithFormat:@"app=weather.future&weaid=%@&&appkey=15365&sign=718299404fed1781f13b129e81452dfc&format=%@",ss,@"json"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"api.k780.com:88/?app=weather.future&format=json" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
    
//        NSLog(@"responseData : %@", [operation responseString]);
        NSData *data = [operation responseData];
        NSDictionary *mweather = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *interData = [mweather objectForKey:@"result"];
//        NSDictionary *m = interData[0];
        NSLog(@"------------%@",[interData[0] valueForKey:@"citynm"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leftData" object:interData];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];

    [engine enqueueOperation:op];
    
}

@end
