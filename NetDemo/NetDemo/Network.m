//
//  Network.m
//  NetDemo
//
//  Created by shaofa on 14-1-9.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "Network.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
@implementation Network
+ (void)downLoadWithUrl:(NSString *)url fileName:(NSString *)name
{
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    [[ ASIDownloadCache sharedCache ] setShouldRespectCacheControlHeaders:NO ];
//    [[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:
//     ASICachePermanentlyCacheStoragePolicy];
    
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:10];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *downloadPath = [NSString stringWithFormat:@"%@/%@.zip",path,name];
    NSLog(@"%@", downloadPath);
    [request setCompletionBlock:^{
//        int code =  [request responseStatusCode];
        
        if (request.didUseCachedResponse) {
            NSLog(@"使用缓存数据");
        }else{
            NSLog(@"网络加载数据");
        }
        //解析json
//        NSString *path1 = [NSString stringWithFormat:@"%@/%@",path,name];
        [request.responseData writeToFile:downloadPath atomically:YES];
    }];
        
        [request setFailedBlock:^{
            NSLog(@"请求数据失败");
        }];
        
        [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        
        //设置缓存的时间为30天
        [request setSecondsToCache:10];
        
        //发送同步请求
        [request startSynchronous];
}
     
@end
