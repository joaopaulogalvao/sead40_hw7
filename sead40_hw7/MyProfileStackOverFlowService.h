//
//  MyProfileStackOverFlowService.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/20/15.
//  Copyright © 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfileStackOverFlowService : NSObject

+ (void)myProfileInfo: (void(^)(NSArray*,NSError*))completionHandler;

@end
