//
//  RestaurantsViewControllerTableViewController.m
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "RestaurantViewController.h"
#import "RestaurantViewCell.h"
#import "RestaurantList.h"

@interface RestaurantViewController ()
@property (nonatomic) RestaurantList *listOfRestaurants;
@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the restaurantViewCell nib
    UINib *restaurantNib = [UINib nibWithNibName:@"RestaurantViewCell" bundle:nil];
    
    // Register this nib as the template for new cells
    [self.tableView registerNib:restaurantNib forCellReuseIdentifier:@"RestaurantViewCell"];
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
    return self.listOfRestaurants.restaurants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantViewCell" forIndexPath:indexPath];
    NSString *rList = self.listOfRestaurants.restaurants[indexPath.row];
    cell.restaurantName.text = rList;
    return cell;
}

- (instancetype)initWithRestaurants:(RestaurantList *)restaurantList {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.listOfRestaurants = restaurantList;
        self.navigationItem.title = @"YUMYUK";
     
    }
    return self;
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
