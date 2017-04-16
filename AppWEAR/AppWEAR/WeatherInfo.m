//
//  WeatherInfo.m
//  AppWEAR
//
//  Created by HKM on 12/04/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "WeatherInfo.h"
#import "AppConstants.h"

@implementation WeatherInfo

-(instancetype)initWithWeatherData:(NSDictionary *)data
{
    self = [super init];
    self.cloudCoverPercent = [data objectForKey:@"cloudCoverPercent"];
    self.detailedDescription = [data objectForKey:@"detailedDescription"];
    
    NSDate *date = [weatherDateFormatter() dateFromString:[data objectForKey:@"forecastDateLocalStr"]];
    NSDate *localDate = [appDateFormatter() dateFromString:[appDateFormatter() stringFromDate:date]];
    self.forecastDateLocalStr = localDate;
    
    self.dewPoint = [data objectForKey:@"dewPoint"];
    self.iconCode = [data objectForKey:@"iconCode"];
    self.isNightTimePeriod = [data objectForKey:@"isNightTimePeriod"];
    self.precipCode = [data objectForKey:@"precipCode"];
    self.precipProbability = [data objectForKey:@"precipProbability"];
    self.relativeHumidity = [data objectForKey:@"relativeHumidity"];
    self.snowAmountMm = [data objectForKey:@"snowAmountMm"];
    self.summaryDescription = [data objectForKey:@"summaryDescription"];
    self.temperature = [data objectForKey:@"temperature"];
    self.thunderstormProbability = [data objectForKey:@"thunderstormProbability"];
    self.windDirectionDegrees = [data objectForKey:@"windDirectionDegrees"];
    self.windSpeed = [data objectForKey:@"windSpeed"];
    
    return self;
}

@end
