//
//  TestModel.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseModel.h"

@interface TestModel : BaseModel

@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) id author;
@property (nonatomic, retain) NSString *pubdate;
@property (nonatomic, retain) NSString *alt;
@property (nonatomic, retain) NSString *uID;
@property (nonatomic, retain) NSArray *tags;

@end
