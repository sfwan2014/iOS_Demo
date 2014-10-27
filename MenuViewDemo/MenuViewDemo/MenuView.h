//
//  MenuView.h
//  FinancialManage
//
//  Created by sfwan on 14-8-7.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kItemHeight     45
typedef enum : NSUInteger {
    kArrowDirectionUp = 1,
    kArrowDirectionDown,
    kArrowDirectionNone,
} kArrowDirection;

@class MenuView;
typedef void (^ClickBlock)(MenuView *view, NSString *title);

@interface MenuView : UIControl
@property (nonatomic, assign) NSInteger selectIndex;
- (id)initWithFrame:(CGRect)frame menuTitles:(NSArray *)titles arrowDirector:(kArrowDirection)direction clickBlock:(ClickBlock)block;

+(MenuView *)showInView:(UIView *)view frame:(CGRect)frame withTitles:(NSArray *)titles arrowDirector:(kArrowDirection)direction clickBlock:(ClickBlock)block;
+(void)hideMenuViewInView:(UIView *)view;
@end
