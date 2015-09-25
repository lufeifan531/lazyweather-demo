//
//  localData.h
//  lazyweather
//
//  Created by 陆非凡 on 15/9/16.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface localData : NSObject
+ (localData *)sharedManager;
-(void)saveData:(NSMutableArray *)arry canshu:(int)i;
-(NSMutableArray *)readDataCanshu:(int)i;
-(void)saveData2:(NSString *)string cahshu:(int)i;
-(NSString *)readData2Canshu:(int)i;
@end
