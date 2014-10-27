//
//  CustomClass.h
//  
//
//  Created by Fudongdong on 13-10-25.
//  Copyright (c) 2013年 Fudongdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"


typedef void(^FinishLoadData)(id result);

@interface CustomClass : NSObject

+ (UIColor *) colorWithHexString: (NSString *)color;
//将16进制颜色转换成UIColor对象

+(ASIHTTPRequest *)requestWithURL:(NSString *)url
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                      finishBlock:(FinishLoadData)block;

@end
