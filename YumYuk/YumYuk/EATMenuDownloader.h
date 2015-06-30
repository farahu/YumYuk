// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>

/**
 @class     EATMenuDownloader
 @abstract  Downloads menu data from the server, parses it into EATMenu objects and returns the objects to the caller.
 */
@interface EATMenuDownloader : NSObject

/**
 @method      downloadCurrentMenus:
 @abstract    Download just enough data to get the menus for all cafes for the current meal (i.e. what's now serving).
 @discussion
 This is much faster than downloading all the available data, i.e. includings menus from days or weeks ago.
 Typically, you would perform this call first to show the most relevant data to the user quickly, before
 then downloading additional/historical data with the calls below in the background so the additional data
 is available when the user browses to it.
 @param
 callback  A callback that will be passed an array of EATMenu objects when they arrive from the server, in the order
 that they were received. If an error occured downloading data, the error parameter will be non-nil and no
 menus will be returned. The callback is NOT called on the main thread.
 */
- (void)downloadCurrentMenus:(void(^)(NSArray *menus, NSError *error))callback;

/**
 @method      downloadAllMenusAfterDate:callback:
 @abstract    Download all menus from the server after a particular date.
 @param
 date      Date to download menus after. No menus posted earlier than this date will be retrieved.
 @param
 callback  A callback that will be passed an array of EATMenu objects when they arrive from the server, in the order
 that they were received. If an error occured downloading data, the error parameter will be non-nil and no
 menus will be returned. The callback is NOT called on the main thread.
 */
- (void)downloadAllMenusAfterDate:(NSDate *)date callback:(void(^)(NSArray *menus, NSError *error))callback;

/**
 @method      downloadAllMenusBeforeDate:callback:
 @abstract
 Download enough data from the server to obtain a "reasonable" historical number of menus for all cafes
 up until a particular date.
 @discussion
 The "All" in the name might be slightly misleading - this does not download every single menu ever
 published for all cafes, rather just a "useful recent subset" of those menus - enough that the user would
 be satisifed if they wished to look back through old menus for a particular cafe.
 
 The returned data also does not include data for Sweet Stop, since Sweet Stop is fetched from a different
 data source, enough historical data is returned by downloadCurrentMenus: to make returning additional
 Sweet Stop data by this method mostly redundant.
 @param
 date      Date to download menus up to. No menus posted later than this date will be retrieved.
 @param
 callback  A callback that will be passed an array of EATMenu objects when they arrive from the server, in the order
 that they were received. If an error occured downloading data, the error parameter will be non-nil and no
 menus will be returned. The callback is NOT called on the main thread.
 */
- (void)downloadAllMenusBeforeDate:(NSDate *)date callback:(void(^)(NSArray *menus, NSError *error))callback;

@end
