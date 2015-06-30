//
//  RestaurantList.h
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestaurantViewController;

@interface RestaurantList : NSObject
@property (nonatomic) NSArray *restaurants;

- (instancetype)init;
- (void) loadRestaurants:(RestaurantViewController*)controller;

@end
