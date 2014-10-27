//
//  MemorandumTableView.h
//  MemorandumDemo
//
//  Created by sfwan on 14-8-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemorandumTableView;
@protocol MemorandumTableViewDataSource <NSObject>
@required
- (NSInteger)tableView:(MemorandumTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(MemorandumTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInTableView:(MemorandumTableView *)tableView;

- (NSString *)tableView:(MemorandumTableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)tableView:(MemorandumTableView *)tableView titleForFooterInSection:(NSInteger)section;

@end

@protocol MemorandumTableViewDelegate <UIScrollViewDelegate>
- (CGFloat) tableViewRowHeightInTableView:(MemorandumTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface MemorandumTableView : UIScrollView

@property (nonatomic, assign) id<MemorandumTableViewDataSource>dataSource;
@property (nonatomic, assign) id<MemorandumTableViewDelegate>delegate;
@end
