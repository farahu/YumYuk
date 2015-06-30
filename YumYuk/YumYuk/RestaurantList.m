//
//  RestaurantList.m
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "RestaurantList.h"

@implementation RestaurantList

- (instancetype)init {
    self = [super init];
    if (self) {
        self.restaurants = [NSMutableArray arrayWithObjects:@"epic", @"ltd", nil];
    }
    return self;
}


@end

