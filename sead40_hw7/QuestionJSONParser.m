//
//  QuestionJSONParser.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/16/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "QuestionJSONParser.h"
#import "Question.h"

@implementation QuestionJSONParser

+(NSArray *)questionsResultsFromJSON: (NSDictionary *)jsonInfo {
  
  //Array to store questions
  NSMutableArray *questions = [[NSMutableArray alloc]init];
  
  // Access the items array
  NSArray *items = jsonInfo[@"items"];
  
  //Parse items dictionary
  for (NSDictionary *item in items) {
    Question *question = [[Question alloc] init];
    question.title = item[@"title"];
    NSDictionary *owner = item[@"owner"];
    question.ownerName = item[@"display_name"];
    question.avatarURL = owner[@"profile_image"];
    [questions addObject:question];
    
  }
  
  NSLog(@"Questions: %@",questions);
  return questions;
}

@end
