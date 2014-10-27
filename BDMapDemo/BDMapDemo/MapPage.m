//
//  MapPage.m
//  BDMapDemo
//
//  Created by sfwan on 14-9-5.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MapPage.h"

@interface MapPage ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@end

@implementation MapPage
{
    BMKLocationService *_service;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    _mapView = [[BMKMapView alloc] initWithFrame:self.bounds];
    _mapView.delegate = self;
    
    _mapView.showMapScaleBar = YES;
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(32.111, 23.222);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1, 0.1);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coord, span);
    _mapView.region = region;
    
    _mapView.mapType = BMKMapTypeStandard;
    [self addSubview:_mapView];
    
    _service = [[BMKLocationService alloc] init];
    _service.delegate = self;
//    [_service startUserLocationService];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 300, 50, 50);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"定位" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(void)locationAction
{
    [_service startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

@end
