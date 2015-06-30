// Copyright 2004-present Facebook. All Rights Reserved.

#import "EATMenuDownloader.h"

#import "EATConsts.h"
#import "EATMenuParser.h"

static NSString *const kEndPointFormat = @"https://graph.facebook.com/fql?q=%@&access_token=%@";

static NSString *const kFBCulinaryTeamQueryFormat = @"SELECT post_id, message, created_time, attachment FROM stream WHERE source_id=80518126820 and (type=46 or type=247) %@ ORDER BY created_time DESC %@";
static NSString *const kSweetStopQueryFormat = @"SELECT post_id, message, created_time, attachment FROM stream WHERE source_id=466600463385643 and (type=46 or type=247) %@ ORDER BY created_time DESC LIMIT 10";

static NSString *const kQueryFormat1 = @"{\"query1\":\"%@\"}";
static NSString *const kQueryFormat2 = @"{\"query1\":\"%@\",\"query2\":\"%@\"}";

static NSInteger const kCurrentMenusQueryLimit = 10;
static NSInteger const kAllMenusBeforeDateQueryLimit = 100;

@implementation EATMenuDownloader {
    EATMenuParser *_parser;
    NSOperationQueue *_queue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parser = [[EATMenuParser alloc] init];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)downloadCurrentMenus:(void (^)(NSArray *menus, NSError*error))callback
{
    NSString *limitClause = [NSString stringWithFormat:@"LIMIT %lu", (long)kCurrentMenusQueryLimit];
    [self downloadMenusWithAdditionalWhereClause:@"" limitClause:limitClause callback:callback];
}

- (void)downloadAllMenusAfterDate:(NSDate *)date callback:(void (^)(NSArray *menus, NSError*error))callback
{
    long time = [date timeIntervalSince1970];
    NSString *createdTimeCondition = [NSString stringWithFormat:@"and created_time > %lu", time];
    [self downloadMenusWithAdditionalWhereClause:createdTimeCondition limitClause:@"" callback:callback];
}

- (void)downloadAllMenusBeforeDate:(NSDate *)date callback:(void (^)(NSArray *menus, NSError*error))callback
{
    long time = [date timeIntervalSince1970];
    NSString *createdTimeCondition = [NSString stringWithFormat:@"and created_time < %lu", time];
    NSString *limitClause = [NSString stringWithFormat:@"LIMIT %lu", (long)kAllMenusBeforeDateQueryLimit];
    
    NSString *query1 = [NSString stringWithFormat:kFBCulinaryTeamQueryFormat, createdTimeCondition, limitClause];
    NSString *query = [NSString stringWithFormat:kQueryFormat1, query1];
    
    [self downloadMenusWithQuery:query callback:callback];
}

- (void)downloadMenusWithAdditionalWhereClause:(NSString *)whereClause
                                   limitClause:(NSString *)limitClause
                                      callback:(void (^)(NSArray *menus, NSError*error))callback
{
    NSString *query1 = [NSString stringWithFormat:kFBCulinaryTeamQueryFormat, whereClause, limitClause];
    NSString *query2 = [NSString stringWithFormat:kSweetStopQueryFormat, whereClause];
    NSString *query = [NSString stringWithFormat:kQueryFormat2, query1, query2];
    
    [self downloadMenusWithQuery:query callback:callback];
}

- (void)downloadMenusWithQuery:(NSString *)query callback:(void(^)(NSArray *menus, NSError*error))callback
{
    NSString *url = [NSString stringWithFormat:kEndPointFormat,
                     [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                     [kEATAccessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *resp = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:nil];
    [self parseResponseData:data callback:callback];
}

#pragma mark - Methods NOT on main thread

- (void)parseResponseData:(NSData *)data callback:(void(^)(NSArray *menus, NSError*error))callback
{
    NSError *error = nil;
    id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        callback(nil, error);
    } else {
        NSArray *menus = [self parseResponse:response];
        callback(menus, nil);
    }
}

- (NSArray *)parseResponse:(NSDictionary *)response
{
    NSMutableArray *menus = [[NSMutableArray alloc] init];
    
    for (NSDictionary *query in response[@"data"]) {
        NSString *defaultCategory = kEATMenuCategoryOther;
        if ([query[@"name"] isEqualToString:@"query2"]) {
            defaultCategory = kEATMenuCategorySweetStop;
        }
        
        for (NSDictionary *item in query[@"fql_result_set"]) {
            [menus addObject:[_parser parseMenuPost:item[@"message"]
                                        createdTime:item[@"created_time"]
                                             postID:item[@"post_id"]
                                    defaultCategory:defaultCategory]];
        }
    }
    
    return menus;
}

@end
