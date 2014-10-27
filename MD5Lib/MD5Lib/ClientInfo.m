//
//  ClientInfo.m
//  CCBZZB_iPhone
//
//  Created by shaofa on 13-12-21.
//  Copyright (c) 2013年 shaofa. All rights reserved.
//

#import "ClientInfo.h"
#import <sys/types.h>
#import <sys/param.h>
#import <sys/ioctl.h>
#import <sys/socket.h>
#import <net/if.h>
#import <netinet/in.h>
#import <net/if_dl.h>
#import <sys/sysctl.h>

@implementation ClientInfo

+(NSString *)UIDFromCurrentDevice
{
    
    UIDevice *device = [UIDevice currentDevice];
    NSUUID *UUID = [device identifierForVendor];
    return [UUID UUIDString];
}

+(NSString *)currentPushId
{
    NSString *pushId = [[NSUserDefaults standardUserDefaults] objectForKey:@"pushId"];
    if (pushId.length == 0) {
        pushId = @"0";
    }
    return pushId;
}

+(NSString *)systemName
{
    NSString *systemName = [[UIDevice currentDevice] systemName];
    
    return systemName;
}

+(NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+(NSString *)currentNetwork
{
    return Nil;
}

+(NSString *)bundleId
{
    //获取info－plist
    NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];
    //获取Bundle identifier
    NSString *appName  =   [dic objectForKey:@"CFBundleIdentifier"];
    return appName;
}

+(NSString *)currentResolution
{
    CGRect frame = [UIScreen mainScreen].bounds;
    CGSize screenSize = frame.size;
    
    float scale = [UIScreen mainScreen].scale;
    
    NSString *resolution = [NSString stringWithFormat:@"%.0f*%.0f",screenSize.height*scale, screenSize.width * scale];
    
    return resolution;
}

void GetMACAddress(unsigned char *mac){
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error:iif_nametoindex error/n");
        return;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error:sysctl, take 1/n");
        return;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take2");
        return;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    memcpy(mac, ptr, 6);
    free(buf);
}

+(NSString *)MACAddress
{
    NSString *address = nil;
    
    unsigned char *mac = NULL;
    const char *macCh = NULL;
    GetMACAddress(mac);
    macCh = (const char *)mac;
    address =  [NSString stringWithUTF8String:macCh];
    return address;
}

@end
