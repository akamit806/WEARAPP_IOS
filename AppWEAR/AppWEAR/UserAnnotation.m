//
//  UserAnnotation.m
//  AppWEAR
//
//  Created by HKM on 02/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "UserAnnotation.h"

@implementation UserAnnotation

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D) coordinate
{
    self = [super init];
    _coordinate = coordinate;
    return self;
}

@end
