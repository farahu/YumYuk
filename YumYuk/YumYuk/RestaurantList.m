//
//  RestaurantList.m
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "RestaurantList.h"
#import "DatabaseAccess.h"
#import "RestaurantViewController.h"

@implementation RestaurantList

- (instancetype)init {
    self = [super init];
    if (self) {
        self.restaurants = [NSArray array];
    }
    return self;
}

-(void) loadRestaurants:(RestaurantViewController*)controller {
    [DatabaseAccess getRestaurants:^(NSArray *items) {
        self.restaurants = items;
        [controller.tableView reloadData];
    }];
}


@end

