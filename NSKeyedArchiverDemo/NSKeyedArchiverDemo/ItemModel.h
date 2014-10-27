//
//  ItemModel.h
//  NSKeyedArchiverDemo
//
//  Created by shaofa on 14-3-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFBaseModel.h"

@interface ItemModel :SFBaseModel

@property(nonatomic, copy)NSString *name;
@property(nonatomic, retain)NSNumber *idNum;
@property(nonatomic, retain)NSData *imgData;

@end
