//
//  MapPage.m
//  MapDemo
//
//  Created by sfwan on 14-9-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "MapPage.h"
#import "SFAnotationModel.h"

@interface MapPage ()<MKMapViewDelegate>

@end

@implementation MapPage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    _mapView = [[MKMapView alloc] initWithFrame:self.bounds];
    [self addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D coord = {39.90691,116.2287};
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
    _mapView.region = region;
    
    NSMutableArray *annotations = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        coord = CLLocationCoordinate2DMake(coord.latitude + i * 0.01, coord.longitude + i * 0.01);
        SFAnotationModel *anotation = [[SFAnotationModel alloc] initWithCoordinate:coord];
        anotation.title = [NSString stringWithFormat:@"呵呵%d", i];
        anotation.subtitle = [NSString stringWithFormat:@"hehe%d", i];
        [annotations addObject:anotation];
    }
    [_mapView addAnnotations:annotations];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //    if (![annotation isKindOfClass:[WXAnotationModel class]]) {
    //        return nil;
    //    }
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identify = @"annotationView";
    
    MKPinAnnotationView *anotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    if (anotationView == nil) {
        anotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        
        //设置大头针的颜色
        anotationView.pinColor = MKPinAnnotationColorGreen;
        
        //是否显示从天而降的动画
        anotationView.animatesDrop = YES;
        
        //是否显示标题视图
        anotationView.canShowCallout = YES;
        
        //添加辅助视图
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        anotationView.rightCalloutAccessoryView = button;
        //        anotationView.leftCalloutAccessoryView
    }
    
    //将标注model交给标注视图去展示数据
    anotationView.annotation = annotation;
    
    return anotationView;
}

@end
