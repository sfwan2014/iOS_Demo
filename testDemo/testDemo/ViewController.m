//
//  ViewController.m
//  Auth
//
//  Created by Huang Shounan on 12-9-10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"
#include "svpn.h"
#include "sslvpnnb.h"
#include "sdkheader.h"
#include <arpa/inet.h>
#include "AsyncSocket.h"
#include <netdb.h>
#include <sys/timeb.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <openssl/bio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/pkcs12.h>
#include <openssl/err.h>
#include <openssl/x509.h>
#include <openssl/x509v3.h>
#include <openssl/x509v3.h>
#import "AuthHelper.h"
#include <sqlite3.h>
#include "SecItem.h"
#import "CustomClass.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+ITTAdditions.h"



// 以下是认证可能会用到的认证信息

short port = 443;                    //vpn设备端口号，一般为443
NSString *vpnIp = @"222.168.69.123"; //vpn设备IP地址139.210.98.254
NSString *userName1 = @"wangshuai";     //用户名认证的用户名  //zhengxiandong
NSString *password1 = @"123456"; //用户名认证的密码  // sangfor.com@jlnx.com
NSString *certName = @"qjx.p12";    //导入证书名字，如果服务端没有设置证书认证可以不设置
NSString *certPwd = @"123456";        //证书密码，如果服务端没有设置证书认证可以不设置
NSString *mainUrl =  @"http://193.168.5.54:8080/user/login.do";

@interface ViewController ()

@end

@implementation ViewController


@synthesize dnsName,result,connectBt,loginBt,dnsBt,helper,userName,password,name,sex,save;

- (void)viewDidLoad
{
    [super viewDidLoad];
     helper = [[AuthHelper alloc] initWithHostAndPort:vpnIp port:port delegate:self];
    isInit = NO;
    isStartConnect = NO;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filename = [[path objectAtIndex:0] stringByAppendingPathComponent:@"myfile"];
    sqlite3 *database = nil;
    if (sqlite3_open([filename UTF8String],&database) != SQLITE_OK)
    {
        sqlite3_close(database);
        NSLog(@"create sqlit failed!");
    }
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS (TAG INTERGER PRIMARY KEY, FIELD_DATA TEXT);";
    char *errString = nil;
    if (sqlite3_exec(database,[createSQL UTF8String],NULL,NULL,&errString) != SQLITE_OK)
    {
        sqlite3_close(database);
        NSLog(@"create sqlit tabel success!");
    }
    
    NSString *query = @"SELECT TAG, FIELD_DATA FROM FIELDS ORDER BY TAG";
    sqlite3_stmt *statement = nil;
    
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement,nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            int tag = sqlite3_column_int(statement, 0);
            char *rowData = (char*)sqlite3_column_text(statement, 1);
            UITextField *textFiled = (UITextField*)[self.view viewWithTag:tag];
            textFiled.text = [[NSString alloc] initWithUTF8String:rowData];
            NSLog(@"rowData = %s",rowData);
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
}

- (IBAction)backgroundTap:(id)sender
{
    [dnsName resignFirstResponder];
}

- (void) onCallBack:(const VPN_RESULT_NO)vpnErrno authType:(const int)authType
{
    switch (vpnErrno)
    {
        case RESULT_VPN_INIT_FAIL:
            say_err("Vpn Init failed!");
            break;
            
        case RESULT_VPN_AUTH_FAIL:
            say_err("Vpn auth failed!");
            break;
            
        case RESULT_VPN_INIT_SUCCESS:
            say_log("Vpn init success!");
            break;
        case RESULT_VPN_AUTH_SUCCESS:
            [self startOtherAuth:authType];
            
            break;
        case RESULT_VPN_AUTH_LOGOUT:
            say_log("Vpn logout success!");
            break;
            
        case RESULT_VPN_NONE:
            break;
            
        default:
            break;
    }

}

