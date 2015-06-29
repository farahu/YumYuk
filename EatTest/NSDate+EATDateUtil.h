
// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>

@interface NSDate (EATDateUtil)

- (NSInteger)eat_workdaysToDate:(NSDate *)toDate timeZone:(NSTimeZone *)timeZone;

@end