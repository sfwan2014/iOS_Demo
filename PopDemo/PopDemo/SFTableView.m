//
//  SFTableView.m
//  PopDemo
//
//  Created by shaofa on 14-3-31.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SFTableView.h"

@implementation SFTableView
{
    BOOL isBounce;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipe];
}

-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row = %d", indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height;
    
    if (scrollView.contentSize.height < scrollView.frame.size.height) {
        y = scrollView.contentOffset.y + 64;
    }
    
//    NSLog(@"1---  %f", scrollView.contentSize.height);
//    NSLog(@"2---  %f", scrollView.contentOffset.y);
//    NSLog(@"3---  %f", scrollView.frame.size.height);
    
    if (y >= 0) {
        isBounce = YES;
    } else {
        isBounce = NO;
    }
    
    NSLog(@"%f", y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollView.bounces = !isBounce;
    if (isBounce) {
        [self touchesShouldCancelInContentView:self];
    }
}

@end
