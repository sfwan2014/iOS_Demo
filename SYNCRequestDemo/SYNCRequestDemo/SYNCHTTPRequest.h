//
//  SYNCHTTPRequest.h
//  SYNCRequestDemo
//
//  Created by sfwan on 14-8-20.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *SYNCHTTPRequestStartBackgroundRequest;
extern const NSString *SYNCHTTPRequestStartRequest;

@interface SYNCHTTPRequest : NSObject
+ (SYNCHTTPRequest *)shareManager;

- (void)postWithRequest:(NSURLRequest *)request callBack:(void(^)(const NSString *requestType, NSString *info, NSError *error))block;

@end
