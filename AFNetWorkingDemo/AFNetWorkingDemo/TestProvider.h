//
//  TestProvider.h
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJServerProvider.h"
@interface TestProvider : HJServerProvider
-(void) setRequestMethod:(NSString *)method params:(NSDictionary *)params;
@end