- (void) startOtherAuth:(const int)authType
{
    NSArray *paths = nil;
    switch (authType)
    {
        case SSL_AUTH_TYPE_CERTIFICATE:
            paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
            
            if (nil != paths && [paths count] > 0)
            {
                NSString *dirPaths = [paths objectAtIndex:0];
                NSString *authPaths = [dirPaths stringByAppendingPathComponent:certName];
                NSLog(@"PATH = %@",authPaths);
                [helper setAuthParam:@CERT_P12_FILE_NAME param:authPaths];
                [helper setAuthParam:@CERT_PASSWORD param:certPwd];
            }
            say_log("Start Cert Auth!!!");
            break;
            
        case SSL_AUTH_TYPE_PASSWORD:
            say_log("Start Password Name Auth!!!");
            [helper setAuthParam:@PORPERTY_NamePasswordAuth_NAME param:userName1];
            [helper setAuthParam:@PORPERTY_NamePasswordAuth_PASSWORD param:password1];
            break;
        case SSL_AUTH_TYPE_NONE:
            say_log("Auth success!!!");
            return;
        default:
            say_err("Other failed!!!");
            return;
    }
    [helper loginVpn:authType];
}

- (IBAction)btCliecked:(id)sender
{
    [userName resignFirstResponder];
    [password resignFirstResponder];
    [name resignFirstResponder];
    [sex resignFirstResponder];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filename = [[path objectAtIndex:0] stringByAppendingPathComponent:@"myfile"];
    sqlite3 *database = nil;
    if (sqlite3_open([filename UTF8String],&database) != SQLITE_OK)
    {
        sqlite3_close(database);
        NSLog(@"create sqlit failed!");
    }
    for (int i=1; i<5; ++i)
    {
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        const char *updata = "INSERT OR REPLACE INTO FIELDS (TAG, FIELD_DATA) VALUES (?, ?);";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database,updata,-1, &stmt,nil) == SQLITE_OK)
        {
            sqlite3_bind_int(stmt, 1, i);
            const char *text = [textField.text UTF8String];
            sqlite3_bind_text(stmt, 2, text, -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"failed");
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
}

-(IBAction)textFieldDoneEiditing:(id)sender
{
    [dnsName resignFirstResponder];
}

-(IBAction)buttonPressed:(id)sender
{
    if (!isInit)
    {
        [helper setUserNamePassword:userName1 password:password1];
        //set_file_crypt_rules("*");
        //[helper setAuthParam:@ACCESS_GROUPS_SHARE_KEY param:@"5Z429KX8JF.com.sangfor.share"];
       BOOL isSuccess = [helper loginVpn:SSL_AUTH_TYPE_PASSWORD];
        isInit = YES;
        [sender setTitle:@"注销" forState:UIControlStateNormal];
        [connectBt setEnabled:YES];
        [dnsBt setEnabled:YES];
        [dnsName setEnabled:YES];
    }
    else 
    {
        [helper logoutVpn];
        isInit = NO;
        [connectBt setEnabled:NO];
        [dnsBt setEnabled:NO];
        [dnsName setEnabled:NO];
        [sender setTitle:@"登陆" forState:UIControlStateNormal];
    }
}

- (IBAction)dnsButtonPressd:(id)sender
{
    [dnsName resignFirstResponder];
    result.text = [NSString stringWithCString:"Query Host,please wait..." encoding:NSUTF8StringEncoding];
    
    struct hostent* host = NULL;
    const char *ipStr = [dnsName.text UTF8String];
    
    NSLog(@"Request Host Name:%s",ipStr);
    if (ipStr != NULL && ipStr[0] != 0)
    {
        host = gethostbyname(ipStr);
        if (host == NULL)
        {
            result.text = [NSString stringWithCString:"No Record!" encoding:NSUTF8StringEncoding];
        }
        else if (host->h_addrtype == AF_INET)
        {
            uint32_t addr = *((uint32_t*)(host->h_addr_list[0]));
            struct in_addr in_addr;
            in_addr.s_addr = addr;
            char *strAddr = inet_ntoa(in_addr);
            result.text = [NSString stringWithCString:strAddr encoding:NSUTF8StringEncoding];            
        }
    }
    else
    {
        result.text = [NSString stringWithCString:"Invalid Host Name!" encoding:NSUTF8StringEncoding];
    }
    
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"jlrcu" forKey:@"username"];
    NSString *passWord = @"12345678";
    passWord = [passWord md5];
    [params setObject:passWord forKey:@"password"];
    [CustomClass requestWithURL:mainUrl params:params httpMethod:@"GET" finishBlock:^(id result) {
        if (result) {
            NSLog(@"%@",result);
        }
        
    }];

}

