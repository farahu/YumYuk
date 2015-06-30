//
//  DatabaseAccess.m
//  YumYuk
//
//  Created by Mauricio Narvaez on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "DatabaseAccess.h"
#import <Parse/Parse.h>
#import "YYConstants.h"

@implementation DatabaseAccess

//TEMP METHODS

/*
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
                    NSLog(@"%@", item[KEY_NAME]);
                }
            }];
        }
    }];
}
 
 */

+(void) addNewMenuItem:(NSString *)name type:(NSString *)type diet:(NSInteger)diet
            restaurant:(NSString *)restaurant menuID:(int64_t)menuID {
    
    
    //Check if will be duplicate
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_MENU_ITEM];
    [query whereKey:KEY_MENUID equalTo:@(menuID)];
    NSArray *array = [query findObjects];
    
    if ([array count] != 0) {
        return;
    }
    
    //Create initial object
    PFObject *menuItem = [PFObject objectWithClassName:CLASSNAME_MENU_ITEM];
    
    //Set properties
    menuItem[KEY_NAME] = name;
    menuItem[KEY_TYPE] = type;
    menuItem[KEY_DIET] = @(diet);
    menuItem[KEY_UPVOTES] = @(0);
    menuItem[KEY_DOWNVOTES] = @(0);
    menuItem[KEY_RESTAURANT] = restaurant;
    menuItem[KEY_MENUID] = @(menuID);
    
    NSError *error = nil;
    //Save to database
    [menuItem save:&error];
    if(error){
        NSLog(@"ERROR: %@", error);
    }

    
}

+(void) addRestaurant:(NSString *)name code:(NSString *)code {
    
    //Check if will be duplicate
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_RESTAURANT];
    [query whereKey:KEY_MENUID equalTo:name];
    NSArray *array = [query findObjects];
    
    if ([array count] != 0) {
        return;
    }
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

//ADD METHODS

+(void) addCommentToMenuItem:(PFObject *)menuItem text:(NSString *)text {
    //Create initial object
    PFObject *comment = [PFObject objectWithClassName:CLASSNAME_COMMENT];
    
    //Set properties
    comment[KEY_PARENT] = menuItem;
    comment[KEY_USER] = USER_ID;
    comment[KEY_UPVOTES] = @(0);
    comment[KEY_DOWNVOTES] = @(0);
    comment[KEY_TEXT] = text;
    
    //Save
    [comment saveInBackground];
}

//GET METHODS

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

+(void) getCommentsForMenuItem:(PFObject *)menuItem callback:(void (^)(NSArray *))callback {
    PFQuery *query = [PFQuery queryWithClassName:CLASSNAME_COMMENT];
    [query whereKey:KEY_PARENT equalTo:menuItem];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        if(items){
            callback(items);
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
