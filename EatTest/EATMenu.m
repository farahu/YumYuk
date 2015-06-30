// Copyright 2004-present Facebook. All Rights Reserved.

#import "EATMenu.h"

#import "EATConsts.h"
#import "NSDate+EATDateUtil.h"

@implementation EATMenu

- (instancetype)initWithMenuCategory:(NSString *)category
                            mealType:(NSString *)mealType
                                date:(NSDate *)date
                            menuText:(NSString *)menuText
                              menuID:(int64_t)menuID
{
    self = [super init];
    if (self) {
        _category = category;
        _mealType = mealType;
        _date = date;
        _menuText = menuText;
        _menuID = menuID;
        
        NSDictionary *menuCategoryInfo = [[EATConsts menuCategoriesInfo] objectForKey:category];
        if ([menuCategoryInfo[kEATMenuCategoryInfoKeyIcon] length] > 0) {
            _cafeIcon = [UIImage imageNamed:menuCategoryInfo[kEATMenuCategoryInfoKeyIcon]];
        }
        
        _cafeName = menuCategoryInfo[kEATMenuCategoryInfoKeyDisplayName];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _category = [aDecoder decodeObjectForKey:@"category"];
        _mealType = [aDecoder decodeObjectForKey:@"mealType"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _menuText = [aDecoder decodeObjectForKey:@"menuText"];
        _menuID = [aDecoder decodeInt64ForKey:@"menuID"];
        
        NSDictionary *menuCategoryInfo = [[EATConsts menuCategoriesInfo] objectForKey:_category];
        if ([menuCategoryInfo[kEATMenuCategoryInfoKeyIcon] length] > 0) {
            _cafeIcon = [UIImage imageNamed:menuCategoryInfo[kEATMenuCategoryInfoKeyIcon]];
        }
        
        _cafeName = menuCategoryInfo[kEATMenuCategoryInfoKeyDisplayName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // If you change the way this object is encoded in any way, you MUST also bump the kEATDataVersion constant in
    // EATMenuStore.m, to prevent the app crashing for existing users that have cached data saved in older data
    // formats.
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.mealType forKey:@"mealType"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.menuText forKey:@"menuText"];
    [aCoder encodeInt64:self.menuID forKey:@"menuID"];
}

- (BOOL)isExpired
{
    NSDictionary *categoriesInfo = [EATConsts menuCategoriesInfo];
    NSDictionary *categoryInfo = categoriesInfo[self.category];
    NSInteger maxWorkingDaysToKeepMenus = [categoryInfo[kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus] integerValue];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    return [self.date eat_workdaysToDate:[NSDate date] timeZone:timeZone] > maxWorkingDaysToKeepMenus;
}

- (NSComparisonResult)dateDescendingCompare:(EATMenu *)menu
{
    // Note the order we compare the dates, to acheive a descending order.
    return [menu.date compare:self.date];
}

- (NSComparisonResult)categoryCompare:(EATMenu *)menu
{
    NSInteger a = [EATConsts indexOfCategory:self.category];
    NSInteger b = [EATConsts indexOfCategory:menu.category];
    
    if (a < b) {
        return NSOrderedAscending;
    } else if (a > b) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)nowServingOrderCompare:(EATMenu *)menu
{
    // Sort first by canonical category ordering.
    NSInteger a = [EATConsts indexOfCategoryInNowServing:self.category];
    NSInteger b = [EATConsts indexOfCategoryInNowServing:menu.category];
    
    if (a < b) {
        return NSOrderedAscending;
    } else if (a > b) {
        return NSOrderedDescending;
    } else {
        // Then sort descending by length of menu text.
        a = [self.menuText length];
        b = [menu.menuText length];
        
        if (a < b) {
            return NSOrderedDescending;
        } else if (a > b) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }
}

@end