//
//  Company: Sangfor
//  libSagfor
//
//  Created by on 12-9-1.
//
//

#ifndef  _SSLAUTH_H_
#define  _SSLAUTH_H_

#import "sdkheader.h"


/*******************************************************************
    注意：以下接口调用必须在主线程中调用，否则会返回非主线程调用接口的错误，
         同时以下接口调用都是以非阻塞的方式调用，请使用者加以注意！！！
 *******************************************************************/

#ifdef __cplusplus
extern "C"
{
#endif
    
    /**
     * @功能：初始化vpn信息，包括初始化的回调函数，VPN服务器IP地址，端口号
     * @param callBack 回调函数指针，初始化为nil时，表示不设置回调函数
     * @param host［in］VPN服务器Ipd地址，注意为网络序，一定为有效的地址和端口
     * @param port［in］VPN服务器端口，注意为网络序
     * return 0表示初始化成功，－1表示失败
     **/
    int ssl_vpn_init(VPN_CALL_BACK callback,uint32_t host,uint16_t port);


    /**
     *@功能：开始登陆VPN，开始循环认证一系列认证方式（认证顺序方式由服务端配置决定）
     *@param authType     ［in］ 当前认证的类型
     *@return 0表示当前认证预成功，注意并不表示认证成功，若要知道认证是否成功，
     *          需要查看回调函数中的认证类型认证错误码； 
     **/
    int ssl_vpn_login(const int authType);
    
    /**
     *@ 功能：注销登陆VPN服务器
     *return 0表示注销成功，－1表示失败
     **/
    int ssl_vpn_logout(void);


    /**
     * @ 功能：查询VPN当前状态，注意判断VPN认证是否成功可以调用此函数查询
     * return 返回的VPN状态码，可能情况有三大类：1.认证成功，2.正在认真过程当中，3.认证失败; 注意当认
     *        真失败时，可以调用ssl_vpn_get_err获取错误原因字符串，具体返回值查看与错误相关的宏定义
     **/
    VPN_STATUS ssl_vpn_query_auth_state(void);


    /**
     * @功能 获取VPN错误字符串
     * return NULL表示获取失败，非NULL表示成功返回的错误提示字符串
     **/
    const char* ssl_vpn_get_err(void);

    /**
     * @功能 设置键值对
     * @param key   键名
     * @param value 键值
     **/
    int ssl_vpn_set_login_param(const char* key, char* value);
    

    /**
     * @功能 获取硬件特征码信息，以字符串的形式返回
     *
     * @return 硬件特征码，注意可能获取失败。失败时返回NULL
     **/
    const char* ssl_vpn_query_hardid();
	
    /**
     * @功能 取硬件特征码时不取网卡的值
     *
     * @return 成功0，失败－1
     **/
    int ssl_set_no_eth_hardid();

    /**
     * @功能 退出VPN
     **/
    int ssl_vpn_quit(void);
    

    /**
     * @功能 设置dns 服务器的IP地址
     * @dnsServer dnsServer服务器Ip地址字符串
     **/
    void ssl_set_dns_server(const char *dnsServer);
    
    /**
     * @功能 获取SDK版本号
     * @return 返回SDK的版本号字符串
     */
    const char *ssl_get_version(void);
    
    /**
     * @功能 设置文件加密规则,注意rules可以用';'号隔开，设置多条规则，
     *       例如: *／Documnet／*;*／file／*,其中就是两条规则
     **/
    void set_file_crypt_rules(const char *rules);
    
    /**
     * @功能 设置非加密文件规则,注意rules可以用';'号隔开，设置多条规则，
     *       例如: *／Documnet／*;*／file／*,其中就是两条规则
     **/
    void set_file_exclude_crypt_rules(const char *rules);
    
#ifdef __cplusplus
}
#endif

#endif //_SSLAUTH_H_
