//
//  SecItem.h
//  Auth
//
//  Created by Huang Shounan on 12-11-26.
//
//

#include <openssl/bio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/pkcs12.h>
#include <openssl/err.h>
#include <openssl/x509.h>
#include <openssl/x509v3.h>
#include <openssl/x509v3.h>

/*
 * 以下函数供用户参考，获取X509证书中相关信息
 */

NSDate *CertificateGetExpiryDate(X509 *certificateX509);

NSString * CertificateGetIssuerName(X509 *certificateX509);

NSString *CertificateGetSerial(X509 *certificateX509);
