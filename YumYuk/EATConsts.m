// Copyright 2004-present Facebook. All Rights Reserved.

#import "EATConsts.h"

static NSString *const kDefaultNowServing = @"Now Serving";

@implementation EATConsts

+ (NSArray *)menuCategories {
    static NSArray *categories = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        // The ordering in this array determines the canonical ordering of categories, e.g. in the left drawer.
        categories = @[kEATMenuCategoryNowServing,
                       kEATMenuCategoryCafeEpic,
                       kEATMenuCategoryCafeLTD,
                       kEATMenuCategoryCafeFullCircle,
                       kEATMenuCategoryChosHawker,
                       kEATMenuCategorySweetStop,
                       kEATMenuCategoryHackerSquare,
                       kEATMenuCategoryBurgerShack,
                       kEATMenuCategoryBBQShack,
                       kEATMenuCategoryHarvest,
                       kEATMenuCategoryPizzeria,
                       kEATMenuCategoryNachoRoyale,
                       kEATMenuCategoryNoodleBar,
                       kEATMenuCategoryMamaPennys,
                       kEATMenuCategoryOther
                       ];
    });
    return categories;
}

+ (NSSet *)categoryNames {
    static NSSet *categories = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        categories = [[NSSet alloc] initWithArray:@[@"~Enjoy~", @"Sides", @"Enjoy!", @"(Weekly Special)", @"(Pastries)", @"(Smoothie/Juice)", @"(Hot Cereal)", @"(Build Your Own Waffle Bar)", @"Weekly Specials", @"Smoothies", @"Pastries", @"Special", @"Soups", @"Eggs", @"Steamer", @"Starch", @"Vegetable", @"(Entrees)", @"(Vegetarian Dishes)", @"(Starches)", @"(Vegetables)", @"(Bread)", @"(Bread)", @"(Desserts)", @"(Soups)", @"~Entrees ~", @"~Vegetarian Entrees~", @"~Vegetable Entrees~", @"~Starches~", @"~Entrees~", @"~Vegetables~", @"~Soups~", @"~Dessert~", @"~Bread~", @"~Breads~", @"Entrée", @"Veggie Entrées", @"Starches", @"Vegetables", @"Desserts", @"Boba Tea Menu:", @"Beneficial For Health And Well-Being\"", @"Salads", @"Dip/Crackers", @"Smoothie", @"{Entrees}", @"{Sides}", @"{Dessert}", @"Cupcakes", @"Quick Breads", @"Bars", @"Mini Pie", @"Tartlet", @"Cookies"]];
    });
    return categories;
}

+ (NSInteger)indexOfCategory:(NSString *)category
{
    static NSMutableDictionary *indices = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        indices = [[NSMutableDictionary alloc] init];
        NSInteger index = 0;
        for (NSString *menuCategory in [EATConsts menuCategories]) {
            indices[menuCategory] = [NSNumber numberWithInteger:index];
            index++;
        }
    });
    return [indices[category] integerValue];
}

+ (NSInteger)indexOfCategoryInNowServing:(NSString *)category
{
    static NSDictionary *indices = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        // The values in this dictionary determines the sort ordering of menus in the Now Serving category.
        indices = @{kEATMenuCategoryCafeEpic: @0,
                    kEATMenuCategoryCafeLTD: @1,
                    kEATMenuCategoryCafeFullCircle: @2,
                    kEATMenuCategoryChosHawker: @3,
                    kEATMenuCategoryHackerSquare: @4,
                    kEATMenuCategoryBurgerShack: @5,
                    kEATMenuCategoryBBQShack: @6,
                    kEATMenuCategoryHarvest: @7,
                    kEATMenuCategoryPizzeria: @8,
                    kEATMenuCategoryNachoRoyale: @9,
                    kEATMenuCategoryNoodleBar: @10,
                    kEATMenuCategoryMamaPennys: @11,
                    kEATMenuCategoryOther: @12,
                    kEATMenuCategorySweetStop: @13
                    };
    });
    return [indices[category] integerValue];
}

