//
//  MenuView.m
//  FinancialManage
//
//  Created by sfwan on 14-8-7.
//  Copyright (c) 2014年 华金财富. All rights reserved.
//

#import "MenuView.h"
#import "UIViewExt.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kSpaceWidth     5
#define kItemWidth      60
#define kTriangelHeight 10
#define kTriangelLong  15
#define kCornerRadius   5
#define kLineWidth      1

#define kSelectedColor      rgb(100, 100, 100, 0.6)
#define kDefaultColor       rgb(0, 0, 0, 0.9)

BOOL CGPointNearEqual(CGPoint p1, CGPoint p2);
BOOL CGPointNearEqual(CGPoint p1, CGPoint p2){
    
    CGFloat x1 = p1.x;
    CGFloat y1 = p1.y;
    CGFloat x2 = p2.x;
    CGFloat y2 = p2.y;
    
    CGFloat __xx = ABS(x1-x2);
    CGFloat __yy = ABS(y1-y2);
    
    if (__xx < 10 && __yy < 10) {
        return YES;
    }
    
    return NO;
}
@interface MenuView ()<UIGestureRecognizerDelegate>

@end

@implementation MenuView
{
    NSArray *_titles;
    ClickBlock _block;
    kArrowDirection _direction;
    UITapGestureRecognizer *_tap;
    CGPoint _startPosition;
}

- (id)initWithFrame:(CGRect)frame menuTitles:(NSArray *)titles arrowDirector:(kArrowDirection)direction clickBlock:(ClickBlock)block;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titles = titles;
        _block = block;
        _direction = direction;
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    
    self.backgroundColor = rgb(1, 1, 1, 0.5);
    _selectIndex = -1;
    
    CGFloat width = kItemWidth;
    CGFloat height = kItemHeight;
    
    CGFloat top = 5;
    if (_direction == kArrowDirectionUp) {
        top = kTriangelHeight + 5;
    }
    
    for (int i = 0; i < _titles.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(kLineWidth+width), top, width, height-kTriangelHeight - 10)];
        label.textColor = [UIColor lightTextColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.text = _titles[i];
        [self addSubview:label];
    }
    
    self.width = _titles.count *kItemWidth + (_titles.count-1) * kLineWidth;
    self.height = kItemHeight;
    self.left = (kScreenWidth - self.width)/2.0;
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.frame.size.width/_titles.count;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger index = point.x/width;
    if (touch.view == self) {
        _startPosition = point;
        self.selectIndex = index;
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat width = self.frame.size.width/_titles.count;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    // 点偏差不超过10个像素点
    if (!CGPointNearEqual(_startPosition, point)) {
        self.selectIndex = -1;
        return;
    }
    
    if (touch.view == self) {
        NSInteger index = point.x/width;
        self.selectIndex = index;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        [self sendAction:@selector(buttonAction:) to:self forEvent:event];
    }
}

-(void)buttonAction:(MenuView *)menu
{
    NSLog(@"%d", _selectIndex);
    if (_block) {
        _block(self, _titles[_selectIndex]);
    }
}

+(MenuView *)showInView:(UIView *)view frame:(CGRect)frame withTitles:(NSArray *)titles arrowDirector:(kArrowDirection)direction clickBlock:(ClickBlock)block
{
    [self hideMenuViewInView:view.superview];
    MenuView *menuView = [[MenuView alloc] initWithFrame:frame menuTitles:titles arrowDirector:direction clickBlock:block];
    menuView.backgroundColor = [UIColor clearColor];
    [view addSubview:menuView];
    
    menuView->_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    menuView->_tap.delegate = self;
    [view addGestureRecognizer:menuView->_tap];
    
    return menuView;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

+(void)hideMenuViewInView:(UIView *)view
{
    NSArray *subViews = view.subviews;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[MenuView class]]) {
            [subView removeFromSuperview];
            [view removeGestureRecognizer:((MenuView *)subView)->_tap];
            if (((MenuView *)subView)->_block) {
                ((MenuView *)subView)->_block(((MenuView *)subView), nil);
            }
        }
    }
}

+(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self hideMenuViewInView:tap.view];
}

#pragma mark - Draw
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 如果count == 0 没考虑
    if (_direction == kArrowDirectionUp) {
        [self drawUpView:rect];
    } else {
        [self drawDownView:rect];
    }
}

