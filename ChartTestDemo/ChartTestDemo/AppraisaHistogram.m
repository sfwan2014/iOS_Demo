//
//  SimpleHistogram.m
//  FinancialIPAD
//
//  Created by zsc on 13-12-30.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import "AppraisaHistogram.h"
#import "AppraisaHistogramBar.h"
#import "AppraisaVirtualHistogramBar.h"
#import "FWTextLayer.h"

#define kNULLVALUE                  @"- -"

@implementation AppraisaHistogram{
    NSArray *_dataList;
    NSArray *_titleList;
    NSArray *_colorList;
    NSArray *_titleColors;
    
    UIColor *_oneColor;
    UIColor* _titleColor;//标题颜色
    UIFont * _titleFont;//标题Font
    
    //表示柱状图边界所留的距离
    UIEdgeInsets _edges ;
    BOOL _isCustomEdges;
    
    CALayer * _barsLayer;
    CALayer * _titlesLayer;
    
    BOOL _isPercentage;
    
    NSMutableArray * _barXPoint;//用来存储每个柱 子中心点的X位置值。
    NSMutableArray *_allBars;
    
    AppraisaVirtualHistogramBar *virtualLayer;//虚拟层
    NSMutableArray *_titleLayers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isCustomEdges=NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesPoint:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _isCustomEdges=NO;
}

-(void) setData:(NSArray *)lineData  andBarColors:(NSArray *)colors andTitles:(NSArray *) titles andTitleColors:(NSArray*)titleColors andTitleFont:(UIFont*)titleFont{
    _dataList = lineData;
    _titleList=titles;
    _colorList=colors;
    _titleColors= titleColors;
    _titleFont=titleFont;
    
    [self setNeedsDisplay];
}

-(void) setData:(NSArray *)lineData  andBarColors:(NSArray *)colors andTitles:(NSArray *) titles andTitleColor:(UIColor*)titleColor andTitleFont:(UIFont*)titleFont{
    _dataList = lineData;
    _titleList=titles;
    _colorList=colors;
    _titleColor=titleColor;
    _titleFont=titleFont;
    
    [self setNeedsDisplay];
}

-(void)setData:(NSArray*) lineDatas{
    _dataList=lineDatas;
    
    [self setNeedsDisplay];
}

-(void)setEdgeInsets:(UIEdgeInsets) edge{
    _edges=edge;
    _isCustomEdges=YES;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_dataList==nil) {
        return;
    }
    _oneColor = nil;
    if (_colorList==nil || _colorList.count!=_dataList.count) {
        _oneColor= RGBA_Color(245, 196, 62, 0.7);
    }
    //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    if (_isCustomEdges==NO) {
         _edges = UIEdgeInsetsMake(30, 20, 30, 20);
    }
    
    _barsLayer = [CALayer layer];
    _barsLayer.backgroundColor=[UIColor clearColor].CGColor;
    _barsLayer.frame=CGRectMake(_edges.left, _edges.top, rect.size.width-_edges.left-_edges.right, rect.size.height-_edges.top-_edges.bottom);
    [self.layer addSublayer:_barsLayer];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    //画x 轴线以及平行线
//    [self drawXAxis:context withLineWidth:1.0f andLineColor:RGBA_Color(223, 223, 223, 1.0) andRect:_barsLayer.frame andavgLineColor:RGBA_Color(240, 240, 241, 1.0f)];
    
    //计算每个柱子中心点的Xpoint的位置
    [self getBarCenterX:_dataList.count andRect:rect];
    
    _titlesLayer=[CALayer layer];
    _titlesLayer.frame=CGRectMake(_edges.left, rect.size.height-_edges.bottom-2, rect.size.width-_edges.left-_edges.right, _edges.bottom-2);
    [self.layer addSublayer:_titlesLayer];
    
    [self drawTitle:_titleList andTitleLayer:_titlesLayer andFont:_titleFont andTitleColor:_titleColor];
    
    [self drawBar:_dataList colorsArray:_colorList andTitles:_titleList andTitleFont:nil andTitleColor:[UIColor whiteColor] andLayer:_barsLayer];
}

