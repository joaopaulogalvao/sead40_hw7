//
//  User.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "User.h"

@implementation User


-(instancetype)initWithName:(NSString *)username avatarURL:(NSString *)avatarURL reputation:(NSString *)reputation profileImage:(UIImage *)profileImage{
  
  if (self = [super init]) {
    _username = username;
    _avatarURL = avatarURL;
    _reputation = reputation;
    _profileImage = profileImage;
    
  }
  return self;
  
}

@end