-(void)drawUpView:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, rgb(1, 1, 1, 1).CGColor);
    CGContextSetFillColorWithColor(contextRef, rgb(0, 0, 0, 1).CGColor);
    
    // up
    CGFloat radius = kCornerRadius;
    NSInteger count = _titles.count;
    CGFloat height = rect.size.height;
    CGFloat leftMedium = rect.size.width/2.0 - kTriangelLong/2.0;
    CGFloat medium = rect.size.width/2.0;
    CGFloat rightMedium = rect.size.width/2.0 + kTriangelLong/2.0;
    
    BOOL oddNumber = count%2 == 1?YES:NO;
    NSMutableArray *arrowIndex = [NSMutableArray array];
    if (oddNumber) {
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2]];
    } else {
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2 - 1]];
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2]];
    }
//    NSInteger containArrowNum[2] =
    for (int i = 0; i < count; i++) {
        
        if (_selectIndex == i) {
            CGContextSetFillColorWithColor(contextRef, kSelectedColor.CGColor);
        } else {
            CGContextSetFillColorWithColor(contextRef, kDefaultColor.CGColor);
        }
        
        if (i < count - 1) {
            
            if (oddNumber) {
                // 1
                CGContextMoveToPoint(contextRef, rect.origin.x + i * kItemWidth, rect.origin.y+kTriangelHeight);
                if (i == [[arrowIndex lastObject] integerValue]) {
                    // 2-1
                    CGContextAddLineToPoint(contextRef, kLineWidth*i + rect.origin.x + i * kItemWidth + kItemWidth/2.0-kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
                    // 2-2
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0, rect.origin.y);
                    // 2-3
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 + kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
                    // 2-4
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kTriangelHeight);
                } else {
                    // 2
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth , rect.origin.y + kTriangelHeight);
                }
            }else {
                if (i == [[arrowIndex firstObject] integerValue]) {
                    // 1
                    CGContextMoveToPoint(contextRef, rect.origin.x + i * kItemWidth, rect.origin.y+kTriangelHeight);
                    // 2 - 1
                    CGContextAddLineToPoint(contextRef, leftMedium, rect.origin.y + kTriangelHeight);
                    // 2 - 2
                    CGContextAddLineToPoint(contextRef, medium - kLineWidth/2.0, rect.origin.y);
                } else if (i == [[arrowIndex lastObject] integerValue]){
                    // 1
                    CGContextMoveToPoint(contextRef, medium + kLineWidth/2.0, rect.origin.y);
                    // 2 - 1
                    CGContextAddLineToPoint(contextRef, rightMedium, rect.origin.y+kTriangelHeight);
                    // 2 - 2
                    CGContextAddLineToPoint(contextRef, kLineWidth * i + rect.origin.x + (i + 1)* kItemWidth , rect.origin.y + kTriangelHeight);
                } else {
                    // 1
                    CGContextMoveToPoint(contextRef, rect.origin.x + i * kItemWidth, rect.origin.y+kTriangelHeight);
                    // 2
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth , rect.origin.y + kTriangelHeight);
                }
            }
            /*
            // 箭头
            if (i == 1){
                // 2-1
                CGContextAddLineToPoint(contextRef, kLineWidth*i + rect.origin.x + i * kItemWidth + kItemWidth/2.0-kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
                // 2-2
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0, rect.origin.y);
                // 2-3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 + kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
                // 2-4
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kTriangelHeight);
                
            } else {
                // 2
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth , rect.origin.y + kTriangelHeight);
            }
             */
            // 3
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + height);
            
        } else {
            // 2
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y + kTriangelHeight);
            // 圆弧
            //圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y + kTriangelHeight + radius, radius, -0.5 * M_PI, 0.0, 0);
            // 3
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + height - radius);
            // 圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
        }
        
        if (i == 0) {
            // 4
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + radius + i* kItemWidth, rect.origin.y + height);
            // 圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + radius + i * kItemWidth, height - radius, radius, 0.5 * M_PI, M_PI, 0);
            // 5
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+kTriangelHeight+radius);
            // 圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + radius, rect.origin.y + kTriangelHeight+radius, radius, M_PI, 1.5 * M_PI, 0);
        } else {
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + height);
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+kTriangelHeight);
            
        }
        CGContextFillPath(contextRef);
    }
    
    
    
    
    /*
    CGContextMoveToPoint(contextRef, rect.origin.x, rect.origin.y+kTriangelHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2.0 - kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2.0, rect.origin.y);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2+kTriangelLong/2.0, rect.origin.y + kTriangelHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width-radius, rect.origin.y + kTriangelHeight);
    //圆弧
    CGContextAddArc(contextRef, rect.size.width - radius, rect.origin.y + kTriangelHeight+radius, radius, -0.5 * M_PI, 0.0, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width, rect.origin.y + kItemHeight);
    //圆弧
    CGContextAddArc(contextRef, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x, rect.origin.y + kItemHeight);
    //圆弧
    CGContextAddArc(contextRef, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x, rect.origin.y+kTriangelHeight);
    //圆弧
    CGContextAddArc(contextRef, radius, rect.origin.y + kTriangelHeight+radius, radius, M_PI, 1.5 * M_PI, 0);
    
    CGContextFillPath(contextRef);
    */
