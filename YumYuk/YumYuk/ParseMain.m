//
//  ParseMain.m
//  YumYuk
//
//  Created by Zhixian Li on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EATMenuParser.h"
#import "EATMenu.h"
#import "EATMenuDownloader.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        EATMenuDownloader *down = [[EATMenuDownloader alloc] init];
        __block NSArray *menus = nil;
        [down downloadCurrentMenus:^(NSArray *menuss, NSError *error) {
            menus = menuss;
            if (!menus) {
                NSLog(@"ERROR: %@", error);
                return;
            }
            NSLog(@"%@", menus);
            //every code goes inside
            
            //
            
            
            
            
            
            
            
            
            
            
            
            
            
        }];
        
    }
    return 0;
}

