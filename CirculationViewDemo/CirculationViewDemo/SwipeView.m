//
//  SwipeView.m
//  SwipeImageViewDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SwipeView.h"
#import "ItemView.h"

#define kItemWidth  self.frame.size.width
#define kTime       1

@interface SwipeView () <UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation SwipeView
{
    UIScrollView *_scrollView;
    NSMutableArray *_imageViews;
    UIPageControl *_pageControl;
    NSInteger timeCount;
    NSTimer *_timer;
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame  items:(NSArray *)items
{
    self = [self initWithFrame:frame];
    if (self) {
        _items = items;
        [self _initViews];
    }
    return self;
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    if (_scrollView == nil) {
        [self _initViews];
    }
    
    [self setNeedsLayout];
}

-(void)_initViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    NSInteger count = _items.count;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width-100)/2.0, self.frame.size.height - 30, 100, 10)];
    _pageControl.numberOfPages = count;
    [self addSubview:_pageControl];
    _imageViews = [[NSMutableArray alloc] initWithCapacity:count];
    
    CGFloat width = kItemWidth;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < count + 2; i++) {
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        [_scrollView addSubview:itemView];
        [_imageViews addObject:itemView];
    }
    
    _scrollView.contentSize = CGSizeMake(width * (count+2), height);
    self.currentPage = 1;
    timeCount = 1;
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTime target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = _items.count;
    for (int i = 0; i < count; i++) {
        ItemView *itemView = _imageViews[i+1];
        Item *item = _items[i];
        itemView.item = item;
    }
    
    ItemView *itemView1 = _imageViews[0];
    ItemView *itemView2 = _imageViews[_imageViews.count - 1];
    Item *item1 = _items[count - 1];
    Item *item2 = _items[0];
    itemView1.item = item1;
    itemView2.item = item2;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage animation:NO];
    timeCount = currentPage;
    if (timeCount == 0) {
        timeCount = 1;
    }
}

-(void)setCurrentPage:(NSInteger)currentPage animation:(BOOL)animation
{
    CGFloat width = kItemWidth;
    CGFloat height = self.frame.size.height;
    NSInteger count = _imageViews.count;
    _currentPage = currentPage;
    if (currentPage == count - 1) {
        CGRect rect= CGRectMake(width * 1, 0, width, height);
        [_scrollView scrollRectToVisible:rect animated:animation];
    } else if (currentPage == 0) {
        CGRect rect= CGRectMake(width * (count-2), 0, width, height);
        [_scrollView scrollRectToVisible:rect animated:animation];
    } else {
        CGRect rect= CGRectMake(width * currentPage, 0, width, height);
        [_scrollView scrollRectToVisible:rect animated:animation];
    }
    
    CGFloat x = _scrollView.contentOffset.x+_scrollView.width/2.0;
    NSInteger page = x/_scrollView.width;
    _pageControl.currentPage = page-1;
    
}

#pragma mark - delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat x = scrollView.contentOffset.x+scrollView.width/2.0;
        NSInteger page = x/scrollView.width;
        self.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x+scrollView.width/2.0;
    NSInteger page = x/scrollView.width;
    self.currentPage = page;
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kTime target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}


-(void)timeAction
{
    if (timeCount == _imageViews.count ) {
        // 5 - 1 过渡
        timeCount = 2;
    }
    
    if (timeCount == 1) {
        timeCount = _imageViews.count - 2;
        return;
    }
    if (_scrollView.contentOffset.x/kItemWidth == 1) {
        timeCount = 2;
        [self setCurrentPage:1 animation:NO];
    }
    [self scrollToPage:timeCount];
    timeCount ++;
}

-(void)scrollToPage:(NSInteger)page
{
    CGPoint contentOffset = _scrollView.contentOffset;
    contentOffset.x = page * 320;
    
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = contentOffset;
    } completion:^(BOOL finished) {
        if (page == _imageViews.count - 1) {
            [self setCurrentPage:page animation:NO];
        }
        CGFloat x = _scrollView.contentOffset.x+_scrollView.width/2.0;
        NSInteger page = x/_scrollView.width;
        _pageControl.currentPage = page-1;
    }];
}

@end
