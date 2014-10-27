//
//  SubViewController.m
//  ImageDemo
//
//  Created by shaofa on 14-3-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SubViewController.h"
#import "SFContextView.h"
#import "PicViewController.h"

@interface SubViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *mediumView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation SubViewController
{
    BOOL beginMove;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mediumView.layer.borderWidth = 15;
    self.mediumView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.mediumView.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveTo:(float)y
{
    
    self.mediumView.top = self.mediumView.top + y;
    self.topView.bottom = self.mediumView.top;
    self.bottomView.top = self.mediumView.bottom;
    
    self.topView.height = self.topView.height + y;
    self.bottomView.height = self.bottomView.height - y;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint locationPoint = [touch locationInView:self.view];
    CGPoint previousPoint =[touch previousLocationInView:self.view];
    float xl = locationPoint.y - previousPoint.y;
    if (beginMove) {
        [self moveTo:xl];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.mediumView];
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    if (point.y >= 0 && point.y < 300) {
        beginMove = YES;
    } else {
        beginMove = NO;
    }
    
}

- (IBAction)selectedAction:(id)sender {
    
    CGRect frame = self.mediumView.frame;
    frame.origin.y += self.topView.height;
    frame.size.height *= 2;
    frame.size.width *= 2;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.imgView.image.CGImage, frame);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:2 orientation:UIImageOrientationUp];
    NSLog(@"%@", NSStringFromCGSize(image.size));
    
    PicViewController *pic = [[PicViewController alloc] init];
    pic.image = image;
    [self.navigationController pushViewController:pic animated:YES];
}

@end
