//
//  localData.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/16.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "localData.h"

@implementation localData
static localData *sharedManager = nil;

+ (localData*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedManager;
}

-(void)saveData:(NSMutableArray *)arry canshu:(int)i
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    array[i] = arry;
    [array writeToFile:path atomically:YES];
}
-(void)saveData2:(NSString *)string cahshu:(int)i
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    array[i] = string;
    [array writeToFile:path atomically:YES];
}
-(NSMutableArray *)readDataCanshu:(int)i
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return array[i];
}
-(NSString *)readData2Canshu:(int)i
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return array[i];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"lazyweatherList.plist"];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        NSAssert(success, @"错误写入文件");
    }
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"lazyweatherList.plist"];
    
    return path;
}
@end