//绘制柱子
-(void)drawBar:(NSArray *)arr colorsArray:(NSArray *)colors andTitles:(NSArray*)titles andTitleFont:(UIFont*) titleFont andTitleColor:(UIColor*)titleColor andLayer:(CALayer *)layer {
    if (arr!=nil && arr.count>0) {
        
        //柱状图中最高那个的值
        float maxValue = [self getMaxValue:arr];
        
        //每个柱子的宽度
        float barWidth = [self getBarWidth:arr.count andRect:layer.frame];
        
        AppraisaHistogramBar *bar =nil;
        
        _allBars = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            
            float xCenter = [_barXPoint[i] floatValue];
            float barHeight = 0.0;
            float v = [arr[i] floatValue]*10000;
            if (v<0) {
                barHeight = -[self getBarHeigth:[arr[i] floatValue] andMaxValue:maxValue andRect:layer.frame];
            }
            else{
                barHeight = [self getBarHeigth:[arr[i] floatValue] andMaxValue:maxValue andRect:layer.frame];
            }
            
            CGRect barRect = CGRectMake(xCenter - barWidth/2.0,  layer.frame.size.height, barWidth, barHeight);
            
            if (_oneColor==nil) {
                   bar=[[AppraisaHistogramBar alloc] initWithFrame:barRect andbgColor:((UIColor *)colors[i]).CGColor];
            }
            else{
                  bar=[[AppraisaHistogramBar alloc] initWithFrame:barRect andbgColor:_oneColor.CGColor];
            }
            
            NSString *t = [arr[i] floatValue]==MAXFLOAT ?kNULLVALUE: [NSString stringWithFormat:@"%.f%%",[arr[i] floatValue]*100.0];
            
            [bar setHeight:barHeight andAnimationDuration:1.0 andDelay:0.5 andTitle:t andTitleFont:titleFont andTitleColor:titleColor];
            [_allBars addObject:bar];
            [_barsLayer addSublayer:bar];
        }
    }
}

//绘制X轴的title
-(void)drawTitle:(NSArray *)titles andTitleLayer:(CALayer*)layer andFont:(UIFont*)font andTitleColor:(UIColor*)color{
    if (titles!=nil &&titles.count>0) {
        if (color==nil) {
            color=RGBA_Color(173, 173, 173, 1);
        }
        if (font==nil) {
            font=[UIFont systemFontOfSize:14.0f];
        }
        
        _titleLayers = [NSMutableArray array];
        for (int i = 0 ; i < titles.count; i++) {
            FWTextLayer * txt = [FWTextLayer layer];
            
            if (_titleColors.count == titles.count) {
                txt.foregroundColor=[_titleColors[i] CGColor];
//                txt.shadowColor = _titleColors[i];
            } else {
                txt.foregroundColor = [UIColor orangeColor].CGColor;
            }
            
            [txt setTextFont:font text:titles[i] position:CGPointMake([_barXPoint[i] floatValue], layer.frame.size.height/2.0)];
            [layer addSublayer:txt];
            [_titleLayers addObject:txt];
        }
    }
}

-(void)drawXAxis:(CGContextRef )context withLineWidth:(float)lineWidth andLineColor:(UIColor *) lineColor andRect:(CGRect)rect andavgLineColor:(UIColor*)avgLineColor{
    
    CGContextSaveGState(context);
    
    float avgHeight =rect.size.height/5.0;
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    float w = rect.size.width+_edges.left;
    CGContextMoveToPoint(context, _edges.left, rect.size.height+_edges.top);
    CGContextAddLineToPoint(context, w, rect.size.height+_edges.top);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, avgLineColor.CGColor);
    
    for (int i=0; i<5; i++) {
        CGContextMoveToPoint(context, _edges.left, i*avgHeight+_edges.top);
        CGContextAddLineToPoint(context, w, i*avgHeight+_edges.top);
    }
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

//计算每个柱子中心点的Xpoint的位置.
-(void) getBarCenterX:(int) barCount andRect:(CGRect)rect{
    _barXPoint = [NSMutableArray arrayWithCapacity:barCount];
    
    float eachWidth = (rect.size.width*1.0 - _edges.left-_edges.right)/(barCount+1);
    for (int i = 0; i<barCount; i++) {
        [_barXPoint addObject:[NSNumber numberWithFloat:eachWidth*(i+1)]];
    }
}

