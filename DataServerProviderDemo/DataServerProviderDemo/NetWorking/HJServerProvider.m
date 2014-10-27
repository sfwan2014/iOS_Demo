//
//  HJProvider.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJServerProvider.h"
#import "HJHttpClient.h"

static NSString *const HTTPRequestGETMethodString = @"GET";
static NSString *const HTTPRequestPOSTMethodString = @"POST";

@interface HJServerProvider ()
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *path;
@end

@implementation HJServerProvider
{
    HJHttpClient *client;
    int pageIndex;
}

-(id)initWithDelegate:(id<ProviderDelegate>) delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.allDatas = [NSMutableArray array];
        
        client = [HJHttpClient shareClient];
        [client setDefaultHeader:@"Accept" value:[self receiveType]];
        [client registerHTTPOperationClass:[NSClassFromString([self requestOperationClassName]) class]];
    }
    
    return self;
}

/*
 *继承HJServerProvider 需复写下面私有方法
 */
#pragma private Method
// 获取子 URL
-(NSString *)currentPath
{
    return @""; // 子类必须复写
}
// 返回存储数据的model名
- (NSString *)modelName
{
    return @"BaseModel";    // 子类必须复写
}

// 接收数据格式 xml 或者 json   默认是json
-(NSString *)receiveType
{
    return @"application/json";
}

// AF网络请求选取请求的类型, 不同类型返回的数据格式不同
// AFJSONRequestOperation    返回json格式数据
// AFHTTPRequestOperation    返回NSData 类型数据
-(NSString *)requestOperationClassName
{
    return @"AFJSONRequestOperation";
}

// 是否需要本地缓存
-(BOOL)isCache
{
    return YES;
}

#pragma mark - start load

-(void)startLoad
{
    if ([_method isEqual:HTTPRequestGETMethodString]) {
        [client getPath:_path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
                    [self.delegate requestFinish:self result:responseObject];
                }
            } else {
                if ([self isCache]) {
                    [self handleData:responseObject];
                } else {
                    if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
                        [self.delegate requestFinish:self result:responseObject];
                    }
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(requestFaild:error:)]) {
                [self.delegate requestFaild:self error:error];
            }
        }];
    } else if ([_method isEqual:HTTPRequestPOSTMethodString]) {
        [client postPath:_path parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
                    [self.delegate requestFinish:self result:responseObject];
                }
            } else {
                if ([self isCache]) {
                    [self handleData:responseObject];
                } else {
                    if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
                        [self.delegate requestFinish:self result:responseObject];
                    }
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(requestFaild:error:)]) {
                [self.delegate requestFaild:self error:error];
            }
        }];
    }
}

#pragma mark - refresh
/*
 * 刷新数据
 */
-(void)refresh
{
    [self.allDatas removeAllObjects];
    _loadType = kLoadDataTypeRefresh;
    [self startLoad];
}

/*
 *本地查询数据
 */
-(void)query
{
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    [manager quaryAllDatas:^(NSArray *result) {
        self.allDatas = [result mutableCopy];
        
        if (self.allDatas.count == 0) {// 无数据则请求网络刷新数据
            [self refresh];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
            [self.delegate requestFinish:self result:result];
        }
    }];
}

/*
 *加载更多
 */
-(void)loadMore
{
    [self.params setObject:[NSString stringWithFormat:@"%d", pageIndex] forKey:@"pageIndex"];
    _loadType = kLoadDataTypeLoadMore;
    [self startLoad];
}


// 获取数据存储到本地, 并转化为model
-(void)handleData:(id)result
{
//    BaseDBManager *manager = [BaseDBManager shareManager];
//    manager.modelName = [self modelName];
//    TestModel *model = (TestModel *)[manager findModelById:result[@"id"]];
//    if (model == nil) {
//        model = (TestModel *)[manager createModel];
//    }
//    [model setContent:result];
//    [self.allDatas addObject:model];
//    [manager editModel:nil];
//    
//    if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
//        [self.delegate requestFinish:self result:model];
//    }
}


// 设置请求参数 及 请求方式
-(void) setRequestMethod:(NSString *)method params:(NSMutableDictionary *)params
{
    [self setRequestPath:[self currentPath] method:method params:params];
}

-(void) setRequestPath:(NSString *)path  method:(NSString *)method params:(NSMutableDictionary *)params
{
    self.params = params;
    self.method = method;
    self.path = path;
}

@end
