//
//  Person.h
//  iPadDemo
//
//  Created by shaofa on 14-2-14.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *loveDog;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addLoveDogObject:(Dog *)value;
- (void)removeLoveDogObject:(Dog *)value;
- (void)addLoveDog:(NSSet *)values;
- (void)removeLoveDog:(NSSet *)values;

@end
