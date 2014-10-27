//
//  AuthDelegate.h
//  Auth
//
//  Created by Huang Shounan on 12-11-13.
//
//

#import <Foundation/Foundation.h>
#include "sdkheader.h"

@protocol SangforSDKDelegate<NSObject>

@required

- (void) onCallBack:(const VPN_RESULT_NO)vpnErrno authType:(const int)authType;

@optional

- (int) onSelectIdentity:(const IdentityData*)vector count:(int)count;

@end

@interface AuthHelper : NSObject

+ (id<SangforSDKDelegate>)getGlobalDelegate;

- (id)initWithHostAndPort:(NSString *)host port:(short)port delegate:(id <SangforSDKDelegate>)delegate;

- (int) setUserNamePassword:(NSString *)userName password:(NSString *)password;

- (void) setDnsServer:(NSString *)server;

-(int) setAuthParam:(NSString *)key param:(NSString*)value;

- (int) loginVpn:(const int )authType;

- (int) logoutVpn;

- (int) quitLogin;


@end
