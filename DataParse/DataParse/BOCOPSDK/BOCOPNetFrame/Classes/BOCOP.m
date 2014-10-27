//
//  BOCOP.m
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import "BOCOP.h"
#import "BOCOPObjectSingleton.h"
#import "BOCOPAccessDataManager.h"

@implementation BOCOP
BOCOPOBJECT_SINGLETON_BOILERPLATE(BOCOP, sharedInstance)

/**
 
 
 */
- (id)init{
    if (self = [super init]) {
    
    }
    return self;
}

/**
 分行通用接口,无需登录
 @param  heard 报文头  param 报文体,为mcisCsp报文
 @return  info 是mcis字节数组
 */
- (void)searchUnloginMcisCspWithRequestHeaders:(NSDictionary*)headers
                                searchCriteria:(NSString *) param
                                    onComplete:(void (^)(NSString *info))onComplete
                                       onError:(void (^)(NSError *error))onError
{
    [[BOCOPAccessDataManager sharedManager] searchUnloginMcisCspWithRequestHeaders:headers
                                                                    searchCriteria:param
                                                                        onComplete:^(NSString *info) {
                                                                            onComplete(info);
                                                                        } onError:^(NSError *error) {
                                                                            onError(error);
                                                                        }];
}

/**
 分行通用接口查询，需要登陆
 @param  type 交易类型 param 报文体参数
 @return info 返回mcis字节数组
 */

- (void)searchLoginMcisCspWithRequestHeaders:(NSDictionary *)headers
                              searchCriteria:(NSString *)param
                                  onComplete:(void (^)(NSString *info))onComplete
                                     onError:(void (^)(NSError *error))onError
{
    [[BOCOPAccessDataManager sharedManager] searchLoginMcisCspWithRequestHeaders:headers
                                                                  searchCriteria:param
                                                                      onComplete:^(NSString *info) {
                                                                          onComplete(info);
                                                                      } onError:^(NSError *error) {
                                                                          onError(error);
                                                                      }];
}

/**
 总行通用接口查询,无需登陆
 @param heard 报文头   param 报文体
 @return info 返回mcis字节数组
 */


- (void)searchUnloginMcisWithRequestHeaders:(NSDictionary*)headers
                             searchCriteria:(NSString *) param
                                 onComplete:(void (^)(NSString *info))onComplete
                                    onError:(void (^)(NSError *error))onError
{
    [[BOCOPAccessDataManager sharedManager] searchUnloginMcisWithRequestHeaders:headers
                                                                 searchCriteria:param
                                                                     onComplete:^(NSString *info) {
                                                                         onComplete(info);
                                                                     } onError:^(NSError *error) {
                                                                         onError(error);
                                                                     }];
}

/**
 总行通用接口查询,需要登录
 @param param 报文体参数
 @return info 返回mcis字节数组
 */

- (void)searchLoginMcisWithRequestHeaders:(NSDictionary *)headers
                           searchCriteria:(NSString *)param
                               onComplete:(void (^)(NSString *info))onComplete
                                  onError:(void (^)(NSError *error))onError
{
    [[BOCOPAccessDataManager sharedManager] searchLoginMcisWithRequestHeaders:headers
                                                               searchCriteria:param
                                                                   onComplete:^(NSString *info) {
                                                                       onComplete(info);
                                                                   } onError:^(NSError *error) {
                                                                       onError(error);
                                                                   }];
}

@end
