//
//  RootViewController.m
//  MapDemo
//
//  Created by sfwan on 14-9-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "MapPage.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    MapPage *_map;
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
    // Do any additional setup after loading the view from its nib.
    
    _map = [[MapPage alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:_map atIndex:0];
}
- (IBAction)startLocation:(id)sender {
//    ;
    CLLocationCoordinate2D coord = _map.mapView.userLocation.coordinate;
    
    _map.mapView.region = MKCoordinateRegionMake(coord, _map.mapView.region.span);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
