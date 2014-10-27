//
//  HJCFImportCustomQueues.h
//  FinancialManage
//
//  Created by sfwan on 14-8-12.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpOperation.h"

@interface HJCFSYNCQueues : NSObject

+(instancetype)shareImportQueue;

- (void)addOperationInQueue:(HttpOperation *)operation;
- (void)start;
- (BOOL)isNeedRequest;
-(void)storeOperations;
+(NSString *)operationFilePathFromFileName:(NSString *)fileName;

@end
