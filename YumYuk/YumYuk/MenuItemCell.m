//
//  MenuItemCell.m
//  YumYuk
//
//  Created by Kristina Liang on 6/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "MenuItemCell.h"
#import "DatabaseAccess.h"
#import "YYConstants.h"

@interface MenuItemCell()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNoLabel;
@end

@implementation MenuItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upvoteTapped:(id)sender {
    [DatabaseAccess upvoteMenuItem:self.item];
    [self updateScore];
}
- (IBAction)downvoteTapped:(id)sender {
    [DatabaseAccess downvoteMenuItem:self.item];
    [self updateScore];
}
- (void) updateScore {
    int score = [self.item[KEY_UPVOTES] intValue] - [self.item[KEY_DOWNVOTES] intValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
}
@end