//    CGContextSaveGState(contextRef);
//    CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
//    CGContextSetLineWidth(contextRef, 1);
//    // 画分割线
//    for (int i = 0; i < _titles.count-1; i++) {
//        CGContextMoveToPoint(contextRef, (i+1)*(kItemWidth - 1), rect.origin.y + kTriangelHeight+5);
//        CGContextAddLineToPoint(contextRef, (i+1)*(kItemWidth - 1), rect.origin.y + kItemHeight-5);
//        CGContextStrokePath(contextRef);
//    }
    
//    CGContextRestoreGState(contextRef);
}

-(void)drawDownView:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, rgb(1, 1, 1, 0.5).CGColor);
    CGContextSetFillColorWithColor(contextRef, rgb(0, 0, 0, 0.5).CGColor);
    
    // up
    CGFloat radius = kCornerRadius;
    NSInteger count = _titles.count;
    CGFloat leftMedium = rect.size.width/2.0 - kTriangelLong/2.0;
    CGFloat medium = rect.size.width/2.0;
    CGFloat rightMedium = rect.size.width/2.0 + kTriangelLong/2.0;
    
    BOOL oddNumber = count%2 == 1?YES:NO;
    NSMutableArray *arrowIndex = [NSMutableArray array];
    if (oddNumber) {
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2]];
    } else {
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2 - 1]];
        [arrowIndex addObject:[NSNumber numberWithInteger:count/2]];
    }
    
    for (int i = 0; i < count; i++) {
        
        if (_selectIndex == i) {
            CGContextSetFillColorWithColor(contextRef, kSelectedColor.CGColor);
        } else {
            CGContextSetFillColorWithColor(contextRef, kDefaultColor.CGColor);
        }
        
        CGContextMoveToPoint(contextRef, rect.origin.x + i * kItemWidth, rect.origin.y);
        /*
        if (i == 0) {
            // 4
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + radius + i* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
            // 圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + radius + i * kItemWidth, kItemHeight - kTriangelHeight - radius, radius, 0.5 * M_PI, M_PI, 0);
            // 5
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+radius);
            // 圆弧
            CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + radius, rect.origin.y +radius, radius, M_PI, 1.5 * M_PI, 0);
        } else if (i == 1) {
            // 箭头
            // 4 - 1
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 + kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
            // 4-2
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0, rect.origin.y + kItemHeight);
            // 4- 3
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 - kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
            // 4- 4
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
            // 5
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
        } else {
            // 4
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
            // 5
            CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
        }*/
        
        if (oddNumber) {
            
            if (i < count - 1) {
                // 2
                CGContextAddLineToPoint(contextRef, kLineWidth*i + rect.origin.x + (i + 1) * kItemWidth, rect.origin.y);
                // 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                
            } else {
                // 2
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y);
                // 圆弧
                //圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y + radius, radius, -0.5 * M_PI, 0.0, 0);
                // 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight - radius);
                // 圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, kItemHeight - kTriangelHeight - radius, radius, 0.0, 0.5 * M_PI, 0);
            }
            
            if (i == 0) {
                // 4
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + radius + i* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                // 圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + radius + i * kItemWidth, kItemHeight - kTriangelHeight - radius, radius, 0.5 * M_PI, M_PI, 0);
                // 5
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+radius);
                // 圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + radius, rect.origin.y +radius, radius, M_PI, 1.5 * M_PI, 0);
                
            } else if (i == [[arrowIndex lastObject] integerValue]) {
                // 箭头
                // 4 - 1
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 + kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
                // 4-2
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0, rect.origin.y + kItemHeight);
                // 4- 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + kItemWidth/2.0 - kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
                // 4- 4
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                // 5
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
            } else {
                // 4
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                // 5
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
            }
        //////////////////////////////////////////
        }else {
            if (i < count - 1) {
                // 2
                CGContextAddLineToPoint(contextRef, kLineWidth*i + rect.origin.x + (i + 1) * kItemWidth, rect.origin.y);
                
            } else {
                // 2
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y);
                // 圆弧
                //圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, rect.origin.y + radius, radius, -0.5 * M_PI, 0.0, 0);
                // 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight - radius);
                // 圆弧
                CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth - radius, kItemHeight - kTriangelHeight - radius, radius, 0.0, 0.5 * M_PI, 0);
            }
            
            if (i == [[arrowIndex firstObject] integerValue]) {
                // 3 - 1
                CGContextAddLineToPoint(contextRef, kLineWidth*i + rect.origin.x + (i + 1) * kItemWidth , rect.origin.y + kItemHeight);
                // 3 - 2
                CGContextAddLineToPoint(contextRef, leftMedium, rect.origin.y + kItemHeight - kTriangelHeight);
                
                if (i == 0) {
                    // 4
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + radius + i* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                    // 圆弧
                    CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + radius + i * kItemWidth, kItemHeight - kTriangelHeight - radius, radius, 0.5 * M_PI, M_PI, 0);
                    // 5
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+radius);
                    // 圆弧
                    CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + radius, rect.origin.y +radius, radius, M_PI, 1.5 * M_PI, 0);
                    
                } else {
                    // 4
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                    // 5
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
                }
                

            } else if (i == [[arrowIndex lastObject] integerValue]){
                // 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                // 4 - 1
                CGContextAddLineToPoint(contextRef, rightMedium, rect.origin.y+kItemHeight - kTriangelHeight);
                // 4 - 2
                CGContextAddLineToPoint(contextRef, rect.origin.x + i * kItemWidth + kLineWidth * i, rect.origin.y + kItemHeight);
                // 5
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
            } else {
                // 3
                CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + (i + 1)* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                
                if (i == 0) {
                    // 4
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + radius + i* kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                    // 圆弧
                    CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + radius + i * kItemWidth, kItemHeight - kTriangelHeight - radius, radius, 0.5 * M_PI, M_PI, 0);
                    // 5
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y+radius);
                    // 圆弧
                    CGContextAddArc(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth + radius, rect.origin.y +radius, radius, M_PI, 1.5 * M_PI, 0);
                    
                } else {
                    // 4
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y + kItemHeight - kTriangelHeight);
                    // 5
                    CGContextAddLineToPoint(contextRef, kLineWidth*i +rect.origin.x + i * kItemWidth, rect.origin.y);
                }
            }
        }
        
        CGContextFillPath(contextRef);
    }
    
    /*
    CGFloat radius = kCornerRadius;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // down
    CGContextMoveToPoint(contextRef, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width - radius, rect.origin.y);
    
    //圆弧
    CGContextAddArc(contextRef, rect.size.width - radius, rect.origin.y +radius, radius, -0.5 * M_PI, 0.0, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width, rect.origin.y + kItemHeight - kTriangelHeight - radius);
    //圆弧
    CGContextAddArc(contextRef, width - radius, height - radius-kTriangelHeight, radius, 0.0, 0.5 * M_PI, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2+kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2, rect.origin.y + kItemHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x + rect.size.width/2-kTriangelLong/2.0, rect.origin.y + kItemHeight - kTriangelHeight);
    CGContextAddLineToPoint(contextRef, rect.origin.x, rect.origin.y + kItemHeight - kTriangelHeight);
    //圆弧
    CGContextAddArc(contextRef, radius, height - radius-kTriangelHeight, radius, 0.5 * M_PI, M_PI, 0);
    
    CGContextAddLineToPoint(contextRef, rect.origin.x, rect.origin.y);
    //圆弧
    CGContextAddArc(contextRef, radius, rect.origin.y + radius, radius, M_PI, 1.5 * M_PI, 0);
    
    CGContextFillPath(contextRef);
    
    CGContextSaveGState(contextRef);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(contextRef, 1);
    // 画分割线
    for (int i = 0; i < _titles.count-1; i++) {
        // down
        CGContextMoveToPoint(contextRef, (i+1)*(kItemWidth - 1), rect.origin.y+5);
        CGContextAddLineToPoint(contextRef, (i+1)*(kItemWidth - 1), rect.origin.y + kItemHeight - kTriangelHeight - 5);
        CGContextStrokePath(contextRef);
    }
    
    CGContextRestoreGState(contextRef);
     */
}


@end
