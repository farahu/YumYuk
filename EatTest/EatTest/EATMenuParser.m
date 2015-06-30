// Copyright 2004-present Facebook. All Rights Reserved.

#import "EATMenuParser.h"

#import "EATConsts.h"

@implementation EATMenuParser {
    NSArray *_menuCategories;
    NSDictionary *_menuCategoriesInfo;
    
    NSRegularExpression *_regexEpic;
    NSRegularExpression *_regexLTD;
    NSRegularExpression *_regexFullCircle;
    NSRegularExpression *_regexChosHawker;
    NSRegularExpression *_regexSweetStop;
    NSRegularExpression *_regexHackerSquare;
    NSRegularExpression *_regexBurgerShack;
    NSRegularExpression *_regexBBQShack;
    NSRegularExpression *_regexHarvest;
    NSRegularExpression *_regexPizzeria;
    NSRegularExpression *_regexNachoRoyale;
    NSRegularExpression *_regexNoodleBar;
    NSRegularExpression *_regexMamaPennys;
    
    NSRegularExpression *_regexBreakfast;
    NSRegularExpression *_regexLunch;
    NSRegularExpression *_regexDinner;
    NSRegularExpression *_regexHappyHour;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _menuCategories = [EATConsts menuCategories];
        _menuCategoriesInfo = [EATConsts menuCategoriesInfo];
        
        _regexEpic = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Epic|Naan\\W*Stop)[\\s\\S]*"
                                                               options:NSRegularExpressionCaseInsensitive
                                                                 error:nil];
        _regexLTD = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Livin|L[\\W]*T[\\W]*D)[\\s\\S]*"
                                                              options:NSRegularExpressionCaseInsensitive
                                                                error:nil];
        _regexFullCircle = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Full\\W*Circle[\\s\\S]*"
                                                                     options:NSRegularExpressionCaseInsensitive
                                                                       error:nil];
        //Cho's Hawker
        _regexChosHawker = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Cho.*Hawker)[\\s\\S]*"
                                                                     options:NSRegularExpressionCaseInsensitive
                                                                       error:nil];
        _regexSweetStop = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Sweet\\W*Stop[\\s\\S]*"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
        _regexHackerSquare = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Hack.*Square|Cart|Zeke)[\\s\\S]*"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
        _regexBurgerShack = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Burger\\W*Shack[\\s\\S]*"
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:nil];
        _regexBBQShack = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Lighte?ning|BBQ\\W*Shack)[\\s\\S]*"
                                                                   options:NSRegularExpressionCaseInsensitive
                                                                     error:nil];
        _regexHarvest = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Harvest[\\s\\S]*"
                                                                  options:NSRegularExpressionCaseInsensitive
                                                                    error:nil];
        _regexPizzeria = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*(Pizz|Big\\W*Tony)[\\s\\S]*"
                                                                   options:NSRegularExpressionCaseInsensitive
                                                                     error:nil];
        _regexNachoRoyale = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Nacho[\\s\\S]*"
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:nil];
        _regexNoodleBar = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Noodle|Ramen[\\s\\S]*"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
        _regexMamaPennys = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*Mama\\W*Penny[\\s\\S]*"
                                                                     options:NSRegularExpressionCaseInsensitive
                                                                       error:nil];
        _regexBreakfast = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*breakfast[\\s\\S]*"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
        _regexLunch = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*lunch[\\s\\S]*"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];
        _regexDinner = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*dinner[\\s\\S]*"
                                                                 options:NSRegularExpressionCaseInsensitive
                                                                   error:nil];
        _regexHappyHour = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\S]*happy\\W*hour[\\s\\S]*"
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                      error:nil];
    }
    return self;
}

- (EATMenu *)parseMenuPost:(NSString *)menuPost
               createdTime:(NSString *)createdTime
                    postID:(NSString *)postID
           defaultCategory:(NSString *)defaultCategory
{
    NSString *category = [self parseCategory:menuPost defaultCategory:defaultCategory];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createdTime longLongValue]];
    NSString *mealType = [self parseMealType:menuPost category:category date:date];
    int64_t menuID = [self parseMenuID:postID];
    NSString *menuText = [menuPost stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [[EATMenu alloc] initWithMenuCategory:category
                                        mealType:mealType
                                            date:date
                                        menuText:menuText
                                          menuID:menuID];
}