-(IBAction)connectToServer:(id)sender
{
    if (isStartConnect)
    {
        NSLog(@"already isStartConnect...");
        return;
    }
    isStartConnect = YES;
    UIAlertView *view = nil;
    NSString *str = nil;
    if (!isInit)
    {
         NSLog(@"already !isIni");
        str = [NSString stringWithFormat:@"You don't start Auth, please start Auth"];
        goto loop;
    }
    else
    {
        NSLog(@"already Auth in proces");
        VPN_STATUS state = vpn_query_status();
        if (state != VPN_STATUS_OK)
        {
            str = @"Auth in process,or failed!";
            goto loop;
        }
    }
    say_log("Start Connect Server!");

    if([self NSURLConnect_] != 0)
    {
        say_err("NSURLConnect_ failed!");
        goto out;
    }
    say_err("NSURLConnect_ okok.!");
    
    if ([self transferDataWithAsynceSocket] == -1)
    {
        NSLog(@"transferDataWithAsynceSocket failed!");
        goto out;
    }
    if ([self transferDataWithCFStream] == -1)
    {
        say_err("tranferDataWithCFStream failed!");
        goto out;
    }

    str = @"Send Success!";
    
loop:    
    view = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self  cancelButtonTitle:@"Yes" otherButtonTitles:nil];

    [view show];
    [view release];
    [str release];
out:
    isStartConnect = NO;
    return;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [helper quitLogin];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (int) transferDataWithConnect
{
    int sockfd = socket(AF_INET,SOCK_STREAM, 0);
    if (sockfd == -1)
    {
        perror("socket failed!");
        return -1;
    }
    
    struct sockaddr_in serAddr;
    
    serAddr.sin_family = PF_INET;
    serAddr.sin_addr.s_addr = inet_addr("10.79.0.40");
    serAddr.sin_port = htons(80);
    if (connect(sockfd,(struct sockaddr*)&serAddr,sizeof(serAddr)) != 0)
    {
        perror("connect failed!");
        return -1;
    }
    const char *getcmd = "GET /\r\n\r\n";
    
    if (write(sockfd,getcmd,strlen(getcmd)) != strlen(getcmd))
    {
        perror("write failed");
        return -1;
    }
    int ret = 0;
    char buffer[201] = {0};
    while (1)
    {
        ret = read(sockfd,buffer,sizeof(buffer)-1);
        if (ret == -1)
        {
            perror("read failed");
            return -1;
        }
        else if (ret == 0)
        {
            say_log("recv finished!");
            break;
        }
        printf("recv %d bytes from server!\n",ret);
    }

    return 0;
}

