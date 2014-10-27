//
//  LeafTableView.m
//  LeafTableViewDemo
//
//  Created by sfwan on 14-7-23.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "LeafTableView.h"
#import "TopScrollView.h"

#define kTOP_BG_HIDE        180
#define kTranslationRate    0.4

@interface LeafTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TopScrollView *topBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *topView;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation LeafTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews];
}

-(void)_initViews
{
    
    _topBgView = [[TopScrollView alloc] initWithFrame:CGRectMake(0, -kTOP_BG_HIDE, self.frame.size.width, self.frame.size.height - kTOP_BG_HIDE)];
    [self addSubview:_topBgView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(kTOP_BG_HIDE, 0, 0, 0);
    [self addSubview:_tableView];
    
    _topView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kTOP_BG_HIDE)];
    _topView.contentSize = CGSizeMake(3*_topView.frame.size.width, _topView.frame.size.height);
    _topView.pagingEnabled = YES;
    _topView.delegate = self;
    
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:_topView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"呵呵" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake( 10, 30, 70, 45);
    [_topView addSubview:button];
}

-(void)buttonAction
{
    NSString *msg = @"呵呵,点到了哦";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = @"abcdefg";
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f", y);
    if (scrollView == _tableView) {
        _topBgView.frame = CGRectMake(0, -kTOP_BG_HIDE - (y * kTranslationRate) , self.frame.size.width, self.frame.size.height - kTOP_BG_HIDE);
        _topView.frame = CGRectMake(0, -kTOP_BG_HIDE-y, self.frame.size.width, kTOP_BG_HIDE);
    }

    if (scrollView == _topView) {
        CGFloat yy = _topBgView.contentOffset.y;
        CGFloat xx = scrollView.contentOffset.x;
        CGPoint point = CGPointMake(xx, yy);
        [_topBgView scrollToContentOffSet:point];
        
//        CGPoint contentOffset = _tableView.contentOffset;
//        contentOffset.y =  -kTOP_BG_HIDE - scrollView.contentOffset.y;
//        _tableView.contentOffset = contentOffset;
    }
}

-(void)scrollToPage
{
    CGPoint position = _topView.contentOffset;
    position.x = _currentPage * self.frame.size.width;
    CGRect rect = CGRectMake(position.x, 0, self.frame.size.width, self.frame.size.height);
    [_topView scrollRectToVisible:rect animated:YES];
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self scrollToPage];
}

#pragma mark - delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && scrollView == _topView) {
        CGFloat x = scrollView.contentOffset.x+scrollView.frame.size.width/2.0;
        //    NSLog(@"%f", x);
        NSInteger page = x/scrollView.frame.size.width;
        self.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _topView) {
        CGFloat x = scrollView.contentOffset.x+scrollView.frame.size.width/2.0;
        //    NSLog(@"%f", x);
        NSInteger page = x/scrollView.frame.size.width;
        self.currentPage = page;
    }
}

@end
