//
//  MyQuestionsJSONParser.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MyQuestionsJSONParser.h"
#import "Question.h"

@implementation MyQuestionsJSONParser

+(NSArray *)myQuestionsResultsFromJSON:(NSDictionary *)jsonInfo{
  
  //Array to store questions
  NSMutableArray *myQuestions = [[NSMutableArray alloc]init];
  
  // Access the items array
  NSArray *items = jsonInfo[@"items"];
  
  //Parse items dictionary
  for (NSDictionary *item in items) {
    Question *myQuestion = [[Question alloc] init];
    myQuestion.title = item[@"title"];
    NSDictionary *owner = item[@"owner"];
    myQuestion.ownerName = owner[@"display_name"];
    myQuestion.avatarURL = owner[@"profile_image"];
    [myQuestions addObject:myQuestion];
    
  }
  
  NSLog(@"Questions: %@",myQuestions);
  return myQuestions;
  
  
}

@end
