//
//  ViewController.m
//  ArcDemo
//
//  Created by sfwan on 14-12-21.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "CDCircleThumb.h"
#import "CDCircle.h"
#import "CDCircleOverlayView.h"
#import "MDJCTableView.h"
#import "CDCircleGestureRecognizer.h"

@interface ViewController ()<CDCircleDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CDCircle *circle;
@end

@implementation ViewController
{
    UITableView *_tableView;
    BOOL _startDrag;
    NSArray *_data;
    CGFloat _lastRotation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = @[@0.25,@0.13,@0.17,@0.15,@0.1,@0.15,@0.05];
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor],[UIColor purpleColor], [UIColor redColor], [UIColor purpleColor]];

    _circle = [[CDCircle alloc] initWithFrame:CGRectMake(100, 100, 200, 200) Data:_data fillColors:colors ringWidth:30];
    _circle.delegate = self;
    
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:_circle];
    [self.view addSubview:_circle];
    [self.view addSubview:overlay];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, 375, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 300-40, 0);
    [self.view addSubview:_tableView];
    
    _startDrag = NO;
}

-(void) circle: (CDCircle *) circle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb{
    CGFloat radius = circle.frame.size.width/2;
    CDCircleThumb *th = circle.thumbs[0];
    CGPoint centerPoint = thumb.centerPoint;
    CGPoint p = [th convertPoint:centerPoint toView:nil];
    
    CGFloat ra = [Common rationWithPoint:p center:circle.center radius:radius];
    [self tableScrollToRation:ra];
}

-(BOOL) circle: (CDCircle *)circle Move:(CGFloat) ration{
    CGFloat radius = circle.radius;
    CDCircleThumb *thumb = circle.thumbs[0];
    CGPoint centerPoint = thumb.centerPoint;
    CGPoint p = [thumb convertPoint:centerPoint toView:nil];
    
    CGFloat ra = [Common rationWithPoint:p center:circle.center radius:radius];
    [self tableScrollToRation:ra];
    
    return YES;
}

-(void)tableScrollToRation:(CGFloat)ration{
    CGFloat totalH = _tableView.contentSize.height;
    CGFloat rate = ration/(M_PI * 2);
    CGPoint contentOffset = _tableView.contentOffset;
    contentOffset.y = totalH * rate;
    
    _tableView.contentOffset = contentOffset;
    
}

//-(CGFloat)rationWithPoint:(CGPoint)p2 center:(CGPoint)center radius:(CGFloat)raidus{
//    
//    CGFloat rat = 0;
//    CGFloat dx = ABS(p2.x - center.x);
//    if (p2.y >= center.y && p2.x > center.x) {
//        rat = asinf(dx/raidus);
//    } else if (p2.y < center.y && p2.x > center.x) {
//        rat = M_PI - asinf(dx/raidus);
//    } else if (p2.y < center.y && p2.x <= center.x) {
//        rat = M_PI + asinf(dx/raidus);
//    } else {
//        rat = 2* M_PI - asinf(dx/raidus);
//    }
//    
//    return rat;
//}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%.2f", [_data[indexPath.row] floatValue]];
    return cell;
}

#pragma makr- UITableViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startDrag = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = -scrollView.contentOffset.y;
    
    CGFloat rate = y/scrollView.contentSize.height;
    CGFloat ration = rate * M_PI * 2;
    CDCircleThumb *thumb = _circle.thumbs[0];
    CGFloat deltaAngle= ration + atan2(thumb.transform.a, thumb.transform.b)/2;
    if (_startDrag) {
        _circle.transform = CGAffineTransformMakeRotation( deltaAngle);
    }
    
//    NSLog(@"%f", y);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CDCircleThumb *thumb = _circle.recognizer.currentThumb;
    CGFloat deltaAngle= degreesToRadians(-thumb.angle/2) + atan2(thumb.transform.a, thumb.transform.b);
//    _circle.transform = CGAffineTransformMakeRotation( deltaAngle);
    _startDrag = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
