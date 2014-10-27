//
//  HJCFImportCustomQueues.m
//  FinancialManage
//
//  Created by sfwan on 14-8-12.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import "HJCFSYNCQueues.h"
//#import "HJCFRecordTools.h"
//#import "HJCFUtils.h"
#import "JSON.h"
//#import "Planner.h"

#define kURL        @"url"
#define kHTTP_METHOD @"httpMethod"
#define kHTTPBody    @"HTTPBody"

@implementation HJCFSYNCQueues
{
    NSMutableArray *_operations;
    NSMutableArray *_filePaths;
    NSOperationQueue *_queue;
}

+(instancetype)shareImportQueue
{
    static HJCFSYNCQueues *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[HJCFSYNCQueues alloc] init];
        }
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //        _operation = operation;
        _operations = [[NSMutableArray alloc] init];
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

-(void)storeOperations
{
    dispatch_queue_t queue = dispatch_queue_create("Store operation", NULL);
    dispatch_async(queue, ^{
        for (HttpOperation *operation in _operations) {
            NSString *fileName = [NSString stringWithFormat:@"%@.ydn", operation.operationUid];
            NSString *filePath = [HJCFSYNCQueues operationFilePathFromFileName:fileName];
            NSURLRequest *request = operation.request;
            
            NSMutableData *arcData = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:arcData];
            [archiver encodeObject:request forKey:operation.operationUid];
            [archiver finishEncoding];
            [arcData writeToFile:filePath atomically:YES];
        }
        [_operations removeAllObjects];
    });
}

-(void)quaryOpreations:(void (^)(void))finish
{
    dispatch_queue_t queue = dispatch_queue_create("Quary", NULL);
    dispatch_async(queue, ^{
        NSArray *allFilePaths = [HJCFSYNCQueues allAudioFilesInCacheDirectory];
        for (NSString *fileName in allFilePaths) {
            if (![fileName hasSuffix:@".ydn"]) {
                continue;
            }
            NSString *filePath = [HJCFSYNCQueues operationFilePathFromFileName:fileName];
            
            
            NSData *arcData = [[NSData alloc] initWithContentsOfFile:filePath];
            NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:arcData];
            NSURLRequest *request = [archiver decodeObjectForKey:[fileName substringToIndex:fileName.length - 4]];
            
            HttpOperation *operation = [[HttpOperation alloc] initWithRequest:request queue:_queue operationUid:[fileName substringToIndex:fileName.length - 4]];
            [_operations addObject:operation];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            finish();
        });
    });
}

- (void)addOperationInQueue:(HttpOperation *)operation
{
    [_operations addObject:operation];
    [self storeOperations];
}

- (void)start
{
    [self quaryOpreations:^{
        for (HttpOperation *operation in _operations) {
            [operation startRequest];
        }
        [_operations removeAllObjects];
    }];
}

- (BOOL)isNeedRequest{
    NSArray *allFilePaths = [HJCFSYNCQueues allAudioFilesInCacheDirectory];
    if (allFilePaths.count == 0) {
        return NO;
    }
    return YES;
}

// 获取所有文件名
+(NSArray *)allAudioFilesInCacheDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = Nil;
    return [fm contentsOfDirectoryAtPath:[self operationCacheDirectory] error:&error];
}

// 获取文件所在路径
+(NSString *)operationFilePathFromFileName:(NSString *)fileName
{
    NSString *cacheDirectory = [self operationCacheDirectory];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:cacheDirectory]) {
        [fm createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:Nil];
    }
    
    return [cacheDirectory stringByAppendingPathComponent:fileName];
}

// 获取文件所在目录
+(NSString *)operationCacheDirectory
{
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, \
                                                 NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[self operationCacheSubCacheDirectory]];
}

// 获取子目录
+(NSString *)operationCacheSubCacheDirectory
{
    return @"/UserInfo/Operation";
}

@end
