//
//  StackOverFlowService.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverFlowService : NSObject

+ (void)questionsForSearchTerm:(NSString *)searchTerm completionHandler: (void(^)(NSArray*,NSError*))completionHandler;

@end
