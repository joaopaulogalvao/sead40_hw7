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
  NSString *url = @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=swift&site=stackoverflow";
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  [manager GET:url parameters:nil success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
    
    NSLog(@"%ld",operation.response.statusCode);
    NSLog(@"%@",responseObject);
    NSArray *questions = [QuestionJSONParser questionsResultsFromJSON:responseObject];
    
    completionHandler(questions,nil);
    
  } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
    
  }];
  
}

@end
