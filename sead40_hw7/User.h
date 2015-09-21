//
//  User.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

@property(strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *reputation;
@property(strong, nonatomic) UIImage *profileImage;

- (instancetype)initWithName:(NSString *)username avatarURL:(NSString *)avatarURL reputation:(NSString *)reputation profileImage:(UIImage *)profileImage;

@end
