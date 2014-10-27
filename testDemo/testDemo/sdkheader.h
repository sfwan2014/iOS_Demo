//
//  sdkheader.h
//  forwardSdk
//
//  Created by Huang Shounan on 12-9-6.
//  Copyright (c) 2012年 Huang Shounan. All rights reserved.
//

#ifndef __FORWARD_SDK_HEADER_H__
#define __FORWARD_SDK_HEADER_H__

#ifdef __cplusplus
extern "C" {
#endif //__cplusplus
    //证书的数据结构，X509格式的数据
    typedef struct _identityData {
        void *data; //证书的数据
        int len;    //证书数据的长度
    } IdentityData;
    

	#define SSL_AUTH_TYPE_FIRSTAUTH  	-1000 	/** 第一个认证 */ 
	#define SSL_AUTH_TYPE_CERTIFICATE  	0   	/** 证书认证 */
	#define SSL_AUTH_TYPE_PASSWORD      1   	/** 用户名密码认证 */
	#define SSL_AUTH_TYPE_SMS           2   	/** 短信认证 */
	#define SSL_AUTH_TYPE_SMS1          3   	/** 重新获取短信认证码 */
	#define SSL_AUTH_TYPE_HARDID        4   	/** 硬件特征码 */
	#define SSL_AUTH_TYPE_USBKEY        5   	/** USBKEY认证 */
	#define SSL_AUTH_TYPE_RADIUS        6   	/** RADIUS挑战认证 */
	#define SSL_AUTH_TYPE_TOKEN         7   	/** 令牌认证 */
	#define SSL_AUTH_TYPE_TWF           16  	/** TWF认证 */
	#define SSL_AUTH_TYPE_NONE          17  	/** 无认证 */

	#define PORPERTY_NamePasswordAuth_NAME      "NamePasswordAuth.name"
	#define PORPERTY_NamePasswordAuth_PASSWORD  "NamePasswordAuth.password"
	#define PORPERTY_HardIdAuth_HARDID          "HardIdAuth.hardid"

	#define CERT_PASSWORD                       "CertAuth.Certs.PassWord"          //证书的密码
	#define CERT_P12_FILE_NAME                  "CertAuth.Certs.P12File"           //P12证书路径
	#define CERT_PEM_KEY_FILE_NAME              "CertAuth.Certs.PEM.KeyFile"       //PEM key文件
	#define CERT_PEM_CERT_FILE_NAME             "CertAuth.Certs.Cert.KeyFile"      //PEM RTS私钥文件
	#define CERT_PEM_KEY_CONTENT                "CertAuth.Certs.PEM.KeyConten"     //PEM key内容编码
	#define CERT_PEM_CERT_CONTENT               "CertAuth.Certs.Cert.KeyConten"    //PEM RTS内容ASN1编码
	#define ACCESS_GROUPS_SHARE_KEY             "IndentfyAccessGroups.Key"         //keyChain共享的字符串
    #define CERT_AUTH_SLECT_AUTH                "CertAuth.Whether.Chosse.Identity" //设置证书选择证书标记

	/** 调用VPN初始化和认证接口后的结果，如果想获取具体信息可通过vpn_geterr()获取 **/
	typedef enum {
		RESULT_VPN_INIT_FAIL = -2, //初始化SVPN登陆失败
		RESULT_VPN_AUTH_FAIL = -1, //认证失败
		RESULT_VPN_NONE = 0, // 无效值
		RESULT_VPN_INIT_SUCCESS = 1, //初始化VPN成功
		RESULT_VPN_AUTH_SUCCESS = 2, //认证成功
		RESULT_VPN_AUTH_LOGOUT = 3, //vpn注销了
	} VPN_RESULT_NO;

	/** VPN状态码 **/
	typedef enum {
		VPN_STATUS_UNSTART = 0, // 未启动
		VPN_STATUS_INITING, //正在初始化
		VPN_STATUS_INIT_OK, // 初始化完成
		VPN_STATUS_LOGINING, // 正在进行认证
		VPN_STATUS_RELOGIN, // 重新进行认证
		VPN_STATUS_OK, // 也就是认证成功,正常运行中
		VPN_STATUS_EXITING, // 正在退出VPN的状态
		VPN_STATUS_ERR_THREAD // 非主线程错误
	} VPN_STATUS;

	/**
	 * @功能 SDK的VPN回调函数，注意它函数在新建的线程中回调，请调用都关心线程安全和线程死锁的问题
	 * @param vpnErrno vpn连接结果，成功返回ERROR_VPN_SUCCESS，失败返回对应的错误码，具体错误信息可通过获取错误信息接口获取
	 * @param authType 成功返回认证类型，失败返回无效值0
	 *
	 * @return 无
	 **/
	typedef void (*VPN_CALL_BACK)(const VPN_RESULT_NO result, const int authType);
    
    /**
     * @功能 证书认证时，证书内容参数回调函数
     * @param identityVec 证书数组
     * @param len  证书数组中证书的个数
     * @return  < count 返回证书认证中选择证书的索引值，－1标示不选择，没有符合的证书
     */
    typedef int (*CERT_AUTH_CALL_BACK)(const IdentityData *identityVec, const int count);

#ifdef __cplusplus
}
#endif //__cplusplus

#endif // __FORWARD_SDK_HEADER_H__
