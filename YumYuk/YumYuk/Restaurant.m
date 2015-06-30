//
//  Restaurant.m
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "Restaurant.h"
#import "MenuItem.h"
#import "EATMenu.h"

#import <Parse/Parse.h>

@implementation Restaurant

+ (NSMutableSet *) processMenu: (NSString *) menuText
{
    NSMutableSet *d = [[NSMutableSet alloc] init];
    
    // processing rules:
    // 1. if line starts with "(", ""
    
    
    [d addObject: @"duah"];
    return d;
}

// [restaurant[menuItem]]
+ (NSMutableSet *) storeMenus: (NSArray *) menus
{
    NSMutableSet *store = [[NSMutableSet alloc] init];
    NSMutableSet *rest = [[NSMutableSet alloc] init];
    NSMutableSet *tempDishes = [[NSMutableSet alloc] init];
    MenuItem *temp = nil;
    Restaurant *resTemp = nil;
    for (EATMenu *menu in menus) {
        // for one restaurant, process its dishes
        tempDishes = [Restaurant processMenu:menu.menuText];
        
        // make menu items and store them in array called rest under
        // the name of this restaurant
        for (NSString *d in tempDishes) {
            temp = [[MenuItem alloc ]initWithDishName: d restaurant: menu.cafeName];
            [rest addObject:temp];
        }
        // create restaurant object for this restaurant
        resTemp = [[Restaurant alloc] initWithRestaurant:menu.cafeName menuItems:rest];
        // store this restaurant array inside final big store
        [store addObject:resTemp];
        
    }
    NSLog(@"%@", store);
    for (Restaurant *r in store) {
        NSLog(@"%@", r.restaurantName);
        NSLog(@"%@", r.dishes);
    }
    return store;
}

// [restaurant[menuItem]]
// MARK: - unfinished!!
+ (void) parseMenus: (NSMutableSet *) store
{
    return;
}

- (instancetype) initWithRestaurant: (NSString *) resName menuItems: (NSMutableSet *) d
{
    self = [super init];
    if (self) {
        
        _restaurantName = resName;
        _dishes = d;
    }
    return self;
}

@end
