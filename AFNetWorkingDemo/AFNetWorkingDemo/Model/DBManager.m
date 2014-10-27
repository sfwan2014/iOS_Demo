//
//  DBManager.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "DBManager.h"
#import <CoreData/CoreData.h>

static DBManager *instance = nil;

@implementation DBManager

+ (DBManager *)defaultDBManager {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [[[self class] alloc] init];
        }
    }
    
    return instance;
}


//获取NSManagedObjectContext对象，此对象用来操作数据的
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentSoreCoordinator];
    
    return _managedObjectContext;
}

//获取NSPersistentStoreCoordinator对象，此对象用来管理本地的持久化文件的
- (NSPersistentStoreCoordinator *)persistentSoreCoordinator {
    if (_persistentSoreCoordinator != nil) {
        return _persistentSoreCoordinator;
    }
    
    _persistentSoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    
    //    NSString *sotrePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *storePath = [paths lastObject];
    storePath = [storePath stringByAppendingPathComponent:@"data.sqlite"];
    
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    /*
     配置CoreData持久化的方式
     NSSQLiteStoreType  //使用sqlite做数据持久化
     NSXMLStoreType     //使用xml做数据持久化
     NSBinaryStoreType   //使用二进制做数据持久化
     NSInMemoryStoreType
     */
    NSError *error;
    [_persistentSoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeURL
                                                   options:nil
                                                     error:&error];
    
    return _persistentSoreCoordinator;
}

//获取NSManagedObjectModel对象，此对象用来管理数据模型文件的
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}
@end
