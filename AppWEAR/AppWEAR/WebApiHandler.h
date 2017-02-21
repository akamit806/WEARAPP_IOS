//
//  WebApiHandler.h
//  AppWEAR
//
//  Created by HKM on 20/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface WebApiHandler : NSObject

+(instancetype)sharedHandler;

-(NSURLSessionTask *)loginWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)loginUsingSocialWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)signUpWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)forgotPasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)changePasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)updateProfileWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)updateAvatarWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

-(NSURLSessionTask *)getUserProfileWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

@end
