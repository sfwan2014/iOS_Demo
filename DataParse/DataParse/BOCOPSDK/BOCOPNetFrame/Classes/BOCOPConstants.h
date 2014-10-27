//
//  BOCOPConstants_h
//


#ifndef BOCOPConstants_h
#define BOCOPConstants_h

#define BOCOPSDKVersion                @"0.1"
#define kBOCOPRequestTimeOutInterval   40.0

#define kBOCOPSDKErrorDomain           @"kBOCOPSDKErrorDomain"
#define kBOCOPSDKErrorCodeKey          @"kBOCOPSDKErrorCodeKey"
#define BOCOP_URL                      @"http://22.188.21.23:9084/"


typedef enum
{
	BOCOPSDKErrorCodeAuthFailed = 1,
	BOCOPSDKErrorCodeAuthRefreshFailed,
	BOCOPSDKErrorCodeServerError,
	BOCOPSDKErrorCodeOtherError,
} BOCOPSDKErrorCode;

//分行
#define BOCOP_UNLOGIN_MCISCSP [NSString stringWithFormat:@"%@%@",BOCOP_URL,@"bocop/unlogin/mciscsp"]
#define BOCOP_LOGIN_MCISCSP   [NSString stringWithFormat:@"%@%@",BOCOP_URL,@"bocop/mciscsp"]

//总行
#define BOCOP_UNLOGIN_MCIS    [NSString stringWithFormat:@"%@%@",BOCOP_URL,@"bocop/unlogin/mcis"]
#define BOCOP_LOGIN_MCIS      [NSString stringWithFormat:@"%@%@",BOCOP_URL,@"bocop/mcis"]



#endif
