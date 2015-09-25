//
//  MyQuestionsJSONParser.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQuestionsJSONParser : NSObject

+(NSArray *)myQuestionsResultsFromJSON:(NSDictionary *)jsonInfo;

@end
