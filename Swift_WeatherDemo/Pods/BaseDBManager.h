//
//  BaseDBManager.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface BaseDBManager : NSObject
+ (Model *)createModel;
+ (BOOL)addModel:(Model *)model;
+ (Model *)findModelById:(NSString *)modelId;
+ (NSArray *)findAllModels;
+ (BOOL)deleteModel:(NSString *)modelId;
+ (BOOL)editModel:(Model *)model;
@end
