//
//  SqlManager.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/29.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "SqlManager.h"

#define commonDBName  @"common.sqlite"
#define commonDBEncryptKey  @"commonDBEncryptKey"
#define userDBprefix  @"userDBprefix_"
#define userDBEncryptKey  @"userDBEncryptKey"
#define DBFolderName  @"DB"

@implementation SqlManager


+ (SqlManager *)sharedInstance
{
    static SqlManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SqlManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
    }
    return self;
}

- (NSString *)pathWithDBName:(NSString *)dbName
{
    return [[self DBFolderPath] stringByAppendingPathComponent:dbName];
}


- (NSString *)DBFolderPath
{
    return [DocumetsRootPath stringByAppendingPathComponent:DBFolderName];
}

- (void)initVars
{
    /*创建DB这个文件夹*/
    NSFileManager *fileM = [NSFileManager defaultManager];
    NSString *commonDBPath = [self pathWithDBName:commonDBName];
    if (![fileM fileExistsAtPath:commonDBPath]){//创建文件夹
        NSString *folderPath = [self DBFolderPath];
        [fileM createDirectoryAtPath:folderPath
         withIntermediateDirectories:YES
                          attributes:nil
                               error:nil];
    }
    
    _commonDB = [[CommonDB alloc] initWithDBPath:commonDBPath
                                      encryptKey:nil];
}

- (void)switchOverToUser:(NSString *)userId
{
    if (_currentUserDB){
        [_currentUserDB close];
        _currentUserDB = nil;
    }
    
    if ([NSString isEmptyString:userId]) return;
    
    NSString *userDBName = Str_F(@"%@%@.sqlite",userDBprefix,userId);
    NSString *userDBPath = [self pathWithDBName:userDBName];
    _currentUserDB = [[UserDB alloc] initWithDBPath:userDBPath
                                         encryptKey:nil];
}

@end
