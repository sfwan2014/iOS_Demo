//
//  HttpOperation.m
//  FinancialManage
//
//  Created by sfwan on 14-8-12.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import "HttpOperation.h"
#import "HJCFSYNCQueues.h"

@implementation HttpOperation
{
    NSURLRequest *_request;
    NSOperationQueue *_queue;
}
- (id)initWithRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue operationUid:(NSString *)operationUid
{
    self = [super init];
    if (self) {
        _request = request;
        _queue = queue;
        _operationUid = operationUid;
    }
    return self;
}

-(void)cancleNeedRequest
{
    NSString *filePath = [HJCFSYNCQueues operationFilePathFromFileName:[NSString stringWithFormat:@"%@.ydn", _operationUid]];
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        [fm removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
}

-(void)startRequest
{
    [NSURLConnection sendAsynchronousRequest:_request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString *message = nil;
        if ([result integerValue] > 0) {
            message = [NSString stringWithFormat:@"同步%@条数据", result];
            [self cancleNeedRequest];
        } else {
            if (connectionError) {
                message = @"网络异常";
            }else {
                message = @"添加失败";
            }
        }
        
    }];
}

@end
