//
//  TopScrollView.h
//  LeafTableViewDemo
//
//  Created by sfwan on 14-7-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentPage;
-(void)scrollToContentOffSet:(CGPoint)point;
@end
