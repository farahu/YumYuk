//
//  Restaurant.h
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, copy) NSString *restaurantName;
@property (nonatomic, copy) NSSet *dishes;
@property (nonatomic, copy) NSString *mealType;

/**
 * This is to go through the array of EATMenu items, create our own MenuItems and store them with appropriate restaurant; return an array of restaurants
 */
+ (NSMutableSet *) storeMenus: (NSArray *) menus;


/**
 * This is to create restaurants with restaurant name and a list of menuItems under this restaurant
 */
- (instancetype) initWithRestaurant: (NSString *) resName
                          menuItems: (NSMutableSet *) d
                           menuType: (NSString *) mType NS_DESIGNATED_INITIALIZER;



@end
