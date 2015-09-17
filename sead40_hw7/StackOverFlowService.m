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

@implementation StackOverFlowService

+ (void)questionsForSearchTerm:(NSString *)searchTerm completionHandler: (void(^)(NSArray*,NSError*))completionHandler {
  
  // paste the url here
//  NSString *url = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", searchTerm];
  NSString *url = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow",searchTerm];
  
  
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

@end
