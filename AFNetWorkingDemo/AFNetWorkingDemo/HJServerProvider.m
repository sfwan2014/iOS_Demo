//
//  HJProvider.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJServerProvider.h"
#import "HttpClient.h"

static NSString *const HTTPRequestGETMethodString = @"GET";
static NSString *const HTTPRequestPOSTMethodString = @"POST";

@interface HJServerProvider ()
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *path;
@end

@implementation HJServerProvider
-(id)initWithDelegate:(id<ProviderDelegate>) delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.allDatas = [NSMutableArray array];
    }
    
    return self;
}

#pragma private Method
-(NSString *)currentPath
{
    return @"";
}

- (NSString *)modelName
{
    return @"BaseModel";
}

-(void)refresh
{
    HttpClient *client = [HttpClient shareClient];
    [self.allDatas removeAllObjects];
    
    if ([_method isEqual:HTTPRequestGETMethodString]) {
        [client getPath:_path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleData:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(requestFaild:error:)]) {
                [self.delegate requestFaild:self error:error];
            }
        }];
    } else if ([_method isEqual:HTTPRequestPOSTMethodString]) {
        [client postPath:_path parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleData:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(requestFaild:error:)]) {
                [self.delegate requestFaild:self error:error];
            }
        }];
    }
}

-(void)query
{
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    [manager quaryAllDatas:^(NSArray *result) {
        self.allDatas = [result mutableCopy];
        
        if (self.allDatas.count == 0) {
            [self refresh];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(requestFinish:)]) {
            [self.delegate requestFinish:self];
        }
    }];
}

-(void)handleData:(id)result
{
    // 
}

-(void) setRequestMethod:(NSString *)method params:(NSDictionary *)params
{
    [self setRequestPath:[self currentPath] method:method params:params];
}

-(void) setRequestPath:(NSString *)path  method:(NSString *)method params:(NSDictionary *)params
{
    self.params = params;
    self.method = method;
    self.path = path;
}

@end
