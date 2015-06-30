//
//  RestaurantList.h
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class RestaurantViewController;
@class IndividualPageController;
@class CommentViewController;

@interface RestaurantList : NSObject
@property (nonatomic) NSArray *restaurants;
@property (nonatomic) NSArray *menuItems;
@property (nonatomic) NSArray *menuComments;

- (instancetype)init;
- (void) loadRestaurants:(RestaurantViewController*)controller;
- (void) loadMenu:(IndividualPageController *)controller withRestList:(RestaurantList *)rest andRestaurant:(NSInteger)selectedRestaurant;
- (void) loadComments:(CommentViewController *)controller forMenuItem:(PFObject *)item;
@end
