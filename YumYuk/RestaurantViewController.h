//
//  RestaurantsViewControllerTableViewController.h
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RestaurantList;

@interface RestaurantViewController : UITableViewController
- (instancetype)initWithRestaurants:(RestaurantList *)restaurantList;
@end
