//
//  BaiduMapClusterTest.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaiduMapClusterTest.h"
#import "KTRFootPrintPhotosModel.h"
#import "KTRFootPrintPhotosAnnotation.h"
#import "KTRFootPrintPhotosAnnotationView.h"
#import "KTRFootPrintPhotosAnnotationCalculator.h"

@interface BaiduMapClusterTest ()
<BMKMapViewDelegate>
{
    NSString *_cellId;
    
    NSInteger _currentMapZoomLevel;
}

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (strong, nonatomic) NSMutableArray<KTRFootPrintPhotosModel *> *datas;

@end

@implementation BaiduMapClusterTest

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVars];
}


- (NSString *)title
{
    return @"点聚合demo";
}

- (void)initVars
{
    _cellId = @"cellid";
    _currentMapZoomLevel = -1;
    _datas = [NSMutableArray array];
    
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(39.915, 116.404);
    //向点聚合管理类中添加标注
    NSString *iamgeUrl1 = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
    NSString *iamgeUrl2 = @"http://www.bz55.com/uploads1/allimg/120312/1_120312100435_8.jpg";
    
    
    for (NSInteger i = 0; i < 20; i++) {
        double lat =  (arc4random() % 100) * 0.001f + coor.latitude;
        double lon =  (arc4random() % 100) * 0.001f + coor.longitude;
        //        BMKClusterItem *clusterItem = [[BMKClusterItem alloc] init];
        KTRFootPrintPhotosModel *clusterItem = [[KTRFootPrintPhotosModel alloc] init];
        clusterItem.lat = @(lat);
        clusterItem.log = @(lon);
        
        if (i % 3 == 0){
            clusterItem.imageUrls = @[[NSURL URLWithString:iamgeUrl1],[NSURL URLWithString:iamgeUrl2]];
        }else{
            clusterItem.imageUrls =
            (arc4random() % 2 == 0) ? @[[NSURL URLWithString:iamgeUrl1]] : @[[NSURL URLWithString:iamgeUrl2]];
        }
        
        [_datas addObject:clusterItem];
    }
}



- (void)updateMapView
{
    _currentMapZoomLevel = (NSInteger)_mapView.zoomLevel;
    
    __weak typeof(self) weakSelf = self;
    [KTRFootPrintPhotosAnnotationCalculator
     getClustersWithModels:_datas
     zoomLevel:_currentMapZoomLevel
     completeBlock:^(NSArray<KTRFootPrintPhotosAnnotation *> *annotations) {
         [weakSelf handleAnnotations:annotations];
     }];
}

- (void)handleAnnotations:(NSArray<KTRFootPrintPhotosAnnotation *> *)annotations
{
    if ([NSArray isEmpty:annotations]) return;
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:annotations];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}




#pragma BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView
             viewForAnnotation:(id <BMKAnnotation>)annotation
{
    KTRFootPrintPhotosAnnotationView *annotationView = [[KTRFootPrintPhotosAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:_cellId];
    
    return annotationView;
}

/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self updateMapView];
}

/**
 *地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
 *@param mapview 地图View
 *@param status 此时地图的状态
 */
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
    if (_currentMapZoomLevel != 0 && _currentMapZoomLevel != (NSInteger)mapView.zoomLevel) {
        [self updateMapView];
    }
}
@end
