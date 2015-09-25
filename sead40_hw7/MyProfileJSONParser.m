//
//  MyProfileJSONParser.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/20/15.
//  Copyright © 2015 jalvestech. All rights reserved.
//

#import "MyProfileJSONParser.h"
#import "User.h"

@implementation MyProfileJSONParser

+(NSArray *)myProfileResultsFromJSON:(NSDictionary *)jsonInfo{
  
  //Array to store myProfile info
  NSMutableArray *myProfileInfo = [[NSMutableArray alloc]init];
  
  // Access the items array
  NSArray *items = jsonInfo[@"items"];
  
  //Parse items dictionary
  for (NSDictionary *item in items) {
    User *myProfile = [[User alloc] init];
    NSDictionary *owner = item[@"owner"];
    myProfile.username = owner[@"display_name"];
    myProfile.avatarURL = owner[@"profile_image"];
    myProfile.reputation = owner[@"reputation"];
    [myProfileInfo addObject:myProfile];
    
  }
  
  NSLog(@"Questions: %@",myProfileInfo);
  return myProfileInfo;
  
}

@end
