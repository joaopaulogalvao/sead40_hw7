//
//  StackOverFlowService.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "StackOverFlowService.h"
#import <AFNetworking/AFNetworking.h>
#import "Question.h"
#import "QuestionJSONParser.h"
#import "Errors.h"

@implementation StackOverFlowService

+ (void)questionsForSearchTerm:(NSString *)searchTerm completionHandler: (void(^)(NSArray*,NSError*))completionHandler {
  
  // paste the url here
//  NSString *url = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", searchTerm];
  
  NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
  NSString *key = [NSString stringWithFormat:@"v2sZKSXrki0WtFzerfHrAw(("];
  
  NSString *url = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?key=%@&access_token=%@&order=desc&sort=activity&intitle=%@&site=stackoverflow",key,access_token,searchTerm];
  
  NSLog(@"%@",url);
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  [manager GET:url parameters:nil success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
    
    NSLog(@"Status Code: %ld",operation.response.statusCode);
    NSLog(@"Response Object: %@",responseObject);
    NSArray *questions = [QuestionJSONParser questionsResultsFromJSON:responseObject];
    
    completionHandler(questions,nil);
    
  } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
    
    if (operation.response) {
      NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
      //
      //      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      //        completionHandler(nil,stackOverflowError);
      //      }]; SAME THING
      
      dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(nil,stackOverflowError);
      });
    } else {
      NSError *reachabilityError = [self checkReachability];
      if (reachabilityError) {
        completionHandler(nil, reachabilityError);
      }
    }
    
  }];
  
}

+(NSError *)checkReachability {
  if (![AFNetworkReachabilityManager sharedManager].reachable) {
    NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:StackOverFlowConnectionDown userInfo:@{NSLocalizedDescriptionKey : @"Could not connect to servers, please try again when you have a connection"}];
    return error;
  }
  return nil;
}

+(NSError *)errorForStatusCode:(NSInteger)statusCode {
  
  NSInteger errorCode;
  NSString *localizedDescription;
  
  switch (statusCode) {
    case 502:
      localizedDescription = @"Too many requests, please slow down";
      errorCode = StackOverFlowTooManyAttempts;
      break;
    case 400:
      localizedDescription = @"Invalid search term, try another search";
      errorCode = StackOverFlowInvalidParameter;
      break;
    case 401:
      localizedDescription = @"You must sign in to access this feature";
      errorCode = StackOverFlowNeedAuthentication;
      break;
    default:
      localizedDescription = @"Could not complete operation, please try again later";
      errorCode = StackOverFlowGeneralError;
      break;
  }
  NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey : localizedDescription}];
  return error;
}


@end
































