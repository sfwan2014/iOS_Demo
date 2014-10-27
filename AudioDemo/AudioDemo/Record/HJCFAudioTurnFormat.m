//
//  HJCFAudioTurnFormat.m
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFAudioTurnFormat.h"
#import "wav.h"
#import "interf_dec.h"
#import "dec_if.h"
#import "interf_enc.h"
#import "amrFileCodec.h"

@implementation HJCFAudioTurnFormat

+ (BOOL)amrToWav:(NSString*)_amrPath wavSavePath:(NSString*)_savePath{
    
    if (! DecodeAMRFileToWAVEFile([_amrPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding]))
        return NO;
    return YES;
}

+ (BOOL)wavToAmr:(NSString*)_wavPath amrSavePath:(NSString*)_savePath{
    
    if (EncodeWAVEFileToAMRFile([_wavPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16))
        return YES;
    
    return NO;
}

@end
