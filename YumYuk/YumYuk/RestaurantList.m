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
#import "IndividualPageController.h"
#import "YYConstants.h"
#import "CommentViewController.h"

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

- (void) loadMenu:(IndividualPageController *)controller withRestList:(RestaurantList *)rest andRestaurant:(NSInteger)selectedRestaurant {
    PFObject *restaurant = rest.restaurants[selectedRestaurant];
    [DatabaseAccess getMenuItemsByRestaurant:restaurant[KEY_NAME] callback:^(NSArray *items) {
        self.menuItems = items;
        [controller.tableView reloadData];        
    }];
}

- (void) loadComments:(CommentViewController *)controller forMenuItem:(PFObject *)item {
    [DatabaseAccess getCommentsForMenuItem:item callback:^(NSArray *comments){
        self.menuComments = comments;
        [controller.tableView reloadData];
    }];
}
@end

