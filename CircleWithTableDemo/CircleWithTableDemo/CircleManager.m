//
//  CircleManager.m
//  CircleWithTableDemo
//
//  Created by sfwan on 14-12-27.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "CircleManager.h"

@implementation CircleManager{
    NSInteger _lastIndex;
}

static CircleManager *_instance = nil;
+(CircleManager*)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CircleManager alloc] init];
    });
    return _instance;
}

-(NSArray *)rotations{
    NSMutableArray *rotations = [NSMutableArray array];
    for (int i = 0; i < self.data.count; i++) {
        NSNumber *numb = self.data[i];
        CGFloat rate = [numb floatValue];
        CGFloat rotation = rate * M_PI * 2;
        [rotations addObject:[NSNumber numberWithFloat:rotation]];
    }
    return rotations;
}

// 斜率
-(CGFloat)kForRow:(NSInteger)row{
    if (row < 0) {
        return 0;
    }
    CGFloat rotation = [self.rotations[row] floatValue];
    return rotation;
}


#pragma mark - scrollView
-(CGFloat)scrollView:(UIScrollView *)scrollView scrollDownBorder:(CGFloat)y{
    NSInteger row = _data.count-1;
    
    self.isLocation = -1;
    y = kRowHeight + y - scrollView.contentSize.height;
    // 每一个行对应扇形的角度
    CGFloat r = [self kForRow:row];
    
    CGFloat rs = 0;// 已经包含的角度
    for (int i = 0; i < row; i++) {
        CGFloat rr = [self kForRow:i];
        rs += rr;
    }
    // 每个cell滑动的距离
    y = (((NSInteger)y + kRowHeight/2) % (kRowHeight*10));
    // 第一个扇形的角度/2(默认滚过的角度)
    CGFloat dr = [self kForRow:row]/2;
    // 第一个扇形与90度的角度差的一半(没弄懂为什么要这样, 但必须这样做)
    CGFloat mr = (degreesToRadians(90)- dr * 2)/2;
    // 每一个单元格高度对应的角度
    CGFloat ner = y * (r/kRowHeight) - dr - mr;
    //        NSLog(@"ner  %f", radiansToDegrees(ner));
    // 已经滚过的角度
    CGFloat ra = ner + rs;
    //        NSLog(@"ra  %f", radiansToDegrees(ra));
    // 获取第0个扇形
    CDCircleThumb *thumb = _circle.thumbs[0];
    CGFloat deltaAngle= -ra + atan2(thumb.transform.a, thumb.transform.b)/2;
    if (_startDrag) {
        _circle.transform = CGAffineTransformMakeRotation(deltaAngle);
    }
    return deltaAngle;
}

-(CGFloat)scrollView:(UIScrollView *)scrollView scrollUpBorder:(CGFloat)y{
    self.isLocation = 1;
    NSInteger row = 0;
    // 每一个行对应扇形的角度
    CGFloat r = [self kForRow:row];
    
    CGFloat rs = 0;// 已经包含的角度
    for (int i = 0; i < row; i++) {
        CGFloat rr = [self kForRow:i];
        rs += rr;
    }
    // 每个cell滑动的距离
    y = (((NSInteger)y + kRowHeight/2) % (kRowHeight*10));
    // 第一个扇形的角度/2(默认滚过的角度)
    CGFloat dr = [self kForRow:0]/2;
    // 第一个扇形与90度的角度差的一半(没弄懂为什么要这样, 但必须这样做)
    CGFloat mr = (degreesToRadians(90)- dr * 2)/2;
    // 每一个单元格高度对应的角度
    CGFloat ner = y * (r/kRowHeight) - dr - mr;
    // 已经滚过的角度
    CGFloat ra = ner + rs;
    // 获取第0个扇形
    CDCircleThumb *thumb = _circle.thumbs[0];
    CGFloat deltaAngle= -ra + atan2(thumb.transform.a, thumb.transform.b)/2;
    if (_startDrag) {
        _circle.transform = CGAffineTransformMakeRotation(deltaAngle);
    }
    return deltaAngle;
}