- (NSString *)parseCategory:(NSString *)menuPost defaultCategory:(NSString *)defaultCategory
{
    if ([self isString:menuPost matchedByRegex:_regexEpic]) {
        return kEATMenuCategoryCafeEpic;
    } else if ([self isString:menuPost matchedByRegex:_regexLTD]) {
        return kEATMenuCategoryCafeLTD;
    } else if ([self isString:menuPost matchedByRegex:_regexFullCircle]) {
        return kEATMenuCategoryCafeFullCircle;
    } else if ([self isString:menuPost matchedByRegex:_regexChosHawker]) {
        return kEATMenuCategoryChosHawker;
    } else if ([self isString:menuPost matchedByRegex:_regexSweetStop]) {
        return kEATMenuCategorySweetStop;
    } else if ([self isString:menuPost matchedByRegex:_regexHackerSquare]) {
        return kEATMenuCategoryHackerSquare;
    } else if ([self isString:menuPost matchedByRegex:_regexBurgerShack]) {
        return kEATMenuCategoryBurgerShack;
    } else if ([self isString:menuPost matchedByRegex:_regexBBQShack]) {
        return kEATMenuCategoryBBQShack;
    } else if ([self isString:menuPost matchedByRegex:_regexHarvest]) {
        return kEATMenuCategoryHarvest;
    } else if ([self isString:menuPost matchedByRegex:_regexPizzeria]) {
        return kEATMenuCategoryPizzeria;
    } else if ([self isString:menuPost matchedByRegex:_regexNachoRoyale]) {
        return kEATMenuCategoryNachoRoyale;
    } else if ([self isString:menuPost matchedByRegex:_regexNoodleBar]) {
        return kEATMenuCategoryNoodleBar;
    } else if ([self isString:menuPost matchedByRegex:_regexMamaPennys] ) {
        return kEATMenuCategoryMamaPennys;
    } else {
        return defaultCategory;
    }
}

- (NSString *)parseMealType:(NSString *)menuPost category:(NSString *)category date:(NSDate *)date
{
    // Parse lunch before breakfast to handle cases such as "Breakfast for Lunch", which is a lunch meal, not breakfast.
    if ([self isString:menuPost matchedByRegex:_regexLunch]) {
        return kEATMealTypeLunch;
    } else if ([self isString:menuPost matchedByRegex:_regexBreakfast]) {
        return kEATMealTypeBreakfast;
    } else if ([self isString:menuPost matchedByRegex:_regexDinner]) {
        return kEATMealTypeDinner;
    } else if ([self isString:menuPost matchedByRegex:_regexHappyHour]) {
        return kEATMealTypeHappyHour;
        
        // Restaurant defaults.
    } else if (category == kEATMenuCategorySweetStop) {
        return kEATMealTypeDessert;
    } else if (category == kEATMenuCategoryHackerSquare ||
               category == kEATMenuCategoryBurgerShack ||
               category == kEATMenuCategoryBBQShack ||
               category == kEATMenuCategoryPizzeria ||
               category == kEATMenuCategoryNachoRoyale ||
               category == kEATMenuCategoryNoodleBar) {
        return kEATMealTypeLunch;
        
    } else {
        // Use hour of the post to figure out the meal type.
        NSInteger hour = [self hourOfDate:date];
        if (hour < 9) {
            return kEATMealTypeBreakfast;
        } else if (hour < 14) {
            return kEATMealTypeLunch;
        } else {
            return kEATMealTypeDinner;
        }
    }
}

- (int64_t)parseMenuID:(NSString *)postID
{
    // postIDs are in the form of pageID_messageID. We use messageID as a unique permanent key to identify a particular
    // menu for synchronization, etc.
    NSArray *postIDComponents = [postID componentsSeparatedByString:@"_"];
    if ([postIDComponents count] == 2) {
        NSString *messageID = postIDComponents[1];
        return [messageID longLongValue];
    } else {
        return 0;
    }
}

- (BOOL)isString:(NSString *)string matchedByRegex:(NSRegularExpression *)regex
{
    // For quick parsing, use just the first 100 characters.
    NSTextCheckingResult *result = [regex firstMatchInString:string
                                                     options:0
                                                       range:NSMakeRange(0, MIN([string length], 100))];
    return result && result.range.location != NSNotFound;
}

- (NSInteger)hourOfDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"H"
                                                             options:0
                                                              locale:[NSLocale currentLocale]]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    
    return [[formatter stringFromDate:date] intValue];
}

@end