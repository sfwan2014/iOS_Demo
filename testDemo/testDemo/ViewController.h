//
//  ViewController.h
//  Auth
//
//  Created by Huang Shounan on 12-9-10.
//
//

#import <UIKit/UIKit.h>
#import "sdkheader.h"
#include "AuthHelper.h"

#define say_log(str) printf("[log]:%s,%s,%d:%s\n",__FILE__,__FUNCTION__,__LINE__,str)
#define say_err(err) printf("[log]:%s,%s,%d:%s,%s\n",__FILE__,__FUNCTION__,__LINE__,err,get_err())
#define get_err() ssl_vpn_get_err()

@class AsyncSocket;

@interface ViewController : UIViewController<SangforSDKDelegate>
{
    AuthHelper *helper;
    UITextField *userName;
    UITextField *password;
    UITextField *name;
    UITextField *sex;
    
    UITextField *dnsName;
    UILabel *result;
    UIButton *loginBt;
    UIButton *connectBt;
    UIButton *dnsBt;
    UIButton *save;

    BOOL isInit;
    BOOL isStartConnect;
    AsyncSocket *asySocket;
}
@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *sex;

@property (nonatomic, retain) IBOutlet UITextField *dnsName;
@property (nonatomic, retain) IBOutlet UIButton *save;
@property (nonatomic, retain) IBOutlet UIButton *loginBt;
@property (nonatomic, retain) IBOutlet UIButton *connectBt;
@property (nonatomic, retain) IBOutlet UILabel *result;
@property (nonatomic, retain) IBOutlet UIButton *dnsBt;
@property (nonatomic, retain) AuthHelper *helper;

- (IBAction)buttonPressed:(id)sender;

- (IBAction)connectToServer:(id)sender;

- (IBAction)dnsButtonPressd:(id)sender;

- (IBAction)textFieldDoneEiditing:(id)sender;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)btCliecked:(id)sender;

- (int) transferDataWithConnect;

- (int) transferDataWithCFStream;

- (int) transferDataWithAsynceSocket;

- (void) testGethostbyname;

- (void) testGethostbyname2;

//- (void) onCallBack:(const VPN_RESULT_NO)vpnErrno authType:(const int)authType;

- (void) startOtherAuth:(const int)authType;

@end
