//
//  WebApiHandler.m
//  AppWEAR
//
//  Created by HKM on 20/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "WebApiHandler.h"
#import "AFNetworking.h"
#import "AppConstants.h"

@interface WebApiHandler ()
{
    AFHTTPSessionManager *sessionManager;
    AFHTTPSessionManager *weatherSessionManager;
}

@end

@implementation WebApiHandler

+(instancetype)sharedHandler
{
    static WebApiHandler *handler = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handler = [[WebApiHandler alloc] init];
    });
    return handler;
}

-(instancetype)init
{
    self = [super init];
    [self initialize];
    return self;
}

-(void)initialize
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setTimeoutIntervalForRequest:60.0];
    [configuration setTimeoutIntervalForResource:300.0];
    sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURL] sessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    //Weather Session Manager
    weatherSessionManager = [AFHTTPSessionManager manager];
    [weatherSessionManager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [weatherSessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
}

#pragma -mark Internal Methods

-(NSURLSessionTask *)GET:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager GET:apiPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            success(response);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)POST:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager POST:apiPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            success(response);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)PUT:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager PUT:apiPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            success(response);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)DELETE:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager DELETE:apiPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            success(response);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

#pragma -mark Custom APIs

-(NSURLSessionTask *)loginWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *loginPath = [kAPIBaseURL stringByAppendingString:kLogin];
    return [self POST:loginPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)loginUsingSocialWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
{
    NSString *loginPath = [kAPIBaseURL stringByAppendingString:kLoginWithSocial];
    return [self POST:loginPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)signUpWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *signUpPath = [kAPIBaseURL stringByAppendingString:kSignUp];
    return [self POST:signUpPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)forgotPasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *forgotPasswordPath = [kAPIBaseURL stringByAppendingString:kForgotPassword];
    return [self POST:forgotPasswordPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)changePasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *changePasswordPath = [kAPIBaseURL stringByAppendingString:kChangePassword];
    return [self POST:changePasswordPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)updateProfileWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *updateProfilePath = [kAPIBaseURL stringByAppendingString:kUpdateProfile];
    return [self POST:updateProfilePath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)updateAvatarWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *updateProfilePath = [kAPIBaseURL stringByAppendingString:kUpdateAvatar];
    return [self POST:updateProfilePath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)getUserProfileWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *getUserProfilePath = [kAPIBaseURL stringByAppendingString:kGetUserDetail];
    return [self POST:getUserProfilePath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)updateUserLocationWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *updateUserLocation = [kAPIBaseURL stringByAppendingString:kUpdateLocation];
    return [self POST:updateUserLocation parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)getUsersByRadiusWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *getUsersByRadius = [kAPIBaseURL stringByAppendingString:kGetUsersByRadius];
    return [self POST:getUsersByRadius parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)saveTrailWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *saveTrail = [kAPIBaseURL stringByAppendingString:kTrialSave];
    return [self POST:saveTrail parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)searchTrailWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *searchTrail = [kAPIBaseURL stringByAppendingString:kSearchTrial];
    return [self POST:searchTrail parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)searchUserTrailWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *searchUserTrail = [kAPIBaseURL stringByAppendingString:kSearchUserTrial];
    return [self POST:searchUserTrail parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)getSettingsWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *getSettings = [kAPIBaseURL stringByAppendingString:kGetSetting];
    return [self POST:getSettings parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)updateSettingsWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
{
    NSString *updateSettings = [kAPIBaseURL stringByAppendingString:kUpdateSetting];
    return [self POST:updateSettings parameters:parameters success:success failure:failure];
}

#pragma -mark Weather API

-(NSURLSessionTask *)getWeatherInfoWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [weatherSessionManager GET:kWeatherAPIURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        failure(error);
    }];
}

@end
