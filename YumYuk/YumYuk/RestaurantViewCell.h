//
//  RestaurantViewCell.h
//  YumYuk
//
//  Created by Kristina Liang on 6/29/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantIcon;
@property (weak, nonatomic) IBOutlet UILabel *restaurantScore;

@end
