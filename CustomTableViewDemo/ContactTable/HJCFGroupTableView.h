//
//  MyTableView.h
//  CustomTableViewDemo
//
//  Created by sfwan on 14-7-22.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRowHeight      44

@interface HJCFGroupTableView : UITableView
/*
 * {"1000":[{"title":"重要客户", "list":["123"]}, {"title":"重要客户", "list":[]}], "500":[{"title":"重要客户", "list":[]}, {"title":"重要客户", "list":[]}]}
 */
@property (nonatomic, strong) NSDictionary *data;

@end
