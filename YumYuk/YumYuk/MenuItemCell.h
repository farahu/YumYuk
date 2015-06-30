//
//  MenuItemCell.h
//  YumYuk
//
//  Created by Kristina Liang on 6/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuItem;
@property (weak, nonatomic) IBOutlet UILabel *itemScore;
@property (weak, nonatomic) IBOutlet UIButton *upvote;
@property (weak, nonatomic) IBOutlet UIButton *downvote;
@property (weak, nonatomic) IBOutlet UIButton *comments;
@property (weak, nonatomic) IBOutlet UILabel *numberOfComments;

@end
