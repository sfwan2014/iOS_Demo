//
//  BaseModel.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HJBaseModel : NSManagedObject
+(NSString *)modelName;

@end

@interface HJBaseModel (Attribute)
- (id)initWithContent:(id)json;
- (void)setContent:(id)json;
@end