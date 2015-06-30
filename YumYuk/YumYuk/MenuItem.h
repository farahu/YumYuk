//
//  MenuItem.h
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *dishName; // weak or not?
@property (nonatomic, assign) NSInteger upvotes;
@property (nonatomic, assign) NSInteger downvotes;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger diet;
@property (nonatomic, copy) NSString *restaurantName;

@end
