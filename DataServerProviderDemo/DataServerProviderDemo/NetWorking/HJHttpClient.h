//
//  HttpClient.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface HJHttpClient : AFHTTPClient

+(HJHttpClient *)shareClient;

@end