//计算每个柱子的宽度
-(float)getBarWidth:(int)barCount andRect:(CGRect)rect{
    float barWidth=(self.frame.size.width-_edges.left-_edges.right-10)/(barCount+1);;
    
//    float avgWidth = rect.size.width/ barCount*1.0;
//    if (barWidth*2 > avgWidth) {
//        barWidth= avgWidth/2.0;
//    }
    
    return barWidth;
}

//计算每个柱子的高度
-(float)getBarHeigth:(float)barValue andMaxValue:(float)maxValue andRect:(CGRect)rect{
    float temp = maxValue*100  == 0 ? 1: maxValue;
    float rtn = barValue * rect.size.height / temp ;//* 100 == 0 ? 1 : maxValue;
    return rtn;
}

//获取需要绘制柱状图的最高一个柱子的值。
-(float)getMaxValue:(NSArray *)arr {
    float maxValue=0.0;
    if (arr!=nil && arr.count>0) {
        for (int i=0; i<arr.count; i++) {
            if ([arr[i] floatValue]>maxValue) {
                maxValue=[arr[i] floatValue];//找出所有要绘制的值中的最大值
            }
        }
    }
    return maxValue;
}


//touch事件
-(void)touchesPoint:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint locationInView = [gestureRecognizer locationInView:self];
    AppraisaHistogramBar *layer=(AppraisaHistogramBar *)[[_barsLayer presentationLayer] hitTest:locationInView];
    if (layer != nil && [layer isKindOfClass:[AppraisaHistogramBar class]]) {
        [self showVirtualLayer:layer];
    } else if ([layer isKindOfClass:[FWTextLayer class]]) {
        layer = (AppraisaHistogramBar *)layer.superlayer;
        [self showVirtualLayer:layer];
    } else if([layer isKindOfClass:[AppraisaVirtualHistogramBar class]]){
        
    }else {
        [self hideVirtualLayer];
    }
}

-(void)hideVirtualLayer{
    NSArray *subLays = [_barsLayer sublayers];
    NSMutableArray *arr = [NSMutableArray array];
    for (CALayer *laye in subLays) {
        if ([laye isKindOfClass:[AppraisaVirtualHistogramBar class]]) {
            [arr addObject:laye];
        }
    }
    if (arr.count > 0) {
        for (CALayer *laye in arr) {
            [laye removeFromSuperlayer];
        }
    }
}

-(void)showVirtualLayer:(CALayer *)layer{
    
    NSString *title = nil;
    FWTextLayer *txt = nil;
    NSInteger index = -1;
    for (int i = 0; i < _allBars.count; i++) {
        CALayer *l1 = _allBars[i];
        if ([NSStringFromCGPoint(l1.position) isEqualToString:NSStringFromCGPoint(layer.position)]) {
            title = [_dataList[i] floatValue]==MAXFLOAT ?kNULLVALUE: [NSString stringWithFormat:@"%.f%%",[_dataList[i] floatValue]*100.0];
            txt = _titleLayers[i];
            index = i;
        }
    }
    if (virtualLayer != nil) {
        [virtualLayer removeFromSuperlayer];
        virtualLayer = nil;
    }
    virtualLayer = [[AppraisaVirtualHistogramBar alloc] initWithFrame:layer.frame andbgColor:[_colorList[index] CGColor]];
    virtualLayer.position = layer.position;
    virtualLayer.bounds = layer.bounds;
    virtualLayer.frame = layer.frame;
    virtualLayer.borderColor = [UIColor whiteColor].CGColor;
    virtualLayer.borderWidth = 1;

    [virtualLayer setHeight:layer.frame.size.height andAnimationDuration:0 andDelay:0 andTitle:title andTitleFont:nil andTitleColor:[UIColor whiteColor]];
    
    FWTextLayer *textLayer = [self createTxtFromTxt:txt ForIndex:index];
    
    if ([_tapDelegate respondsToSelector:@selector(simpleHistogramTap:tapLayers:selectedIndex:)]) {
        [_tapDelegate simpleHistogramTap:self tapLayers:@[virtualLayer, textLayer] selectedIndex:index];
    }
}

-(FWTextLayer *)createTxtFromTxt:(FWTextLayer *)txt ForIndex:(NSInteger)i{
    FWTextLayer * textLayer = [FWTextLayer layer];
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    [textLayer setTextFont:txt.font text:_titleList[i] position:CGPointMake([_barXPoint[i] floatValue], _titlesLayer.frame.size.height/2.0)];
    
    return textLayer;
}

@end
