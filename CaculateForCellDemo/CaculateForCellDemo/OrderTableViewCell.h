//
//  OrderTableViewCell.h
//  CaculateForCellDemo
//
//  Created by sfwan on 14-10-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishOperate) (NSArray *result,BOOL isRefresh);

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger originalCount;

@property (nonatomic, copy) FinishOperate block;
@end
