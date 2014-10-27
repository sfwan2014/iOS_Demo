//
//  SFBaseModel.h
//  NSKeyedArchiverDemo
//
//  Created by shaofa on 14-3-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFBaseModel : NSObject<NSCoding>

-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串

@end
