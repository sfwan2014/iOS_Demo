//
//  DataManger.h
//  CoreData
//
//  Created by shaofa on 14-5-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManger : NSObject

+(DataManger *)shareDataManger;

-(NSManagedObjectContext *)managedObjectContext;

@end
