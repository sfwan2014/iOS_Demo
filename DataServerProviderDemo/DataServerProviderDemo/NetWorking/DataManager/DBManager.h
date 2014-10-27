//
//  DBManager.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
+ (DBManager *)defaultDBManager;

//此对象用来操作数据的
@property(nonatomic,retain)NSManagedObjectContext *managedObjectContext;

//此对象用于管理数据模型文件
@property(nonatomic,retain)NSManagedObjectModel *managedObjectModel;

//此对象是用来管理持久化数据的本地文件
@property(nonatomic,retain)NSPersistentStoreCoordinator *persistentSoreCoordinator;
@end
