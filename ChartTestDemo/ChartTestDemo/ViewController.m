//
//  ViewController.m
//  ChartTestDemo
//
//  Created by sfwan on 14-12-15.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "AppraisaHistogram.h"
#import "AppriasialDescriptView.h"
#import "DescriptLayer.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:g/255.0 alpha:a]


@interface UIColor (sss)

+ (UIColor *)colorWithString:(NSString *)name;

@end
int convertToInt(char c)
{
    if (c >= '0' && c <= '9') {
        return c - '0';
    } else if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    } else if (c >= 'A' && c <= 'F') {
        return c - 'A' + 10;
    } else {
        return printf("字符非法!");
    }
}

@implementation UIColor (sss)

+ (UIColor *)colorWithString:(NSString *)name
{
    if (![[name substringToIndex:0] isEqualToString:@"#"] && name.length < 7) {
        return nil;
    }
    const char *str = [[name substringWithRange:NSMakeRange(1, 6)] UTF8String];
    NSString *alphaString = [name substringFromIndex:7];
    CGFloat red = (convertToInt(str[0])*16 + convertToInt(str[1])) / 255.0f;
    CGFloat green = (convertToInt(str[2])*16 + convertToInt(str[3])) / 255.0f;
    CGFloat blue = (convertToInt(str[4])*16 + convertToInt(str[5])) / 255.0f;
    CGFloat alpha = [alphaString isEqualToString:@""] ? 1 : alphaString.floatValue/255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

@interface ViewController ()<SimpleHistogramDelegate>

@end


@implementation ViewController{
    UITapGestureRecognizer *tap;
    AppraisaHistogram *_histogram;
    UIView *_backView;
    AppriasialDescriptView *_appriasal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _histogram = [[AppraisaHistogram alloc] initWithFrame:CGRectMake(0, 100, 320, 150)];
    _histogram.tapDelegate = self;
    _histogram.backgroundColor = rgba(222, 222, 222, 0.7);
    [self.view addSubview:_histogram];
    
    NSArray *colors =@[[UIColor colorWithString:@"#e57857"], [UIColor colorWithString:@"#efc86a"], [UIColor colorWithString:@"#a8cc8d"], [UIColor colorWithString:@"#88b2e7"]];
    NSArray *titles = @[@"高流动性",@"固定收益",@"浮动收益",@"另类投资"];
    [_histogram setData:@[@0.4,@0.2,@0.3, @0.1] andBarColors:colors andTitles:titles andTitleColors:colors andTitleFont:[UIFont systemFontOfSize:13]];
    [_histogram setEdgeInsets:UIEdgeInsetsMake(30, 10, 30, 10)];
    
    
    _appriasal = [[AppriasialDescriptView alloc] initWithFrame:CGRectMake(10, 260, 300, 200)];
    _appriasal.backgroundColor = rgba(233, 200, 200, 1);
    _appriasal.data = @[@{@"title":@"高流动性",@"product":@[@"abcd",@"abcd"],@"percent":@"30%"},@{@"title":@"高流动性",@"product":@[@"abcd",@"abcd"],@"percent":@"30%"},@{@"title":@"高流动性",@"product":@[@"abcd",@"abcd"],@"percent":@"30%"},@{@"title":@"高流动性",@"product":@[@"abcd",@"abcd"],@"percent":@"30%"}];
    [self.view addSubview:_appriasal];
}



-(void)simpleHistogramTap:(AppraisaHistogram *)histogram tapLayers:(NSArray *)layers selectedIndex:(NSInteger)index{
    
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = rgba(79,79,79,0.7);
    [self.view addSubview:_backView];
    
    CALayer *layer1 = layers[0];
    CGPoint p1 = [layer1 convertPoint:layer1.position fromLayer:histogram.layer];
    CGPoint p = [layer1 convertPoint:p1 toLayer:_backView.layer];
    
    p.x += 10;
    p.y += 30;
    layer1.position = p;
    [_backView.layer addSublayer:layer1];
    
    CALayer *layer2 = layers[1];
    layer2.position = CGPointMake(layer1.position.x, layer1.position.y + layer1.frame.size.height/2.0 + layer2.frame.size.height/2.0 + 5);
    [_backView.layer addSublayer:layer2];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_backView addGestureRecognizer:tap];
    
    
    [self showDescriptionAtIndex:index];
}

-(void)showDescriptionAtIndex:(NSInteger)index{
    DescriptLayer *layer = (DescriptLayer *)_appriasal.desLayers[index];
    CGPoint p1 = [layer convertPoint:layer.position fromLayer:_appriasal.layer];
    CGPoint p = [layer convertPoint:p1 toLayer:_backView.layer];
    
    
    DescriptLayer *layer1 = [[DescriptLayer alloc] initWithFrame:layer.bounds color:[UIColor colorWithString:@"#ececec"].CGColor font:layer.font];
    [layer1 addMessages:_appriasal.data[index]];
    layer1.position = p;
    [_backView.layer addSublayer:layer1];
    
}

-(void)tapAction:(UITapGestureRecognizer *)tap1{
    [tap1.view removeGestureRecognizer:tap];
    [_backView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
