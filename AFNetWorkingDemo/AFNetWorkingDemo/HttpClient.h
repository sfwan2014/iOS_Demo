//
//  HttpClient.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AFHTTPClient.h"

@interface HttpClient : AFHTTPClient

+(HttpClient *)shareClient;

@end
