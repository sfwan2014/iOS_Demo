//
//  BaseDBManager.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJBaseModel.h"

typedef void (^ FinishBlock)(NSArray *result);
@interface BaseDBManager : NSObject

@property (nonatomic, copy) NSString *modelName;

- (HJBaseModel *)createModel;
- (BOOL)addModel:(HJBaseModel *)model;
- (HJBaseModel *)findModelById:(NSString *)modelId;
- (NSArray *)findAllModels;
- (BOOL)deleteModel:(NSString *)modelId;
- (BOOL)editModel:(HJBaseModel *)model;
+ (BaseDBManager *)shareManager;

- (void)deleteAllData;
-(void)quaryAllDatas:(FinishBlock)block;
@end
