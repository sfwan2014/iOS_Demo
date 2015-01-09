//
//  ViewController.m
//  MDCustomProgress
//
//  Created by sfwan on 14-12-18.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "MDCustomProgress.h"

#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MDCustomProgress *pv;

@end

@implementation ViewController{
    MDCustomProgress *progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    progress = [[MDCustomProgress alloc] initWithFrame:CGRectMake(0, 300, 300, 20) normalColor:nil highlightColor:nil];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    progress.highlightColor = RGBA(198, 157, 70, 1);
    progress.normalColor = RGBA(244, 235, 218, 1);
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    
    _pv.highlightColor = RGBA(198, 157, 70, 1);
}

-(void)time:(NSTimer *)tr{
    static CGFloat val = .1;
    
    [progress setProgress:val animation:YES];
    [_pv setProgress:val animation:YES];
    val+=0.1;
    if (val > 1) {
        val = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
