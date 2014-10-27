//
//  BOCOPPayByteRequestManager.h
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BOCOPByteDataRequest;

@interface BOCOPByteRequestManager : NSObject{
    NSMutableArray *_requests;
}
/**
 单列初始化
 @param  无
 @return 没有返回值
 */
+ (BOCOPByteRequestManager *)sharedManager;

/**
 request 天假;
 @param  无;
 @return 无;
 */
- (void)addRequest:(BOCOPByteDataRequest*)request;

/**
 request 移除;
 @param  无;
 @return 无;
 */
- (void)removeRequest:(BOCOPByteDataRequest*)request;

/**
 request 清空;
 @param  无;
 @return 无;
 */
- (void)cleanAllRequest;
@end