+ (NSDictionary *)menuCategoriesInfo
{
    static NSDictionary *categoriesInfo = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        categoriesInfo = @{kEATMenuCategoryNowServing: @{
                                   kEATMenuCategoryInfoKeyDisplayName: kDefaultNowServing,
                                   kEATMenuCategoryInfoKeyIcon: @"Images/now_serving_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/now_serving_icon"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @NO
                                   },
                           kEATMenuCategoryCafeEpic: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Café Epic",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/epic_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/epic_0",
                                                                       @"Images/epic_1",
                                                                       @"Images/epic_2",
                                                                       @"Images/epic_1"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryCafeLTD: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Café LTD",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/ltd_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/ltd_1",
                                                                       @"Images/ltd_2",
                                                                       @"Images/ltd_3",
                                                                       @"Images/ltd_2"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryCafeFullCircle: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Café Full Circle",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/full_circle_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/full_circle_icon"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryChosHawker: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Cho's Hawker",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/chos_hawker_1",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/chos_hawker_1"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategorySweetStop: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Sweet Stop",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/sweet_stop_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/sweet_1",
                                                                       @"Images/sweet_2",
                                                                       @"Images/sweet_3",
                                                                       @"Images/sweet_2"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryHackerSquare: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Hacker Square",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/hacker_square_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/hacker_square_icon_1",
                                                                       @"Images/hacker_square_icon_2",
                                                                       @"Images/hacker_square_icon_3"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryBurgerShack: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Burger Shack",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/burger_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/burger_1",
                                                                       @"Images/burger_2",
                                                                       @"Images/burger_3"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @3,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryBBQShack: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"BBQ Shack",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/bbq_shack_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/bbq_shack_1",
                                                                       @"Images/bbq_shack_2",
                                                                       @"Images/bbq_shack_3"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @4,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryHarvest: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Harvest",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/harvest_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/Pusheen_Harvest_0",
                                                                       @"Images/Pusheen_Harvest_2",
                                                                       @"Images/Pusheen_Harvest_1",
                                                                       @"Images/Pusheen_Harvest_2",
                                                                       @"Images/Pusheen_Harvest_0",
                                                                       @"Images/Pusheen_Harvest_3",
                                                                       @"Images/Pusheen_Harvest_4",
                                                                       @"Images/Pusheen_Harvest_3"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryPizzeria: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Tony's Pizzeria",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/pizzeria_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/pizzeria_1",
                                                                       @"Images/pizzeria_2",
                                                                       @"Images/pizzeria_3",
                                                                       @"Images/pizzeria_4"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryNachoRoyale: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Nacho Royale",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/nacho_royale_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/nacho_royale_1",
                                                                       @"Images/nacho_royale_2",
                                                                       @"Images/nacho_royale_3",
                                                                       @"Images/nacho_royale_4",
                                                                       @"Images/nacho_royale_5",
                                                                       @"Images/nacho_royale_6",
                                                                       @"Images/nacho_royale_7",
                                                                       @"Images/nacho_royale_8"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryNoodleBar: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Noodle Bar",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/noodle_bar_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/noodle_bar_icon",
                                                                       @"Images/noodle_bar_icon1",
                                                                       @"Images/noodle_bar_icon2"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @4,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryMamaPennys: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Mama Penny's",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/mama_pennys_1",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/mama_pennys_1"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @YES
                                   },
                           kEATMenuCategoryOther: @{
                                   kEATMenuCategoryInfoKeyDisplayName: @"Other",
                                   kEATMenuCategoryInfoKeyIcon: @"Images/other_icon",
                                   kEATMenuCategoryInfoKeyIconArray: @[@"Images/other_1",
                                                                       @"Images/other_2",
                                                                       @"Images/other_3"],
                                   kEATMenuCategoryInfoKeyMaxWorkingDaysToKeepMenus: @5,
                                   kEATMenuCategoryInfoKeyShowHours: @NO
                                   },
                           };
    });
    return categoriesInfo;
}

@end
