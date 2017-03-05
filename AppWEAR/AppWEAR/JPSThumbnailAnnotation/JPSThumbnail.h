//
//  JPSThumbnail.h
//  JPSThumbnailAnnotation
//
//  Created by Jean-Pierre Simard on 4/22/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

typedef void (^ActionBlock)();

@interface JPSThumbnail : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *profilePicURL;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) ActionBlock disclosureBlock;
@property (nonatomic) UIViewContentMode contentMode;

@end
