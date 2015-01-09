//
//  MDCircleTableView.m
//  CircleWithTableDemo
//
//  Created by sfwan on 14-12-27.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDCircleTableView.h"
#import "AccountTableViewCell.h"
#import "CircleManager.h"
@interface MDCircleTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MDCircleTableView
{
    BOOL _startDrag;
    NSInteger _isLocation;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews{
    self.dataSource = self;
    self.delegate = self;
    
    [self registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.rowHeight = kRowHeight;
    self.contentInset = UIEdgeInsetsMake(0, 0, 400, 0);
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initViews];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.data = self.data[indexPath.row];
    return cell;
}

#pragma makr- UITableViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [CircleManager shareManager].startDrag = YES;
    [CircleManager shareManager].isLocation = 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f   %f", y, scrollView.contentSize.height);
    if (kRowHeight/2.0 + y - scrollView.contentSize.height >= 0) {// 划过下界
        [[CircleManager shareManager] scrollView:scrollView scrollDownBorder:y];
        return;
    }
    
    if (y <= 0) { // 画过上边界
        [[CircleManager shareManager] scrollView:scrollView scrollUpBorder:y];
        return;
    }
    
    [[CircleManager shareManager] scrollView:scrollView scrollTo:y];
}

//-(void)point

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [CircleManager shareManager].startDrag = NO;
//    [[CircleManager shareManager] scrollViewDidEndScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger row = [CircleManager shareManager].currentRow;
    CGPoint p = CGPointMake(0, row * kRowHeight);
    [scrollView setContentOffset:p animated:YES];
//    [CircleManager shareManager].startDrag = NO;
//    [[CircleManager shareManager] scrollViewDidEndScroll:scrollView];
}

@end
