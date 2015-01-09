//
//  MDMenuView.m
//  MDMenuViewDemo
//
//  Created by sfwan on 14-12-24.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "MDMenuView.h"
#import "MDItemView.h"
#import "MDMenuOverlayer.h"

#define kItemWidth          40

@interface MDMenuView ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *titles;
//@property (nonatomic, strong) UIBezierPath *path;
//@property (nonatomic, strong) UIColor *fillColor;


@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;
@end

@implementation MDMenuView
{
    UIEdgeInsets edge;
    MDMenuOverlayer *baseView;
    BOOL open;
}

-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        edge = UIEdgeInsetsMake(10, 0, 0, 0);// 保留
        
        _centerPoint = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        self.radius = frame.size.height/2;
        self.titles = titles;
        open = YES;
        baseView = [[MDMenuOverlayer alloc] initWithFrame:self.bounds];
//        baseView.center = CGPointMake(_centerPoint.x, _centerPoint.y-kItemWidth-20);
        [self addSubview:baseView];
        
        [self createItems];
    }
    return self;
}
-(void)createItems{

    _items = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        MDItemView *item = [[MDItemView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth) title:self.titles[i] normalColor:[UIColor whiteColor] selectedColor:[UIColor purpleColor]];
        item.tag = i;
        [baseView addSubview:item];
        [self.items addObject:item];
    }
    
    MDItemView *item = [[MDItemView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth) title:nil normalColor:[UIColor whiteColor] selectedColor:[UIColor purpleColor]];
    item.tag = self.titles.count;
    [self addSubview:item];
    [self.items addObject:item];
    
    for (MDItemView *item in self.items) {
        [item addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchDragInside];
    }
}

-(void)selectAction:(MDItemView *)item{
    [UIView animateWithDuration:0.4 animations:^{
        if (open) {
            baseView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } else {
            baseView.transform = CGAffineTransformIdentity;
        }
//        baseView.transform = CGAffineTransformRotate(baseView.transform, M_PI);
    }];
    open = !open;
    if (item.tag == self.items.count-1) {
        
        return;
    }
    
    for (int i = 0; i < self.items.count-1; i++) {
        MDItemView *it = self.items[i];
        it.selected = NO;
    }
    
    item.selected = YES;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < self.items.count-1; i++) {
        CGFloat r = M_PI/(self.items.count);
        CGFloat x = _centerPoint.x - (self.radius - kItemWidth/2-edge.top) * cos((i+1) * r);
        CGFloat y = _centerPoint.y - (self.radius - kItemWidth/2-edge.top) * sin((i+1) * r);
    
        MDItemView *item = self.items[i];
        CGPoint p = CGPointMake(x, y);
        item.center = p;
    }
    
    MDItemView *item = [self.items lastObject];
    CGPoint p = CGPointMake(_centerPoint.x, _centerPoint.y-kItemWidth-20);
    item.center = p;
}

@end
