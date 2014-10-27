//
//  Person.h
//  CoreData
//
//  Created by shaofa on 14-5-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManger.h"

#define currentManagedObjectContext    [[DataManger shareDataManger] managedObjectContext]

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * cdid;

+ (Person *)createModel;
-(void)savePerson;

@end
