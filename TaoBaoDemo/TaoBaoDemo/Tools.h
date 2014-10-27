//
//  Tools.h
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock) (id result, NSString *error);

@interface Tools : NSObject

+(NSString *) md5: (NSString *) inPutText;

+(NSString *)sortParams:(NSMutableDictionary *)params;

@end
