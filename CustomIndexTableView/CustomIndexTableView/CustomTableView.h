//
//  CustomTableView.h
//  CustomIndexTableView
//
//  Created by sfwan on 14-12-31.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UITableView
@property (nonatomic, strong)NSDictionary *data;
-(void)scrollToTheSection:(NSInteger)section;
@end
