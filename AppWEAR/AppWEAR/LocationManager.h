//
//  LocationManager.h
//  AppWEAR
//
//  Created by HKM on 27/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

FOUNDATION_EXPORT NSString *const kLocationUpdateNotification;
FOUNDATION_EXPORT NSString *const kLocationPlacemark;

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLPlacemark *recentPlacemark;
    CLGeocoder *geocoder;
}

@property (nonatomic, strong, readonly) CLPlacemark *recentPlacemark;

+(instancetype)sharedManager;

-(void)stopLocationManager;

@end