-(CGFloat)scrollView:(UIScrollView *)scrollView scrollTo:(CGFloat)y{
    NSInteger row = 0;
    self.isLocation = 0;
    row = (y + (kRowHeight/2))/kRowHeight;
    row = MIN(row, _data.count-1);
    self.currentRow = row;
    
    // 每一个行对应扇形的角度
    CGFloat r = [self kForRow:row];
    
    CGFloat rs = 0;// 已经包含的角度
    for (int i = 0; i < row; i++) {
        CGFloat rr = [self kForRow:i];
        rs += rr;
    }
    // 每个cell滑动的距离
    y = (((NSInteger)y + kRowHeight/2) % kRowHeight);
    // 第一个扇形的角度/2(默认滚过的角度)
    CGFloat dr = [self kForRow:0]/2;
    
    // 第一个扇形与90度的角度差的一半(没弄懂为什么要这样, 但必须这样做)
    CGFloat mr = (degreesToRadians(90)- dr * 2)/2;
    // 每一个单元格高度对应的角度
    CGFloat ner = y * (r/kRowHeight) - dr - mr;
    // 已经滚过的角度
    CGFloat ra = ner + rs;
    //    NSLog(@"ra  %f", radiansToDegrees(ra));
    // 获取第0个扇形
    CDCircleThumb *thumb = _circle.thumbs[0];
    CGFloat deltaAngle= -ra + atan2(thumb.transform.a, thumb.transform.b)/2;
    if (_startDrag) {
        _circle.transform = CGAffineTransformMakeRotation(deltaAngle);
    }
    return deltaAngle;
}

-(void)scrollViewDidEndScroll:(UIScrollView *)scrollView{
    NSInteger isLocation = self.isLocation;
    if (isLocation == 0) {
        CDCircleThumb *thumb = [_circle circleLocationAtTheCurrentThumb];
        CGPoint contentOffset = CGPointMake(0, thumb.tag * kRowHeight);
        [scrollView setContentOffset:contentOffset animated:YES];
    } else if(_isLocation == 1) {
        CDCircleThumb *thumb = _circle.thumbs[0];
        [_circle circleLocationAtIndex:thumb.tag];
        CGPoint contentOffset = CGPointMake(0, thumb.tag * kRowHeight);
        [scrollView setContentOffset:contentOffset animated:YES];
    } else if(_isLocation == -1) {
        CDCircleThumb *thumb = _circle.thumbs[_data.count-1];
        [_circle circleLocationAtIndex:thumb.tag];
        CGPoint contentOffset = CGPointMake(0, thumb.tag * kRowHeight);
        [scrollView setContentOffset:contentOffset animated:YES];
    }
}



#pragma mark - circle

-(void)setScrollView:(UIScrollView *)scrollView scrollToIndex:(CGFloat)index{
    CGPoint contentOffset = CGPointMake(0, index * kRowHeight);
    [scrollView setContentOffset:contentOffset animated:YES];
}

-(CGFloat)scrollView:(UIScrollView *)scrollView scrollWithAngle:(CGFloat)angle{
    NSInteger index = [_circle circleSearchCurrentThumb];
    CGFloat height = 0;// 已经滑过的距离
    
    //    NSLog(@" yy %f", _tableView.contentOffset.y);
    if (_circle.recognizer.director == kTurnDirectorRight && _lastIndex == 0 && index != 0) {
        index = 0;
    }
    
    if (_circle.recognizer.director == kTurnDirectorLeft && index == 0 && _lastIndex != 0) {
        index = _data.count-1;
    }
    
    for (int i = 0; i < index; i++) {
        height += kRowHeight;
    }
    
    CGFloat rs = 0;// 已经包含的角度
    for (int i = 0; i < index; i++) {
        CGFloat rr = [self kForRow:i];
        rs += rr;
    }
    
    if (rs >= [self kForRow:0]) {
        rs -= [self kForRow:0]/2;
    }
    
    if (height >= kRowHeight) {
        height -= kRowHeight/2;
    }
    
    //    NSLog(@" index %ld", index);
    //    NSLog(@"height %f", height);
    CGFloat rotation = [self.rotations[index] floatValue];
    CGFloat hr = kRowHeight / rotation;
    //    NSLog(@"at %f", asin(sin(angle)));
    if (index == 0) {// 超过0点时
        angle = asin(sin(angle));
    }
    
    CGFloat y = hr * (angle-rs) + height;
    //    NSLog(@"rs %f", rs);
    //    NSLog(@"hr %f", hr);
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y =  y;
    //    NSLog(@" y        %f", y);
    scrollView.contentOffset = contentOffset;
    //    NSLog(@"         ");
    _lastIndex = index;
    
    return y;
}

-(BOOL)scrollView:(UIScrollView *)scrollView scrollWithRotation:(CGFloat)rotation{
    CGFloat radius = _circle.radius;
    CDCircleThumb *thumb = _circle.thumbs[0];
    CGPoint centerPoint = thumb.centerPoint;
    CGPoint p = [thumb convertPoint:centerPoint toView:nil];
    
    CGFloat ra = [Common rationWithPoint:p center:_circle.center radius:radius];
    CGFloat y = [self scrollView:scrollView scrollWithAngle:ra];
    // 判断越界
    if (y < -kRowHeight/2) {
        
        return NO;
    }
    // 判断越界
    CGFloat ss = (_data.count) * kRowHeight-kRowHeight/2;
    if (y > ss) {
        return NO;
    }
    
    return YES;
}

@end
