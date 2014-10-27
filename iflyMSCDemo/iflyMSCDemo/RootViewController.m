//
//  RootViewController.m
//  iflyMSCDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "ZCNoneiFLYTEK.h"
#import "HJCFRecordProvider.h"
#import "ReviewViewController.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) HJCFRecordProvider *provider;

@end

@implementation RootViewController
{
    NSTimer *_timer;
    NSInteger time;
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

    time = 0;
    self.provider = [HJCFRecordProvider shareInstance];
    
}
- (IBAction)playVoice:(id)sender {
    NSString *text = _textField.text;
    ZCNoneiFLYTEK *flytek = [ZCNoneiFLYTEK shareManager];
    [flytek playVoice:text];
}
- (IBAction)readVoice:(id)sender {
    ZCNoneiFLYTEK *flytek = [ZCNoneiFLYTEK shareManager];
    [flytek discernBlock:^(NSString *str) {
        _label.text = str;

    }];
}

- (IBAction)recordVoice:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        if ([self.provider startRecordAudio]) {
            time = 0;
            if ([_timer respondsToSelector:@selector(invalidate)]) {
                [_timer invalidate];
                _timer = nil;
            }
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        }
    } else {
        [self.provider stopRecord];
        [_timer invalidate];
    }
}

-(IBAction)playRecordAudio:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.provider playRecordAudio];
    } else {
        [self.provider stopPlayeAudio];
    }
}

-(IBAction)reviewAudio:(UIButton *)sender{
    ReviewViewController *review = [[ReviewViewController alloc] init];
    [self.navigationController pushViewController:review animated:YES];
}

-(void)timeAction:(NSTimer *)timer
{
    time ++;
    _timeLabel.text = [NSString stringWithFormat:@"%d", time];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
