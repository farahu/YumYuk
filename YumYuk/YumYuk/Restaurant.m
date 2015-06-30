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
#import "EATConsts.h"
#import <Parse/Parse.h>

@implementation Restaurant

+ (NSMutableSet *) processMenu: (NSString *) menuText
{
    NSMutableSet *menuItems = [[NSMutableSet alloc] init];
    
    // break up data by break lines
    NSMutableArray *data = [[menuText componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    
    for (NSString *name in data) {
        // start at a category name, skip over Enjoy/Sides
        if ([[EATConsts categoryNames] containsObject:name] && !([name isEqualToString:@"~Enjoy~"] || [name isEqualToString:@"Enjoy!"] || [name isEqualToString:@"Sides"])) {
            NSUInteger index = [data indexOfObject:name];
            if ([name isEqualToString:@"Boba Tea Menu:"]) {
                index += 2;
            }
            
            // make sure next item is not out of bounds, stop going through items if it's another category or if it's a special message indicated by +++
            while (((index + 1) < data.count) && ![[EATConsts categoryNames] containsObject:[data objectAtIndex:(index+1)]] && ![[data objectAtIndex:(index+1)] containsString:@"+++"]) {
                index++;
                NSString *text = [data objectAtIndex:index];
                NSString *menuItem = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                // special case: Full Circle includes ingredients of their smoothies... we don't want this
                if (!([name isEqualToString:@"(Smoothie/Juice)"] && [menuItem containsString:@"("]) && !([menuItem isEqualToString:@""])) {
                    NSLog(@"this is menu item: %@", menuItem);
                    [menuItems addObject:menuItem]; // add the menu item
                }
                
            }
        }
    }
    
    return menuItems;
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
        resTemp = [[Restaurant alloc] initWithRestaurant:menu.cafeName menuItems:rest menuType:menu.mealType];
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



- (instancetype) initWithRestaurant: (NSString *) resName
                          menuItems: (NSMutableSet *) d
                            menuType:(NSString *)mType
{
    self = [super init];
    if (self) {
        
        _restaurantName = resName;
        _dishes = d;
        _mealType = mType;
        
    }
    return self;
}

@end
