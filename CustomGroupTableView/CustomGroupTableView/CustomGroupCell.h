//
//  CustomGroupCell.h
//  CustomGroupTableView
//
//  Created by sfwan on 14-10-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kCellStyleA = 0,
    kCellStyleB,
    kCellStyleC,
    kCellStyleD,
    kCellStyleE,
} kCellStyle;

@interface CustomGroupCell : UITableViewCell

@property (nonatomic, assign) kCellStyle style;

@end
