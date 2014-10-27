//
//  MyClass.cpp
//  C++&OC
//
//  Created by shaofa on 14-1-23.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#include "MyClass.h"


Person::Person(){
    _age = 21;
    const char *str = "jack";
    long l = strlen(str);
    _name = new char[l];
    strcpy(_name, str);
};

Person::~Person(){
    
}

int Person::getAge(){
    return _age;
}

void Person::setAge(int age){
    _age = age;
}

char* Person::getName(){
    return _name;
}

void Person::setName(const char *name) {
    
    long l = strlen(name);
    _name = new char[l];
    strcpy(_name, name);
}

@implementation Car
{
    NSString *_name;
    int _year;
}

- (id)init
{
    self = [super init];
    if (self) {
        _name = @"hehe";
        _year = 4;
    }
    return self;
}

-(void)setPerson:(NSString *)name
{
    _name = name;
}

-(NSString *)name
{
    return _name;
}

-(void)setTime:(int)year
{
    _year = year;
}

-(int)year
{
    return _year;
}

@end

