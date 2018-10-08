//
//  JMAPI.m
//  Decorate
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import "JMAPI.h"
#import "NSDictionary+ValueType.h"
#import "ASIDownloadCache.h"
#import "DEBUGLOG.h"
#import "NDAlertView.h"

//const NSString *JM_API_ADDRESS = @"http://45.113.234.167:81/";
const NSString *JM_API_ADDRESS = @"http://45.113.234.167/";
const NSString *JM_FILE_ADDRESS = @"http://file.jiemeihome.com";

@implementation JMAPI

+ (BOOL)isRequestResultSuccess:(NSDictionary *)dictResult
{
    return [[dictResult stringForKeyPath:@"result"] isEqualToString:@"1"];
}

+ (NSString *)API_AddressWithPath:(NSString *)path
{
    return [NSString stringWithFormat:@"%@%@", JM_API_ADDRESS, path];
}

#pragma mark -
#pragma mark 请求

+ (ASIHTTPRequest *)downloadImageRequest:(NSString *)url
{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setSecondsToCache:60 * 60 * 24 * 30]; // cache 30 天
    
    return request;
}

+ (ASIHTTPRequest *)requestWithUrl:(NSString *)url postKeys:(NSArray *)keys postValues:(NSArray *)values
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setShouldAttemptPersistentConnection:NO];
//    [request addRequestHeader:@"terminal" value:@"ios"];
//    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    NSMutableString *postData = [NSMutableString stringWithString:@""];
    
    
    for (NSInteger i = 0; i < keys.count; ++ i)
    {
        if (i > 0)
        {
            [postData appendString:@"&"];
        }
        
        [request setPostValue:[values objectAtIndex:i] forKey:[keys objectAtIndex:i]];
        [postData appendFormat:@"%@=%@",[keys objectAtIndex:i],[values objectAtIndex:i]];
    }
    
    __unsafe_unretained ASIFormDataRequest *_request = request;
    
    [request setFailedBlock:^{
        
        [_request clearDelegatesAndCancel];
        
    }];
    
    DEBUGLOG(@"request url:%@?%@",url,postData);
    
    return request;
}

@end


