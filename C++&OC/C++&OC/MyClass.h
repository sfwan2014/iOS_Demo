//
//  MyClass.h
//  C++&OC
//
//  Created by shaofa on 14-1-23.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#ifndef __C___OC__MyClass__
#define __C___OC__MyClass__

#include <iostream>

class Person{
private:
    int _age;
    char *_name;
public:
    
    ~Person();
    Person();
    int getAge();
    void setAge(int age);
    
    char *getName();
    void setName(const char *name);
    
    
};

#endif /* defined(__C___OC__MyClass__) */

#import <Foundation/Foundation.h>

@interface Car : NSObject

-(void)setPerson:(NSString *)name;
-(NSString *)name;

-(void)setTime:(int)year;
-(int)year;

@end
