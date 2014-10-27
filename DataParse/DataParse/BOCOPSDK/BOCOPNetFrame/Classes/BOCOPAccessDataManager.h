//
//  BOCOPAccessDataManager.h
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOCOPAccessDataManager : NSObject

+ (BOCOPAccessDataManager *)sharedManager;


//分行通用接口查询(无登陆)
- (void)searchUnloginMcisCspWithRequestHeaders:(NSDictionary*)headers
                                  searchCriteria:(NSString *) param
                                      onComplete:(void (^)(NSString *info))onComplete
                                         onError:(void (^)(NSError *error))onError;

//分行通用接口查询(需要登陆)
- (void)searchLoginMcisCspWithRequestHeaders:(NSDictionary *)headers
                                searchCriteria:(NSString *)param
                                    onComplete:(void (^)(NSString *info))onComplete
                                       onError:(void (^)(NSError *error))onError;

//总行通用接口查询(无登陆)
- (void)searchUnloginMcisWithRequestHeaders:(NSDictionary*)headers
                              searchCriteria:(NSString *) param
                                  onComplete:(void (^)(NSString *info))onComplete
                                     onError:(void (^)(NSError *error))onError;

//总行通用接口查询(需要登录)
- (void)searchLoginMcisWithRequestHeaders:(NSDictionary *)headers
                            searchCriteria:(NSString *)param
                                onComplete:(void (^)(NSString *info))onComplete
                                   onError:(void (^)(NSError *error))onError;

@end
