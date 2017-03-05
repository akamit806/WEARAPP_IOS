//
//  UserAnnotation.h
//  AppWEAR
//
//  Created by Hashim Khan on 02/03/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface UserAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
