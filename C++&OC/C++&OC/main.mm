//
//  main.m
//  C++&OC
//
//  Created by shaofa on 14-1-23.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"

int main(int argc, const char * argv[])
{

    Person *p = new Person();
    printf("%s %d\n", p->getName(), p->getAge());
    
    p->setAge(33);
    p->setName("rose");
    printf("%s %d\n", p->getName(), p->getAge());
    
    char *name = p->getName();
    int year = p->getAge() - 20;
    Car *car = [[Car alloc] init];
    [car setPerson:[NSString stringWithUTF8String:name]];
    [car setTime:year];
    
    NSLog(@"%@ %d", car.name, car.year);
    
    return 0;
}

