//
//  HttpClient.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJHttpClient.h"

static NSString *const HttpBaseURL = @"https://api.douban.com";

@implementation HJHttpClient
static HJHttpClient *instance = nil;
+(HJHttpClient *)shareClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[HJHttpClient alloc] initWithBaseURL:[NSURL URLWithString:HttpBaseURL]];
        }
    });
    
    return instance;
}


-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
//    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

@end
