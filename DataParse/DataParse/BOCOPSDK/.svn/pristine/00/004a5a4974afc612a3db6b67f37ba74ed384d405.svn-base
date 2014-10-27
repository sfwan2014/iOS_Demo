//
//  CONSTS.h
//  Hupan
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//

#define GENERATE_DUMMPY_DATA 1
#define TEST                 1
#define USER_TEST_LOCATION   1

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define REQUEST_DOMAIN              @"http://mjk1.okhigh.com"// default env
#define SECRET_KEY                  @"mjk"

//text
#define TEXT_LOAD_MORE_NORMAL_STATE @"向上拉动加载更多..."
#define TEXT_LOAD_MORE_LOADING_STATE @"更多数据加载中..."
#define IMG_PUBLIC_PageCount_SmallNormal    @"page_normal.png"
#define IMG_PUBLIC_PageCount_SmallHighlight @"page_hight.png"
#define ERRORMESAGE @"网络异常，请稍后再试！"
//other consts
typedef enum{
	kTagWindowIndicatorView = 501,
	kTagWindowIndicator,
} WindowSubViewTag;

typedef enum{
    kTagHintView = 101
} HintViewTag;

typedef enum {
    CellPositionTypeUnknown,
    CellPositionTypeTop,
    CellPositionTypeMiddle,
    CellPositionTypeBottom,
    CellPositionTypeSingle,
}CellPositionType;

#define USER_DEFAULT                        [NSUserDefaults standardUserDefaults]
#define MSDATA_ENV                          [MSDataEnvironment sharedDataEnvironment]
#define DATA_CATHE                          [DataCacheManager sharedManager]

// Release methods
#define RELEASE_SAFELY(__POINTER)           { [__POINTER release]; __POINTER = nil; }
#define AUTORELEASE_SAFELY(__POINTER)       { [__POINTER autorelease]; __POINTER = nil; }

// Color helpers
#define RGBCOLOR(r,g,b)                     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBCOLOR_ALPHA(r,g,b,a)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

//AppDelegate
#define APP_DELEGATE                        (AppDelegate *)[UIApplication sharedApplication].delegate

#define IMGNAMEED(_imgName) [_imgName length]>0?[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_imgName ofType:nil]]:[UIImage imageNamed:@""]
//NSNotification
#define APPDataKey  @"applicationlist"
#define APPCategory @"category"
#define MYFAVOURITE @"myfavouriteList"
#define CRUSHMESSAGE @"crushMessageList"
#define USER_MESSAGE @"user_message"
#define USER_EXPERIENCE @"userExperience"
#define NSNOTIFICATION_MORE   @"NSNOTIFICATION_MORE"   