- (int) transferDataWithCFStream
{
    NSInputStream *is = nil;
    NSOutputStream *os = nil;
    CFReadStreamRef *cfis = nil;
    CFWriteStreamRef *cfos = nil;
    //CFSocketRef socket = CFSocketCreate(NULL,AF_INET, SOCK_STREAM,IPPROTO_TCP,0,NULL,NULL);
    CFStringRef serverString = CFStringCreateWithCString(NULL,"200.200.73.65",kCFStringEncodingASCII);
    CFStreamCreatePairWithSocketToHost(NULL,serverString,80,(CFReadStreamRef*)&cfis,(CFWriteStreamRef*)&cfos);
    is = (NSInputStream*)cfis;
    os = (NSOutputStream*)cfos;
    
    [is open];
    [os open];
    
    char *getCmd1 = "GET /\r\n\r\n";

    
    int send = [os write:(const uint8_t*)getCmd1 maxLength:strlen(getCmd1)];
    if (send < 0)
    {
        perror("send error!\n");
    }
    
    uint8_t buffer1[201] = {0};
    int bytest = 0;
    while ([os hasSpaceAvailable])
    {
        bytest = [is read:buffer1 maxLength:sizeof(buffer1) -1];
        if (bytest == -1)
        {
            perror("recv error");
            return -1;
        }
        else if (bytest == 0)
        {
            NSLog(@"Recv end!");
            return 0;
        }
        else
        {
            NSLog(@"has read %d bytest from server!",bytest);
        }
    }
    return 0;
}
-(int)NSURLConnect_
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSError *err = nil ;
    
//    NSString *desturl =[NSString stringWithFormat:@"%s","http://200.200.73.65/"]; //get_res_new.ph
     NSString *desturl =[NSString stringWithFormat:@"%@",mainUrl];
	
	NSURL *url=[NSURL URLWithString:desturl];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
																cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
															timeoutInterval:10];
	
    
	[request setHTTPMethod:@"GET"];
	[request setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
	
    
	NSData *data=[NSURLConnection sendSynchronousRequest:request
									   returningResponse:nil 
												   error:&err];
    
	
	[request release];
    
    NSString *result1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
	NSLog(@"the result:%@  ==%d",result1,[data length]);
    [pool release];
    return 0;
}
-(int) transferDataWithAsynceSocket
{
    asySocket = [[AsyncSocket alloc] initWithDelegate:self];
    if (![asySocket connectToHost:@"91.109.11.121" onPort:9080 error:nil])
    {
        perror("connect failed!");
        return -1;
    }
    return 0;
}

- (void) onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Success connect to server!");
    
    char cmd[] = "GET /\r\n\r\n";

    NSData *data = [NSData dataWithBytes:cmd length:sizeof(cmd)-1];
    
    [asySocket writeData:data withTimeout:-1 tag:1];
}


- (void) onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataWithTimeout:-1 tag:1];
}

- (void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"has recv %d bytes!",[str length]);
    [sock readDataWithTimeout:-1 tag:1];
    
}

-(void) onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Read finished!");
}

-(void) testGethostbyname
{
    char *testbuffer[] = {"qjxhost","test_tcp","12323sdjfs","s12623786287628","qjxlocalhost","www.baidu.com",NULL};
    
    
    struct hostent *host = NULL;
    
    int i = 0;
    
    while (testbuffer[i])
    {
        host = gethostbyname(testbuffer[i]);
        if (host == NULL)
        {
            NSLog(@"gethostbyname failed!");
        }
        else if (host->h_addrtype == AF_INET)
        {
            uint32_t addr = *((uint32_t*)(host->h_addr_list[0]));
            struct in_addr in_addr;
            in_addr.s_addr = addr;
            char *strAddr = inet_ntoa(in_addr);
            NSLog(@"%s host is %s",testbuffer[i],strAddr);
        }
        else if (host->h_addrtype == AF_INET6)
        {
            
        }
        NSLog(@"gethost %s finnished!",testbuffer[i]);
        ++i;
    }
        
}

- (void) testGethostbyname2
{
    
}


//- (NSString *)md5:(NSString *)md5Str
//{
//	const char *concat_str = [md5Str UTF8String];
//	unsigned char resultMd5[CC_MD5_DIGEST_LENGTH];
//	CC_MD5(concat_str, strlen(concat_str), resultMd5);
//	NSMutableString *hash = [NSMutableString string];
//	for (int i = 0; i < 16; i++){
//		[hash appendFormat:@"%02X", resultMd5[i]];
//	}
//	return [hash lowercaseString];
//	
//}

@end
