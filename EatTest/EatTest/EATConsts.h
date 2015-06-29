
// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>

static NSString *const kEATAppID = @"218433435033593";
static NSString *const kEATAppSecret = @"Wpl2ypoMuJMld8IFudUhhXdZBS0";
static NSString *const kEATAccessToken = @"218433435033593|Wpl2ypoMuJMld8IFudUhhXdZBS0";
static NSString *const kEATAppVersion = @"1.0";
static NSString *const kEATDeviceID = @"";
static NSString *const kEATUserID = @"";

static NSString *const kEATParseApplicationId = @"PWknWUFJHf8GbS5NeqNI5a9AARkRRqam47lgNFxd";
static NSString *const kEATParseClientKey = @"miOy6wxphK1DhDVG1wc6QA6qosMNb1Db5bRiRtmE";

static NSString *const kEATMenuCategoryNowServing = @"now_serving";
static NSString *const kEATMenuCategoryCafeEpic = @"cafe_epic";
static NSString *const kEATMenuCategoryCafeLTD = @"cafe_ltd";
static NSString *const kEATMenuCategoryCafeFullCircle = @"cafe_full_circle";
static NSString *const kEATMenuCategoryChosHawker = @"chos_hawker";
static NSString *const kEATMenuCategorySweetStop = @"sweet_stop";
static NSString *const kEATMenuCategoryHackerSquare = @"hacker_square";
static NSString *const kEATMenuCategoryBurgerShack = @"burger_shack";
static NSString *const kEATMenuCategoryBBQShack = @"bbq_shack";
static NSString *const kEATMenuCategoryHarvest = @"harvest";
static NSString *const kEATMenuCategoryPizzeria = @"pizzeria";
static NSString *const kEATMenuCategoryNachoRoyale = @"nacho_royale";
static NSString *const kEATMenuCategoryNoodleBar = @"noodle_bar";
static NSString *const kEATMenuCategoryMamaPennys = @"mama_pennys";
static NSString *const kEATMenuCategoryOther = @"other";

static NSString *const kEATMenuCategoryInfoKeyDisplayName = @"display_name";
static NSString *const kEATMenuCategoryInfoKeyIcon = @"icon";
static NSString *const kEATMenuCategoryInfoKeyIconArray = @"icon_array";
static NSString *const kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus = @"max_working_days_to_keep_menus";
static NSString *const kEATMenuCategoryInfoKeyShowHours = @"show_hours";

static NSString *const kEATMealTypeBreakfast = @"Breakfast";
static NSString *const kEATMealTypeLunch = @"Lunch";
static NSString *const kEATMealTypeDinner = @"Dinner";
static NSString *const kEATMealTypeHappyHour = @"Happy Hour";
static NSString *const kEATMealTypeDessert = @"Dessert";

@interface EATConsts : NSObject

+ (NSArray *)menuCategories;
+ (NSInteger)indexOfCategory:(NSString *)category;
+ (NSInteger)indexOfCategoryInNowServing:(NSString *)category;
+ (NSDictionary *)menuCategoriesInfo;

@end