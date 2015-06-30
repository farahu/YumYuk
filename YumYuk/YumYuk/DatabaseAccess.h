//
//  DatabaseAccess.h
//  YumYuk
//
//  Created by Mauricio Narvaez on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseAccess : NSObject

//Adds a new menu item with the specified parameters, setting their upvote/downvote
//counts to 0. Should only be called after all the restaurants are added.
+(void)addNewMenuItem:(NSString*)name
                 type:(NSString*)type
                 diet:(int)diet
           restaurant:(NSString *)restaurant
             callback:(void(^)())callback;

//Adds the specified restaurant
+(void)addRestaurant:(NSString*)name
            callback:(void(^)())callback;

@end
