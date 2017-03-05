//
//  UserAnnotation.m
//  AppWEAR
//
//  Created by Hashim Khan on 02/03/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
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
