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
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
