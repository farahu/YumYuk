// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>

#import "EATMenu.h"

/**
 @class     EATMenuParser
 @abstract  Parses a single post received from the server to produce an EATMenu object.
 */
@interface EATMenuParser : NSObject

/**
 @method    parseMenuPost:createdTime:postID:defaultCategory:
 @abstract  Parses a single post received from the server to produce an EATMenu object.
 @param
 menuPost         Text content of the post.
 @param
 createdTime      Timestamp string of the post.
 @param
 postID           The server identifier of the post.
 @param
 defaultCategory  A menu category to use for the EATMenu if one cannot be determined by the built-in parsing rules.
 @return    An EATMenu object containing data parsed from the provided input.
 */
- (EATMenu *)parseMenuPost:(NSString *)menuPost
               createdTime:(NSString *)createdTime
                    postID:(NSString *)postID
           defaultCategory:(NSString *)defaultCategory;

@end