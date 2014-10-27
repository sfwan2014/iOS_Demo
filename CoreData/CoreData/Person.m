//
//  Person.m
//  CoreData
//
//  Created by shaofa on 14-5-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "Person.h"


@implementation Person

@dynamic name;
@dynamic school;
@dynamic age;
@dynamic cdid;

+ (Person *)createModel {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:currentManagedObjectContext];
}

-(void)savePerson
{
    [currentManagedObjectContext save:nil];
}

-(Person *)findPersonWithKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:currentManagedObjectContext];
    

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.cdid=%@" argumentArray:@[key]];
    [request setPredicate:predicate];
    
    NSArray *persons = [currentManagedObjectContext executeFetchRequest:request error:nil];
    
    return [persons lastObject];
}



@end
