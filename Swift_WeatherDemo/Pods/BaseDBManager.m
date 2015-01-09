//
//  BaseDBManager.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "BaseDBManager.h"
#import "DBManager.h"

#define managedObjectContext [DBManager defaultDBManager].managedObjectContext

@implementation BaseDBManager
// 创建
+ (Model *)createModel {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Model" inManagedObjectContext:managedObjectContext];
}

//增加
+ (BOOL)addModel:(Model *)model {
    
    NSLog(@"%s", __FUNCTION__);
    
    return [managedObjectContext save:nil];
}

// 查找
+(Model *)findModelById:(NSString *)modelId
{
    NSLog(@"%s", __FUNCTION__);
    NSEntityDescription *entify = [NSEntityDescription entityForName:@"Model" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entify];
    
    if (modelId.length == 0) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.iDMCC=%@" argumentArray:@[modelId]];
    [request setPredicate:predicate];
    
    NSArray *models = [managedObjectContext executeFetchRequest:request error:nil];
    
    return [models lastObject];
}

+ (NSArray *)findAllModels
{
    NSLog(@"%s", __FUNCTION__);
    NSEntityDescription *entify = [NSEntityDescription entityForName:@"Model" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entify];
    
    NSArray *models = [managedObjectContext executeFetchRequest:request error:nil];
    
    return models;
}

+ (BOOL)editModel:(Model *)model
{
    [managedObjectContext save:nil];
    
    return YES;
}

// 删除
+(BOOL)deleteModel:(NSString *)modelId
{
    NSLog(@"%s", __FUNCTION__);

    Model *model = [self findModelById:modelId];
    if (model == nil) {
        return NO;
    }
    [managedObjectContext deleteObject:model];
    return [managedObjectContext save:nil];
}

@end
