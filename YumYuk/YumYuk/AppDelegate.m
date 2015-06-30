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

#import "DatabaseAccess.h"
#import "YYConstants.h"

#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Check for existing user id
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
    
    //Initialize Parse
    [Parse setApplicationId:@"j3XsWst6pkPupgDUs50LIMneCjL1lVaWua0ZqjkZ"
                  clientKey:@"8PoXXIBqC1XvPHnZtuBSx1HqnTV3FJ6FTruajczW"];
    
    //TEMPORARY -- test that adds things to the server then downloads them and logs them
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     //   [DatabaseAccess testDatabase];
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

    //Initialize Parse
    [Parse setApplicationId:@"j3XsWst6pkPupgDUs50LIMneCjL1lVaWua0ZqjkZ"
                  clientKey:@"8PoXXIBqC1XvPHnZtuBSx1HqnTV3FJ6FTruajczW"];
    
    
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
        
        // use parse to upload the storage data
        [Restaurant parseMenus:restaurantStorage];
        
    }];


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
@end
