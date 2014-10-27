//
//  BaseDBManager.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef void (^ FinishBlock)(NSArray *result);
@interface BaseDBManager : NSObject

@property (nonatomic, copy) NSString *modelName;

- (BaseModel *)createModel;
- (BOOL)addModel:(BaseModel *)model;
- (BaseModel *)findModelById:(NSString *)modelId;
- (NSArray *)findAllModels;
- (BOOL)deleteModel:(NSString *)modelId;
- (BOOL)editModel:(BaseModel *)model;
+ (BaseDBManager *)shareManager;


-(void)quaryAllDatas:(FinishBlock)block;
@end
