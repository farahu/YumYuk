//
//  IndividualPageControllerTableViewController.h
//  YumYuk
//
//  Created by Kristina Liang on 6/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RestaurantList;

@interface IndividualPageController : UITableViewController

- (instancetype)initWithRestaurantList:(RestaurantList *)rest atIndex:(NSInteger)rIndex;

@end
