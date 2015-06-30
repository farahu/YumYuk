//
//  DatabaseAccess.h
//  YumYuk
//
//  Created by Mauricio Narvaez on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseAccess : NSObject

//Temporary test method - adds items and polls them
+(void) testDatabase;

//Adds a new menu item with the specified parameters, setting their upvote/downvote
//counts to 0. Should only be called after all the restaurants are added.
+(void)addNewMenuItem:(NSString*)name
                 type:(NSString*)type
                 diet:(int)diet
           restaurant:(NSString *)restaurant;

//Adds the specified restaurant
+(void)addRestaurant:(NSString*)name code:(NSString*)code;

//Gets all of the menu items with the corresponding restaurant name
//and returns them in the items parameters of the block, which is an
//array of PGObjects
+(void)getMenuItemsByRestaurant:(NSString*)code
                       callback:(void(^)(NSArray* items))callback;

//Gets a list of all the restaurants
+(void)getRestaurants:(void(^)(NSArray* items))callback;

@end
