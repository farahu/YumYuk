//
//  CommentViewController.h
//  YumYuk
//
//  Created by Kristina Liang on 6/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CommentViewController : UITableViewController
- (instancetype)initWithMenuItem:(PFObject *)menuItem;
@end
