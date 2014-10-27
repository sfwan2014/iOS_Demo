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

static BaseDBManager *_instance = nil;
+(BaseDBManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[BaseDBManager alloc] init];
        }
    });
    
    return _instance;
}

// 创建
- (HJBaseModel *)createModel {
    return [NSEntityDescription insertNewObjectForEntityForName:_modelName inManagedObjectContext:managedObjectContext];
}

//增加
- (BOOL)addModel:(HJBaseModel *)model {
    
    NSLog(@"%s", __FUNCTION__);
    
    return [managedObjectContext save:nil];
}

// 查找
- (HJBaseModel *)findModelById:(NSString *)modelId
{
    NSLog(@"%s", __FUNCTION__);
    NSEntityDescription *entify = [NSEntityDescription entityForName:_modelName inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entify];
    
    if (modelId.length == 0) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.uID=%@" argumentArray:@[modelId]];
    [request setPredicate:predicate];
    
    NSArray *models = [managedObjectContext executeFetchRequest:request error:nil];
    
    return [models lastObject];
}

- (NSArray *)findAllModels
{
    
    NSLog(@"%s", __FUNCTION__);
    NSEntityDescription *entify = [NSEntityDescription entityForName:_modelName inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entify];
    
    NSArray *models = [managedObjectContext executeFetchRequest:request error:nil];
    
    return models;
}


-(void)quaryAllDatas:(FinishBlock)block{
    dispatch_queue_t queue = dispatch_queue_create("mtts", NULL);
    dispatch_async(queue, ^{
        NSLog(@"%s", __FUNCTION__);
        NSEntityDescription *entify = [NSEntityDescription entityForName:_modelName inManagedObjectContext:managedObjectContext];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entify];
        
        NSArray *models = [managedObjectContext executeFetchRequest:request error:nil];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            block(models);
        });
        
    });
}

- (BOOL)editModel:(HJBaseModel *)model
{
    [managedObjectContext save:nil];
    
    return YES;
}

// 删除
- (BOOL)deleteModel:(NSString *)modelId
{
    NSLog(@"%s", __FUNCTION__);

    HJBaseModel *model = [self findModelById:modelId];
    if (model == nil) {
        return NO;
    }
    [managedObjectContext deleteObject:model];
    return [managedObjectContext save:nil];
}

- (void)deleteAllData
{
    [managedObjectContext deletedObjects];
    [managedObjectContext save:nil];
}

@end
