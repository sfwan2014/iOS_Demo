//
//  MyCell.h
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubTableView.h"

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSArray *data;

@end
