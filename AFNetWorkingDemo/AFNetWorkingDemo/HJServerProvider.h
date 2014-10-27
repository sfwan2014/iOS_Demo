//
//  HJProvider.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"
#import "BaseDBManager.h"

@class HJServerProvider;
@protocol ProviderDelegate <NSObject>

-(void)requestFinish:(HJServerProvider *)provider;
-(void)requestFaild:(HJServerProvider *)provider error:(NSError *)error;

@end

@interface HJServerProvider : NSObject
@property (nonatomic, assign) id <ProviderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *allDatas;


-(id)initWithDelegate:(id<ProviderDelegate>) delegate;

//-(void) setRequestPath:(NSString *)path  method:(NSString *)method params:(NSDictionary *)params;

-(void) setRequestMethod:(NSString *)method params:(NSDictionary *)params;
-(void)refresh;
-(void)query;

@end
