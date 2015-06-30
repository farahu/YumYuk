//
//  AppDelegate.m
//  YumYuk
//
//  Created by Farah Uraizee on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "AppDelegate.h"
#import "RestaurantViewController.h"
#import "RestaurantList.h"

#import "Restaurant.h"

#import <Parse/Parse.h>

#import "EATMenuParser.h"
#import "EATMenu.h"
#import "EATMenuDownloader.h"
#import "MenuItem.h"

#import "DatabaseAccess.h"
#import "YYConstants.h"

#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setUserID];
    //Initialize Parse
    [Parse setApplicationId:@"j3XsWst6pkPupgDUs50LIMneCjL1lVaWua0ZqjkZ"
                  clientKey:@"8PoXXIBqC1XvPHnZtuBSx1HqnTV3FJ6FTruajczW"];
    
    //TEMPORARY -- test that adds things to the server then downloads them and logs them
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //   [DatabaseAccess testDatabase];
        [self downloadMPKEatsData];
    });
    
    // Create an item store
    RestaurantList *restaurants = [[RestaurantList alloc] init];
    
    // Create a RestaurantViewController
    RestaurantViewController *rvc = [[RestaurantViewController alloc] initWithRestaurants:restaurants];
    [restaurants loadRestaurants:rvc];
    
    // Create the navigation controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rvc];
    
    // Use nav controller as the top-level view controller
    self.window.rootViewController = navController;
    
    return YES;
}

-(void)setUserID{
    NSString *userId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"userId"];
    if(userId){
        NSLog(@"Found userId: %@", userId);
    } else {
        userId = [[NSUUID UUID] UUIDString];
        NSLog(@"No existing user, adding new: %@", userId);
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    USER_ID = userId;
}

-(void)downloadMPKEatsData {
    //get MPKEats content to our app
    EATMenuDownloader *down = [[EATMenuDownloader alloc] init];
    __block NSMutableArray *menus = nil;
    [down downloadCurrentMenus:^(NSArray *menuss, NSError *error) {
        if (!menuss) {
            NSLog(@"ERROR: %@", error);
            return;
        }
        
        menus = [[NSMutableArray alloc] init];
        for (EATMenu *menu in menuss) {
            if (![menu.cafeName containsString:@"Sweet"]) {
                [menus addObject:menu];
            }
        }

        // for testing
        for (EATMenu *menu in menus) {
            NSLog(@"%@", menu.cafeName);
        }
        
        // get the restaurant storage
        NSMutableSet *restaurantStorage = [[NSMutableSet alloc] init];
        restaurantStorage = [Restaurant storeMenus:menus];
        
        for (Restaurant *res in restaurantStorage) {
            for (MenuItem *dish in res.dishes) {
                [DatabaseAccess addNewMenuItem:dish.dishName
                                          type:dish.type
                                          diet:dish.diet
                                    restaurant:dish.restaurantName
                                        menuID:dish.menuID];
            }
            [DatabaseAccess addRestaurant:res.restaurantName code:res.mealType];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
