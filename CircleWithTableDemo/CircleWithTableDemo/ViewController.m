//
//  ViewController.m
//  CircleWithTableDemo
//
//  Created by sfwan on 14-12-27.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "MDCircleTableView.h"
#import "CDCircleOverlayView.h"
#import "CDCircle.h"
#import "CDCircleGestureRecognizer.h"
#import "CDCircleThumb.h"
#import "CircleManager.h"

@interface ViewController ()<CDCircleDelegate>
@property (weak, nonatomic) IBOutlet MDCircleTableView *tableView;
@property (nonatomic, strong) CDCircle *circle;
@end

@implementation ViewController
{
    BOOL _startDrag;
    NSArray *_data;
    CGFloat _lastRotation;
    
    NSMutableArray *rotations;
    
    NSInteger _isLocation;
    
    CGFloat _lastY;
    NSInteger _lastIndex;
    NSMutableArray *colors;
    NSMutableArray *_tableData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self loadCircle];
    
    [CircleManager shareManager].circle = _circle;
    [CircleManager shareManager].data = _data;
}

-(void)loadCircle{
    _circle = [[CDCircle alloc] initWithFrame:CGRectMake((375-200)/2,20 , 200, 200) Data:_data fillColors:colors ringWidth:30];
    _circle.delegate = self;
    _circle.circleColor = [UIColor clearColor];
    
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:_circle];
    [self.view addSubview:_circle];
    [self.view addSubview:overlay];
}

-(void)createData{
    _tableData = [NSMutableArray array];
    //    _data = @[@0.4,@0.3,@0.2,@0.1];
    _data = @[@0.4,@0.3,@0.2,@0.05,@0.05];
    //    _data = @[@0.4, @0.3,@0.3];
    //    _data = @[@0.2,@0.17,@0.03,@0.2,@0.2];
    _isLocation = 0;
    rotations = [NSMutableArray arrayWithCapacity:_data.count];
    for (NSNumber *numb in _data) {
        CGFloat rate = [numb floatValue];
        CGFloat rotation = rate * M_PI * 2;
        [rotations addObject:[NSNumber numberWithFloat:rotation]];
    }
    
    colors = [NSMutableArray array];
    for (int i = 0; i < _data.count; i++) {
        int r = 255;
        int g = rand()%255;
        int b = rand()%255;
        
        
        UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        [colors addObject:color];
        
        NSDictionary *dic = @{@"productName":@"五粮液",@"totalAmount":@"34218",@"percent":_data[i], @"income":@"1234",@"color":color};
        [_tableData addObject:dic];
    }
    _tableView.data = _tableData;
}


#pragma mark - CDCircleDelegate
-(void) circle: (CDCircle *) circle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb{
    [[CircleManager shareManager] setScrollView:_tableView scrollToIndex:segment];
}

-(BOOL) circle: (CDCircle *)circle Move:(CGFloat) ration{
    return [[CircleManager shareManager] scrollView:_tableView scrollWithRotation:ration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
