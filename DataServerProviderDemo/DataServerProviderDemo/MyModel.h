//
//  MyModel.h
//  DataServerProviderDemo
//
//  Created by sfwan on 14-7-2.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJBaseModel.h"


@interface MyModel : HJBaseModel

@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * uID;

@end
