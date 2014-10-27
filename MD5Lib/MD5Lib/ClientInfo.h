//
//  ClientInfo.h
//  CCBZZB_iPhone
//
//  Created by shaofa on 13-12-21.
//  Copyright (c) 2013年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientInfo : NSObject

+(NSString *)UIDFromCurrentDevice;
+(NSString *)systemVersion;
+(NSString *)systemName;

+(NSString *)currentNetwork;

+(NSString *)currentResolution;

+(NSString *)currentPushId;

+(NSString *)bundleId;

+(NSString *)MACAddress;

@end
