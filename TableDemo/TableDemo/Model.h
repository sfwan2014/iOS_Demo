//
//  Model.h
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Model : NSManagedObject

-(Model *)modelFromModel:(Model *)model;

@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSString * clsName;
@property (nonatomic, retain) NSString * iDMCC;
@property (nonatomic, retain) NSString * shopType;
@property (nonatomic, retain) NSString * rate;

@end
