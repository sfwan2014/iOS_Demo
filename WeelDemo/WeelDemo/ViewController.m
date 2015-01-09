//
//  ViewController.m
//  WeelDemo
//
//  Created by sfwan on 14-12-20.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "ViewController.h"
#import "CDCircleOverlayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300) numberOfSegments:10 ringWidth:100.f];
    NSArray *data= @[@0.3,@0.2,@0.4,@0.1];
    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300)numberOfData:data ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    
    
    [self.view addSubview:circle];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
    [self.view addSubview:overlay];
    self.view.backgroundColor = [UIColor lightGrayColor];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Circle delegate & data source

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Segment's tag: %i", segment] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //    [alert show];
    
    
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil] lastObject];
    
    return [UIImage imageWithContentsOfFile:fileString];
    
}

@end
