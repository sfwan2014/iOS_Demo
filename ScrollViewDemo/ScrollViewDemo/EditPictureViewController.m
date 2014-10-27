//
//  EditPictureViewController.m
//  ScrollViewDemo
//
//  Created by shaofa on 14-3-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "EditPictureViewController.h"
#import "ImageViewController.h"

@interface EditPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *backView;

@end

@implementation EditPictureViewController
{
    float top;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    CGSize size = self.image.size;
    float height = size.height/(size.width/320);
    if (height < 320) {
        top = (568 - height)/2 - 124;
    } else {
        top = 124;
    }
    
    [self _initViews];
}

-(void)_initViews
{
    float height = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    
    self.backView.contentSize = CGSizeMake(width+1, height+1);
    self.imgView.image = self.image;
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)selectAction:(id)sender {
    
    CGSize size = self.image.size;
    float height = size.height/(size.width/320);
    CGRect frame = CGRectMake(0, 0, 320, 320);
    if (size.height< 320) {
        frame = CGRectMake(0, 0, size.width, size.height);
    } else {
        float y = self.backView.contentOffset.y + self.backView.size.height -self.backView.contentSize.height;
        float originalY = top + y;
        frame.origin.y = originalY;
        
        float scale = size.width/320.0;
        frame.origin.y *= scale;
        frame.size.height *= scale;
        frame.size.width *= scale;
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(_image.CGImage, frame);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
    
    ImageViewController *imgCtrl = [[ImageViewController alloc] init];
    imgCtrl.image = image;
    [self.navigationController pushViewController:imgCtrl animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGSize size = self.image.size;
    float height = size.height/(size.width/320);
    if (height < 320) {
        top = (568 - height)/2 - 124;
    }
    self.backView.contentInset = UIEdgeInsetsMake(top, 0.01, top, 0.01);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGSize size = self.image.size;
    float height = size.height/(size.width/320);
    top = (568 - height)/2 - 124;
    if (height > 320) {
        top = 124;
    }
    self.backView.contentInset = UIEdgeInsetsMake(top, 0.01, top, 0.01);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = scrollView.contentOffset.y + scrollView.size.height -scrollView.contentSize.height;
    float originalY = top + y;
    NSLog(@"%f", originalY);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
