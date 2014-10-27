//
//  HttpOperation.h
//  FinancialManage
//
//  Created by sfwan on 14-8-12.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpOperation : NSObject
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSString *operationUid;
- (id)initWithRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue operationUid:(NSString *)operationUid;
-(void)startRequest;
@end
