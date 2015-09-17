//
//  Errors.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/16/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Errors : NSObject

extern NSString *const kStackOverFlowErrorDomain;

typedef enum : NSUInteger {
  StackOverFlowBadJSON = 200,
  StackOverFlowConnectionDown,
  StackOverFlowTooManyAttempts,
  StackOverFlowInvalidParameter,
  StackOverFlowNeedAuthentication,
  StackOverFlowGeneralError
} StackOverFlowErrorCodes;

@end
