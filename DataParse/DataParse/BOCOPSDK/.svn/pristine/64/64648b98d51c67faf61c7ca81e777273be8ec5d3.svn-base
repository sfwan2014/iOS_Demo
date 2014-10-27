//
//  BOCOP.h
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCOPModels.h"

@interface BOCOP : NSObject

/**
 单列模式定义
 @param  无
 @return BOCOPPay
 */
+ (BOCOP *)sharedInstance;

/**
 分行通用接口,无需登录
 @param  heard 报文头  param 报文体,为mcisCsp报文
 @return  info 是mcis字节数组
 */
- (void)searchUnloginMcisCspWithRequestHeaders:(NSDictionary*)headers
                                searchCriteria:(NSString *) param
                                    onComplete:(void (^)(NSString *info))onComplete
                                       onError:(void (^)(NSError *error))onError;

/**
 分行通用接口查询，需要登陆
 @param  type 交易类型 param 报文体参数
 @return info 返回mcis字节数组
 */
- (void)searchLoginMcisCspWithRequestHeaders:(NSDictionary *)headers
                              searchCriteria:(NSString *)param
                                  onComplete:(void (^)(NSString *info))onComplete
                                     onError:(void (^)(NSError *error))onError;

/**
 总行通用接口查询,无需登陆
 @param heard 报文头   param 报文体
 @return info 返回mcis字节数组
 */
- (void)searchUnloginMcisWithRequestHeaders:(NSDictionary*)headers
                             searchCriteria:(NSString *) param
                                 onComplete:(void (^)(NSString *info))onComplete
                                    onError:(void (^)(NSError *error))onError;

/**
 总行通用接口查询,需要登录
 @param param 报文体参数
 @return info 返回mcis字节数组
 */
- (void)searchLoginMcisWithRequestHeaders:(NSDictionary *)headers
                           searchCriteria:(NSString *)param
                               onComplete:(void (^)(NSString *info))onComplete
                                  onError:(void (^)(NSError *error))onError;

@end
