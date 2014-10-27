//
//  SYNCHTTPRequest.m
//  SYNCRequestDemo
//
//  Created by sfwan on 14-8-20.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SYNCHTTPRequest.h"
#import "AFNetworkReachabilityManager.h"
#import "HJCFSYNCQueues.h"

const NSString *SYNCHTTPRequestStartBackgroundRequest = @"StartBackgroundRequest";
const NSString *SYNCHTTPRequestStartRequest = @"StartRequest";
NSString *SYNCHTTPRequestDefaultResult = @"{\"key\":\"1\",\"value\":\"进入后台操作\"}";

@implementation SYNCHTTPRequest
{
    NSURLRequest *_request;
    NSOperationQueue *_queue;
}

+ (SYNCHTTPRequest *)shareManager
{
    static SYNCHTTPRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[SYNCHTTPRequest alloc] init];
        }
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)postWithRequest:(NSURLRequest *)request callBack:(void(^)(const NSString *requestType, NSString *info, NSError *error))block
{
    _request = request;
    [self startLoadAndCallBack:block];
}

- (void)startLoadAndCallBack:(void(^)(const NSString *requestType, NSString *info, NSError *error))block
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        // 本地保存
        HttpOperation *operation = [[HttpOperation alloc] initWithRequest:_request queue:_queue operationUid:nil];
        [[HJCFSYNCQueues shareImportQueue] addOperationInQueue:operation];
        [[HJCFSYNCQueues shareImportQueue] storeOperations];
        block(SYNCHTTPRequestStartBackgroundRequest, SYNCHTTPRequestDefaultResult, nil);
        
    } else {
        [NSURLConnection sendAsynchronousRequest:_request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSString *info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            block(SYNCHTTPRequestStartRequest, info, connectionError);
        }];
    }
}

@end
