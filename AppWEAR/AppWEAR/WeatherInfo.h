//
//  WeatherInfo.h
//  AppWEAR
//
//  Created by HKM on 12/04/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfo : NSObject

@property (nonatomic, strong) NSNumber *cloudCoverPercent;
@property (nonatomic, strong) NSString *detailedDescription;
@property (nonatomic, strong) NSNumber *dewPoint;
@property (nonatomic, strong) NSDate *forecastDateLocalStr;
@property (nonatomic, strong) NSNumber *iconCode;
@property (nonatomic, strong) NSNumber *isNightTimePeriod;
@property (nonatomic, strong) NSNumber *precipCode;
@property (nonatomic, strong) NSNumber *precipProbability;
@property (nonatomic, strong) NSNumber *relativeHumidity;
@property (nonatomic, strong) NSNumber *snowAmountMm;
@property (nonatomic, strong) NSString *summaryDescription;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *thunderstormProbability;
@property (nonatomic, strong) NSNumber *windDirectionDegrees;
@property (nonatomic, strong) NSNumber *windSpeed;

-(instancetype)initWithWeatherData:(NSDictionary *)data;

@end
