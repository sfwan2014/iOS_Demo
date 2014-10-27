//
//  altitudeViewController.m
//  Altitude
//
//  Created by Matt Gabriel on 03/11/2013.
//  Copyright (c) 2013 Matt Gabriel. All rights reserved.
//

#import "altitudeViewController.h"

@interface altitudeViewController ()

@end

@implementation altitudeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    _startLocation = nil;
    
    [self drawLines]; //call the draw line method
}

- (void)drawLines {
    int lineStartValue = 1000;
    for(int i = 0; i <27; i++){
        int yCoor = 60 + (18 * i); //60 = offset from the top of the screen; 20 = space between bars
        int lineWidth = 15;
        if(i % 5 == 0){
            lineWidth = 25; //longer line
            //also add label
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.00, (yCoor - 10), 50.00, 20.00)];
            if(lineStartValue == 1000){
                int kilos = lineStartValue / 1000;
                lineLabel.text = [NSString stringWithFormat:@"%dk",kilos];
            } else {
                lineLabel.text = [NSString stringWithFormat:@"%d",lineStartValue];
            }
            lineLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
            [self.view addSubview:lineLabel];
            lineStartValue = lineStartValue - 200;
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, yCoor, lineWidth, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:lineView];
    }
}


-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    float altitude = newLocation.altitude;
    float altitudeMapped = [self mapping:altitude inMin:-40.00 inMax:1000.00 outMin:528.00 outMax:40.00];
    
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        
        [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationTransitionNone | UIViewAnimationOptionCurveLinear animations:^(void){
            
            _heightLabel.center = CGPointMake(_heightLabel.center.x, (altitudeMapped - 7.00));
            _heightLabelBG.center = CGPointMake(_heightLabelBG.center.x, altitudeMapped);
            _label.center = CGPointMake(_label.center.x, (altitudeMapped + 27.00));
            
        }completion:^(BOOL Finished){ }];
    } else {
    
        [UIView animateWithDuration:2.0 animations:^{
            _heightLabel.center = CGPointMake(_heightLabel.center.x, (altitudeMapped - 7.00));
            _heightLabelBG.center = CGPointMake(_heightLabelBG.center.x, altitudeMapped);
            _label.center = CGPointMake(_label.center.x, (altitudeMapped + 27.00));
        } completion:^(BOOL finished) {
            
        }];
    }
    
    _heightLabel.text = [NSString stringWithFormat:@"%.2fm",altitude];
    //_label.text = [NSString stringWithFormat:@"%.2f m",newLocation.verticalAccuracy];
    
    //float latitude  = newLocation.coordinate.latitude;
    //float longitude = newLocation.coordinate.longitude;
    //_label.text = [NSString stringWithFormat:@"Lat: %f, Long: %f",latitude,longitude];
    _label.text = [NSString stringWithFormat:@"Accuracy %.2f m",newLocation.verticalAccuracy];
   
    
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error {
    _heightLabel.text = [NSString stringWithFormat:@"0.00m"];
}


-(float)mapping:(float)currentValue inMin:(float)inMin inMax:(float)inMax outMin:(float)outMin outMax:(float)outMax{
    //mapping function, just like in arduino
    float result = (currentValue - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
    return result;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
