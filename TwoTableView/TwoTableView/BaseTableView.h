//
//  BaseTableView.h
//  TwoTableView
//
//  Created by shaofa on 14-1-7.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableView;
@protocol BaseTableViewSelectedDelegate <NSObject>

@optional
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(BaseTableView *)tableView;

@end

@interface BaseTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *data;

@property(nonatomic,assign) id<BaseTableViewSelectedDelegate>selectedDelegate;

@end
