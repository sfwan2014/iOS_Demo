//
//  TestProvider2.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "TestProvider2.h"
#import "TestModel2.h"

@implementation TestProvider2
#pragma mark - override method
-(NSString *)currentPath
{
    return @"/v2/book/1220562";
}

- (NSString *)modelName
{
    return @"TestModel2";
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
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    [manager quaryAllDatas:^(NSArray *result) {
        self.allDatas = [result mutableCopy];
        if ([self.delegate respondsToSelector:@selector(requestFinish:)]) {
            [self.delegate requestFinish:self];
        }
    }];
}

-(void)handleData:(id)result
{
    //
    BaseDBManager *manager = [BaseDBManager shareManager];
    manager.modelName = [self modelName];
    TestModel2 *model = (TestModel2 *)[manager findModelById:result[@"id"]];
    if (model == nil) {
        model = (TestModel2 *)[manager createModel];
    }
    [model setContent:result];
    [self.allDatas addObject:model];
    [manager editModel:nil];
    
    if ([self.delegate respondsToSelector:@selector(requestFinish:)]) {
        [self.delegate requestFinish:self];
    }
}
@end
