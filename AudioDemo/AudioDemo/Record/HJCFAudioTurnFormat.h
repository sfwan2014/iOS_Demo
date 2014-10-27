//
//  HJCFAudioTurnFormat.h
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCFAudioTurnFormat : NSObject

+ (BOOL)amrToWav:(NSString*)_amrPath wavSavePath:(NSString*)_savePath;

+ (BOOL)wavToAmr:(NSString*)_wavPath amrSavePath:(NSString*)_savePath;

@end
