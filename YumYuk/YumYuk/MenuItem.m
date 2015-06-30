//
//  MenuItem.m
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "MenuItem.h"

 
 





@implementation MenuItem


// MARK: - method for parse protocol


- (instancetype) initWithDishName: (NSString *) dName restaurant: (NSString *) resName
{
    self = [super init];
    if (self) {
        self.dishName = dName;
        self.restaurantName = resName;
        
        // default settings
        self.upvotes = 0;
        self.downvotes = 0;
        self.type = @""; // MARK: - what is type n diet?
        self.diet = 1; // default for now
        
    }
    return self;
}

@end
