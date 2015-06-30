//
//  DatabaseAccess.m
//  YumYuk
//
//  Created by Mauricio Narvaez on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "DatabaseAccess.h"
#import <Parse/Parse.h>

@implementation DatabaseAccess

NSString* const CLASSNAME_MENU_ITEM = @"MenuItem";
NSString* const CLASSNAME_RESTAURANT = @"Restaurant";

NSString* const KEY_NAME = @"name";
NSString* const KEY_TYPE = @"type";
NSString* const KEY_DIET = @"diet";
NSString* const KEY_UPVOTES = @"upvotes";
NSString* const KEY_DOWNVOTES = @"downvotes";
NSString* const KEY_RESTAURANT = @"restaurant";
NSString* const KEY_CODE = @"code";

+(void) testDatabase {
    NSLog(@"Testing");
    [DatabaseAccess addRestaurant:@"Living the Dream" code:@"ltd"];
    [DatabaseAccess addRestaurant:@"Epic Cafe" code:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Pizza" type:@"Entree" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Burger" type:@"Entree" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Water" type:@"Drink" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Soda" type:@"Drink" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Hotdog" type:@"Entree" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Carrots" type:@"Side" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Tofu" type:@"Side" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Gluten Free Water" type:@"Drink" diet:2 restaurant:@"epic"];
    
    
    [DatabaseAccess getRestaurants:^(NSArray *items) {
        for(PFObject *restaurant in items){
            [DatabaseAccess getMenuItemsByRestaurant:restaurant[KEY_CODE] callback:^(NSArray *items) {
                NSLog(@"%@", restaurant[KEY_NAME]);
                for (PFObject *item in items) {
                    NSLog(@"%@", item[@"name"]);
                }
            }];
        }
    }];
}

+(void) addNewMenuItem:(NSString *)name type:(NSString *)type diet:(int)diet
            restaurant:(NSString *)restaurant {
    //Create initial object
    PFObject *menuItem = [PFObject objectWithClassName:CLASSNAME_MENU_ITEM];

    //Set properties
    menuItem[KEY_NAME] = name;
    menuItem[KEY_TYPE] = type;
    menuItem[KEY_DIET] = @(diet);
    menuItem[KEY_UPVOTES] = @(0);
    menuItem[KEY_DOWNVOTES] = @(0);
    menuItem[KEY_RESTAURANT] = restaurant;
    
    NSError *error = nil;
    //Save to database
    [menuItem save:&error];
    if(error){
        NSLog(@"ERROR: %@", error);
    }
}

+(void) addRestaurant:(NSString *)name code:(NSString *)code{
    //Create initial object
    PFObject *restaurant = [PFObject objectWithClassName:CLASSNAME_RESTAURANT];
    
    //Set properties
    restaurant[KEY_NAME] = name;
    restaurant[KEY_CODE] = code;
    
    NSError *error = nil;
    //Save to database
    [restaurant save:&error];
    if(error){
        NSLog(@"ERROR: %@", error);
    }
}

+(void) getMenuItemsByRestaurant:(NSString *)code callback:(void (^)(NSArray *))callback {
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_MENU_ITEM];
    [query whereKey:KEY_RESTAURANT equalTo:code];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        if(items){
            callback(items);
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

+(void) getRestaurants:(void (^)(NSArray *))callback {
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_RESTAURANT];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        if(items){
            callback(items);
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
