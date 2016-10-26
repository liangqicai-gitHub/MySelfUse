//
//  KTRFootPrintPhotosModel.m
//  kartor3
//
//  Created by 梁齐才 on 16/10/25.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootPrintPhotosModel.h"

@interface KTRFootPrintPhotosModel ()
{
    CLLocationCoordinate2D _coordinateStored;
}
@end

@implementation KTRFootPrintPhotosModel

- (CLLocationCoordinate2D)coordinate
{
    if (_coordinateStored.latitude != 0 || _coordinateStored.longitude != 0)
    {
        return _coordinateStored;
    }
    
    double lat = 0;
    if ([_lat isKindOfClass:[NSNumber class]]){
        lat = [_lat doubleValue];
    }
    
    double log = 0;
    if ([_log isKindOfClass:[NSNumber class]]){
        log = [_log doubleValue];
    }
    
    _coordinateStored = CLLocationCoordinate2DMake(lat, log);
    
    return _coordinateStored;
}

@end
