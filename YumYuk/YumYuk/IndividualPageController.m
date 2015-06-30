//
//  IndividualPageControllerTableViewController.m
//  YumYuk
//
//  Created by Kristina Liang on 6/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "IndividualPageController.h"
#import "RestaurantList.h"
#import <Parse/Parse.h>
#import "DatabaseAccess.h"
#import "YYConstants.h"
#import "MenuItemCell.h"
#import "CommentViewController.h"

@interface IndividualPageController ()
@property (nonatomic) RestaurantList *listOfRestaurants;
@property (nonatomic) NSInteger restIndex;

@end

@implementation IndividualPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the restaurantViewCell nib
    UINib *menuNib = [UINib nibWithNibName:@"MenuItemCell" bundle:nil];
    
    // Register this nib as the template for new cells
    [self.tableView registerNib:menuNib forCellReuseIdentifier:@"MenuItemCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listOfRestaurants.menuItems.count;
}

- (instancetype)initWithRestaurantList:(RestaurantList *)rest atIndex:(NSInteger)rIndex {
    self = [super init];
    if (self) {
        self.listOfRestaurants = rest;
        self.restIndex = rIndex;
        NSString *rName = self.listOfRestaurants.restaurants[_restIndex][KEY_NAME];
        self.navigationItem.title = rName;
      
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell" forIndexPath:indexPath];
    NSString *menuItem = self.listOfRestaurants.menuItems[indexPath.row][KEY_NAME];
    cell.menuItem.text = menuItem;
    cell.item = self.listOfRestaurants.menuItems[indexPath.row];
    [cell updateScore];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[DatabaseAccess addCommentToMenuItem:self.listOfRestaurants.menuItems[indexPath.row] text:@"This is great!"];
    // Create the individual page view controller
    CommentViewController *cpc = [[CommentViewController alloc] initWithMenuItem:self.listOfRestaurants.menuItems[indexPath.row] andRestaurant:self.listOfRestaurants];
    [self.listOfRestaurants loadComments:cpc forMenuItem:self.listOfRestaurants.menuItems[indexPath.row]];
    // Push this onto the navigation stack
    [self showViewController:cpc sender:self];
    
}

@end
