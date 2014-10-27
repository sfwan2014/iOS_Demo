//
//  AuthDelegate.m
//  Auth
//
//  Created by Huang Shounan on 12-11-13.
//
//

#import <netinet/in.h>
#import <sys/socket.h>
#include <arpa/inet.h>
#import "AuthHelper.h"
//#import "ViewController.h"
#import "sslvpnnb.h"

static void g_callBack(const VPN_RESULT_NO result, const int authType)
{
    id<SangforSDKDelegate> delegate = [AuthHelper getGlobalDelegate];
    
    if (delegate!=nil && [delegate respondsToSelector:@selector(onCallBack:authType:)])
    {
        [delegate onCallBack:result authType:authType];
    }
}

static int g_selectCertCallBack(const IdentityData *identityVec, const int count)
{
    id<SangforSDKDelegate> delegate = [AuthHelper getGlobalDelegate];
    if (delegate!=nil && [delegate respondsToSelector:@selector(onSelectIdentity:count:)]) {
        return [delegate onSelectIdentity:identityVec count:count];
    }
    return -1;
}

@implementation AuthHelper

static id<SangforSDKDelegate> shareDelegate = nil;

+ (id<SangforSDKDelegate>)getGlobalDelegate
{
    if (shareDelegate != nil)
    {
        return shareDelegate;
    }
    return nil;
}

- (id)initWithHostAndPort:(NSString *)host port:(short)port delegate:(id) delegate
{
    self = [super init];
    
    shareDelegate = delegate;
    
    uint32_t vpnAddr = inet_addr([host UTF8String]);
    uint16_t vpnPort = htons(port);
    
    ssl_vpn_init(g_callBack,vpnAddr,vpnPort);
    
    return self;
}

- (int) loginVpn:(const int )authType
{
    return ssl_vpn_login(authType);
}

- (int) setUserNamePassword:(NSString *)userName password:(NSString *)password
{
    const char *name = [userName UTF8String];
    const char *pwd = [password UTF8String];
    
    if (ssl_vpn_set_login_param(PORPERTY_NamePasswordAuth_NAME,(char*)name) < 0)
    {
        return -1;
    }
    if (ssl_vpn_set_login_param(PORPERTY_NamePasswordAuth_PASSWORD,(char*)pwd) < 0)
    {
        return -1;
    }
    return 0;
}

- (void) setDnsServer:(NSString *)server
{
    return ssl_set_dns_server([server UTF8String]);
}

-(int) setAuthParam:(NSString *)key param:(NSString*)value
{
    const char *charKey = [key UTF8String];
    const char *charValue = NULL;
    char tmp[20] = {0};
    
    if (!strncmp(charKey,CERT_AUTH_SLECT_AUTH,sizeof(CERT_AUTH_SLECT_AUTH))) {
        snprintf(tmp,sizeof(tmp),"%d",(int)g_selectCertCallBack);
        charValue = tmp;
    } else {
        charValue = [value UTF8String];
    }    
    return ssl_vpn_set_login_param(charKey,(char*)charValue);
}

- (int) logoutVpn
{
    return ssl_vpn_logout();
}

- (int) quitLogin
{
    shareDelegate = nil;
    return ssl_vpn_quit();
}


@end
