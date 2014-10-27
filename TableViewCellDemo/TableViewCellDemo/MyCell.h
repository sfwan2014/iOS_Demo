//
//  MyCell.h
//  TableViewCellDemo
//
//  Created by shaofa on 14-6-9.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCell;
@protocol MyCellDelegate <NSObject>

-(void)MyCellDeleteItem:(MyCell *)cell item:(id)item;
-(void)MyCellAddItem:(MyCell *)cell item:(id)item;

@end

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *txtLabel;

@property (nonatomic, copy)NSString *text;
@property (nonatomic, assign)id<MyCellDelegate>delegate;
@property (nonatomic, assign) BOOL isFirst;

@end
