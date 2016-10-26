//
//  BaiduMapClusterTest.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaiduMapClusterTest.h"

@interface BaiduMapClusterTest ()
<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@end

@implementation BaiduMapClusterTest

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}



#pragma BMKMapViewDelegate

//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView
//             viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    
//}


@end
