//
//  MenuItem.m
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem


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
        self.diet = [self getDiet:self.dishName];
        
    }
    return self;
}

- (NSUInteger) getDiet: (NSString *) dName {
    NSUInteger diet = 0;
    if ([dName containsString:@"**"]) {
        diet = 2;
    } else if ([dName containsString:@"*"]) {
        diet = 1;
    }
    
    return diet;
}
@end
