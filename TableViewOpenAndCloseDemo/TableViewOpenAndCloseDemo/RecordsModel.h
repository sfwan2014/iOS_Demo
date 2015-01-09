//
//  RecordsModel.h
//  安心贷
//
//  Created by sfwan on 14-12-11.
//  Copyright (c) 2014年 xing.peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordsModel : NSObject
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *confirmtime;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *realamount;

@property (nonatomic) BOOL isExpand;

@end
