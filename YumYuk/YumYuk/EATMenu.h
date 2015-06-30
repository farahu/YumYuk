// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @class     EATMenu
 @abstract  An immutable object representing a single menu for a particular cafe.
 */
@interface EATMenu : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *category;
@property (nonatomic, readonly) NSString *cafeName;
@property (nonatomic, readonly) UIImage *cafeIcon;
@property (nonatomic, readonly) NSString *mealType;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, copy) NSString *menuText;
@property (nonatomic, readonly) int64_t menuID;// deleted the readOnly property

- (instancetype)initWithMenuCategory:(NSString *)category
                            mealType:(NSString *)mealType
                                date:(NSDate *)date
                            menuText:(NSString *)menuText
                              menuID:(int64_t)menuID;

// MARK: - (BOOL)isExpired;
- (NSComparisonResult)dateDescendingCompare:(EATMenu *)menu;
- (NSComparisonResult)categoryCompare:(EATMenu *)menu;
- (NSComparisonResult)nowServingOrderCompare:(EATMenu *)menu;

@end