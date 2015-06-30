//
//  MenuItem.h
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *dishName; // MARK: -weak or not?
@property (nonatomic, assign) NSInteger upvotes;
@property (nonatomic, assign) NSInteger downvotes;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger diet;
@property (nonatomic, copy) NSString *restaurantName;


- (instancetype) initWithDishName: (NSString *) dName restaurant: (NSString *) resName NS_DESIGNATED_INITIALIZER;
@end
