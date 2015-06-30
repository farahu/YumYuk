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

+(void) testDatabase {
    NSLog(@"Testing");
    [DatabaseAccess addRestaurant:@"ltd"];
    [DatabaseAccess addRestaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Pizza" type:@"Entree" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Burger" type:@"Entree" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Water" type:@"Drink" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Soda" type:@"Drink" diet:0 restaurant:@"ltd"];
    [DatabaseAccess addNewMenuItem:@"Hotdog" type:@"Entree" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Carrots" type:@"Side" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Tofu" type:@"Side" diet:0 restaurant:@"epic"];
    [DatabaseAccess addNewMenuItem:@"Gluten Free Water" type:@"Drink" diet:2 restaurant:@"epic"];
    
    [DatabaseAccess getMenuItemsByRestaurant:@"epic" callback:^(NSArray *items) {
        NSLog(@"EPIC FOOD:");
        for (PFObject *item in items) {
            NSLog(@"%@", item[@"name"]);
        }
    }];
    
    [DatabaseAccess getMenuItemsByRestaurant:@"ltd" callback:^(NSArray *items) {
        NSLog(@"LTD FOOD:");
        for (PFObject *item in items) {
            NSLog(@"%@", item[@"name"]);
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
    
    //Save to database
    [menuItem save];
}

+(void) addRestaurant:(NSString *)name {
    //Create initial object
    PFObject *restaurant = [PFObject objectWithClassName:CLASSNAME_RESTAURANT];
    
    //Set properties
    restaurant[KEY_NAME] = name;
    
    //Save to database
    [restaurant save];
}

+(void) getMenuItemsByRestaurant:(NSString *)name callback:(void (^)(NSArray *))callback {
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_MENU_ITEM];
    [query whereKey:KEY_RESTAURANT equalTo:name];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        if(items){
            callback(items);
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}
@end
