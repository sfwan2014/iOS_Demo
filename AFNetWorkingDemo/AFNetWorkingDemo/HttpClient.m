//
//  HttpClient.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HttpClient.h"
#import "AFJSONRequestOperation.h"

static NSString *const HttpBaseURL = @"https://api.douban.com";

@implementation HttpClient
static HttpClient *instance = nil;
+(HttpClient *)shareClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[HttpClient alloc] initWithBaseURL:[NSURL URLWithString:HttpBaseURL]];
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
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

@end
