//
//  Dog.h
//  iPadDemo
//
//  Created by shaofa on 14-2-14.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dog : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;

@end
