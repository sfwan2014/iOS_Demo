//
//  HJProvider.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TestModel.h"
#import "BaseDBManager.h"

typedef enum : NSUInteger {
    kLoadDataTypeRefresh = 0,
    kLoadDataTypeLoadMore,
    kLoadDataTypeNone,
} kLoadDataType;

@class HJServerProvider;
@protocol ProviderDelegate <NSObject>

-(void)requestFinish:(HJServerProvider *)provider result:(id)result;
-(void)requestFaild:(HJServerProvider *)provider error:(NSError *)error;

@end

@interface HJServerProvider : NSObject
@property (nonatomic, assign) id <ProviderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, assign) kLoadDataType loadType;


-(id)initWithDelegate:(id<ProviderDelegate>) delegate;

//-(void) setRequestPath:(NSString *)path  method:(NSString *)method params:(NSDictionary *)params;

/**
 *  method 请求方式 POST 或者 GET
 *  请求参数 params ，字典类型
 */
-(void) setRequestMethod:(NSString *)method params:(NSMutableDictionary *)params;

/**
 *  请求网络刷新数据
 */
-(void)refresh;

/*
 *查询本地数据
 */
-(void)query;

@end
