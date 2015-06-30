//
//  RestaurantList.h
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestaurantViewController;
@class IndividualPageController;

@interface RestaurantList : NSObject
@property (nonatomic) NSArray *restaurants;
@property (nonatomic) NSArray *menuItems;

- (instancetype)init;
- (void) loadRestaurants:(RestaurantViewController*)controller;
- (void) loadMenu:(IndividualPageController *)controller withRestList:(RestaurantList *)rest andRestaurant:(NSInteger)selectedRestaurant;
@end
