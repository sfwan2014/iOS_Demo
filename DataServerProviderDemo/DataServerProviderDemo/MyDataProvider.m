//
//  MyDataProvider.m
//  DataServerProviderDemo
//
//  Created by sfwan on 14-7-2.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MyDataProvider.h"
#import "MyModel.h"

@implementation MyDataProvider
/*
 *继承HJServerProvider 需复写下面私有方法
 */
#pragma private Method
// 获取子 URL
-(NSString *)currentPath
{
    return @"/v2/book/1220562"; // 子类必须复写
}
// 返回存储数据的model名
- (NSString *)modelName
{
    return @"MyModel";    // 子类必须复写
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

-(void)handleData:(id)result
{
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    MyModel *model = (MyModel *)[manager findModelById:result[@"id"]];
    if (model == nil) {
        model = (MyModel *)[manager createModel];
    }
    [model setContent:result];
    [self.allDatas addObject:model];
    [manager editModel:nil];

    if ([self.delegate respondsToSelector:@selector(requestFinish:result:)]) {
        [self.delegate requestFinish:self result:model];
    }
}

@end
