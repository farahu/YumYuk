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

+(void) addNewMenuItem:(NSString *)name type:(NSString *)type diet:(int)diet
            restaurant:(NSString *)restaurant callback:(void (^)())callback {
    //Create initial object
    PFObject *menuItem = [PFObject objectWithClassName:CLASSNAME_MENU_ITEM];

    //Set properties
    menuItem[KEY_NAME] = name;
    menuItem[KEY_TYPE] = type;
    menuItem[KEY_DIET] = @(diet);
    menuItem[KEY_UPVOTES] = 0;
    menuItem[KEY_DOWNVOTES] = 0;
    menuItem[KEY_RESTAURANT] = restaurant;
    
    //Save to database
    [menuItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
         if (succeeded) {
             callback();
         } else {
             NSLog(@"Error: %@", error);
         }
    }];
}

+(void) addRestaurant:(NSString *)name callback:(void (^)())callback {
    //Create initial object
    PFObject *restaurant = [PFObject objectWithClassName:CLASSNAME_RESTAURANT];
    
    //Set properties
    restaurant[KEY_NAME] = name;

    //Save to database
    [restaurant saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            callback();
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
