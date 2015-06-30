//
//  DatabaseAccess.h
//  YumYuk
//
//  Created by Mauricio Narvaez on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DatabaseAccess : NSObject

//NOT USED IN APP, USED FOR MANAGING INITIAL DATA

//Temporary test method - adds items and polls them
+(void) testDatabase;

//Adds a new menu item with the specified parameters, setting their upvote/downvote
//counts to 0. Should only be called after all the restaurants are added.
+(void)addNewMenuItem:(NSString*)name
                 type:(NSString*)type
                 diet:(NSInteger)diet
           restaurant:(NSString *)restaurant;

//Adds the specified restaurant
+(void)addRestaurant:(NSString*)name code:(NSString*)code;

//Add methods

+(void)addCommentToMenuItem:(PFObject *)menuItem text:(NSString *)text;

//Get methods - all return arrays of PFObjects representing the pulled data

//Gets all of the menu items with the corresponding restaurant name
//and returns them in the items parameters of the block
+(void)getMenuItemsByRestaurant:(NSString*)name
                       callback:(void(^)(NSArray* items))callback;

//Gets a list of all the restaurants
+(void)getRestaurants:(void(^)(NSArray* items))callback;

//Gets list of all comments for particular menuItem
+(void)getCommentsForMenuItem:(PFObject *)menuItem callback:(void(^)(NSArray* items))callback;

@end
