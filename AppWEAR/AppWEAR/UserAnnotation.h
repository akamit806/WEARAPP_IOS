//
//  UserAnnotation.h
//  AppWEAR
//
//  Created by HKM on 02/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface UserAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
