// Copyright 2004-present Facebook. All Rights Reserved.

#import "NSDate+EATDateUtil.h"

@implementation NSDate (EATDateUtil)

- (NSInteger)eat_workdaysToDate:(NSDate *)toDate timeZone:(NSTimeZone *)timeZone
{
    NSDate *fromDateZeroedTime = [self eat_zeroTime:self timeZone:timeZone];
    NSDate *toDateZeroedTime = [self eat_zeroTime:toDate timeZone:timeZone];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekCalendarUnit
                                               fromDate:fromDateZeroedTime
                                                 toDate:toDateZeroedTime
                                                options:0];
    NSInteger weeks = [components week];
    
    components = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger fromWeekday = [components weekday];
    
    components = [calendar components:NSWeekdayCalendarUnit fromDate:toDate];
    NSInteger toWeekday = [components weekday];
    
    NSInteger workdays = weeks * 5;  // Number of workdays in the whole number of weeks between the two days.
    
    // Count from the day of the week of the first date to the day of the week of the second date, counting workdays (i.e.
    // not Saturday or Sunday), and handling the wraparound case where fromWeekday > toWeekday.
    for (NSInteger i = fromWeekday; i != toWeekday; i == 7 ? i = 1 : i++) {
        // Not Saturday or Sunday
        if (i != 7 && i != 1) {
            workdays++;
        }
    }
    
    return workdays;
}

- (NSDate *)eat_zeroTime:(NSDate *)date timeZone:(NSTimeZone *)timeZone
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:timeZone];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                               fromDate:date];
    [components setMinute:0];
    [components setHour:0];
    [components setSecond:0];
    
    return [calendar dateFromComponents:components];
}

@end