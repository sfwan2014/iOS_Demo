//
//  TaskProcessCell.h
//  TableViewCellTalk
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskProcessCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *data;

+(CGFloat)cellContentHeightFromData:(NSDictionary *)dic;

@end
