//
//  TestProvider.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "TestProvider.h"

@implementation TestProvider

#pragma mark - override method
-(NSString *)currentPath
{
    return @"/v2/book/1220562";
}

- (NSString *)modelName
{
    return @"TestModel";
}

-(void) setRequestMethod:(NSString *)method params:(NSDictionary *)params
{
    [super setRequestMethod:method params:params];
}


-(void)refresh
{
    [super refresh];
}

-(void)query
{
    [super query];
}

-(void)handleData:(id)result
{
    //
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    TestModel *model = (TestModel *)[manager findModelById:result[@"id"]];
    if (model == nil) {
        model = (TestModel *)[manager createModel];
    }
    [model setContent:result];
    [self.allDatas addObject:model];
    [manager editModel:nil];
    
    if ([self.delegate respondsToSelector:@selector(requestFinish:)]) {
        [self.delegate requestFinish:self];
    }
}

@end
