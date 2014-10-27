//
//  BOCOPRequestManager.h
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BOCOPDataRequest;

@interface BOCOPRequestManager : NSObject{
    NSMutableArray *_requests;
}
/**
 单列初始化
 @param  无
 @return 没有返回值
 */
+ (BOCOPRequestManager *)sharedManager;

/**
 request 天假;
 @param  无;
 @return 无;
 */
- (void)addRequest:(BOCOPDataRequest*)request;

/**
 request 移除;
 @param  无;
 @return 无;
 */
- (void)removeRequest:(BOCOPDataRequest*)request;

/**
 request 清空;
 @param  无;
 @return 无;
 */
- (void)cleanAllRequest;
@end
